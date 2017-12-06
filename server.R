library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)

source('dataset.R')
shinyServer(function(input, output) {
  
  # Create bar graph of the cyber breaches based on the type of organization
  output$barGraph <- renderPlotly({
    if(input$filter != 'all'){
      # Filtering data by input choice
      type.of.org <- breaches  %>%
        filter(type_org == input$filter)
    } else{
      type.of.org <- breaches   
    }
    
    if(nrow(type.of.org) > 10){
      type.of.org <- arrange(type.of.org, -records_lost)
    }
    
    top.ten <- head(type.of.org, 10)
    
    # Combining duplicates in the dataframe together
    top.ten <- top.ten %>% group_by(entity_name) %>% summarize(records_lost = sum(records_lost))
    
    top.ten$abbreviation <- ifelse(nchar(top.ten$entity_name) > 20, abbreviate(top.ten$entity_name), top.ten$entity_name)  
    top.ten$abbreviation <- factor(top.ten$abbreviation, levels = unique(top.ten$abbreviation)[order(as.numeric(top.ten$records_lost), decreasing = FALSE)])

    # Make Bar graph
    plot_ly(x = top.ten$records_lost, y = top.ten$abbreviation, type = 'bar', marker = list(color = 'rgb(96, 133, 132)'), text = ifelse(nchar(top.ten$entity_name) > 20, top.ten$entity_name, "")) %>% 
      layout(title = "Top 10 Highest Cyber Breaches by Organization", margin = list(l = 150, r = 20))
  })
  
  # Create time series of data breaches from 2003 to 2014
  output$timeSeries <- renderPlotly({
    # Format dates for time series
    if (input$filter != 'all') {
      grouped_breaches <- breaches %>% filter(type_org == input$filter) %>% 
        group_by(year) %>%
        summarise(counts = n())
    } else {
      grouped_breaches <- breaches %>% 
        group_by(year) %>%
        summarise(counts = n())
    }
    # Isolate counts and year to function as hover label
    counts <- grouped_breaches$counts
    year <- grouped_breaches$year
    
    # Develop linear regression model
    fit <- lm(counts ~ year, data = grouped_breaches)
    
    # Make time series
    plot_ly(grouped_breaches, x = year, y = counts, type = "scatter", mode = "lines",
            text = paste(counts, "breaches observed in", year)) %>%
      add_trace(x = year, y = fitted(fit), mode = "lines") %>%
      layout(title = "Number of Data Breaches From 2004 - 2017",
             xaxis = list(title = "Year (2003 - 2017)"),
             yaxis = list(title = "Number of data breaches"))
  })
  # creates pie chart displaying the leak method depending on the year
  output$distplot <- renderPlotly({
    slider.year <- breaches %>% filter(year == input$obs) %>%
      group_by(leak_method) %>% summarise(count=n())
    colors <- reactive({
      return ( c('rgb(234, 234, 227)','rgb(96, 133, 132)','rgb(114, 96, 103)','rgb(115, 132, 145)','rgb(43, 43, 49)') )
    })
    
    plot_ly(slider.year, values = ~count, labels = ~leak_method, type = 'pie',
            marker = list(colors = colors(),line = list(color = '#FFFFFF', width = 1))) %>%
      layout(title = 'Information Leak Method Based On Year',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
  })
  
  output$pie <- renderPlotly({
    # Group data sensitivity according to the selected year. 
    get.data_sensitivity <- breaches %>% filter(input$obs == year) %>% 
      group_by(data_sensitivity) %>% 
      summarize(count = n())
    colors.2 <- reactive({
      return ( c('rgb(234, 234, 227)','rgb(96, 133, 132)','rgb(114, 96, 103)','rgb(115, 132, 145)','rgb(43, 43, 49)') )
    })
    
    # create a pie chart to show the data sensitivity in a particular year 
    plot_ly(get.data_sensitivity, values = ~count, labels = ~data_sensitivity, type = "pie",
            marker = list(colors = colors.2(),line = list(color = '#FFFFFF', width = 1))) %>%
      layout(title = 'Data Sensitivity by Year',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  })
  
  # Creating a heap map of the breach type and data sensitivity
  output$heatMap <- renderPlotly({
    xval <- unique(breaches$leak_method)
    yval <- unique(breaches$data_sensitivity)
    
    # Make matrix of cateogircal axes
    m <- matrix(0, nrow = length(yval), ncol = length(xval))
    
    for(i in 1:length(yval)) {
      for(j in 1:length(xval)){
        temp <- filter(breaches,leak_method==xval[j]) %>%
                  filter(data_sensitivity==yval[i])
        m[i,j] <- nrow(temp)
      }
    }
    
    custom_txt <- paste0('Leak Method: ', xval,
                        '<br>Data Sensitivity: ', yval,
                        '<br>Number of Breaches: ', m)
    custom_txt <- matrix(unlist(custom_txt), nrow = length(yval), ncol = length(xval))
      
    # Make HeatMap

    p <- plot_ly(
      x = xval, y = yval,
      z = m, type = "heatmap", colors = colorRamp(c("#eaeae3","#608584")),
      hoverinfo="text",
      text=custom_txt
    ) %>%
      layout(title="Heatmap of Breach Type and Data Sensitivity", margin=list(l=230,b=150))
  })
})

