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
    }
    else{
      type.of.org <- breaches   
    }
    
    if(nrow(type.of.org) > 10){
      type.of.org <- arrange(type.of.org, -records_lost)
    }
    
    top.ten <- head(type.of.org, 10)
    top.ten$abbreviation <- ifelse(nchar(top.ten$entity_name) > 20, abbreviate(top.ten$entity_name), top.ten$entity_name)  
    
    # Make Bar graph
    plot_ly(x = top.ten$records_lost, y = top.ten$abbreviation, type = 'bar', text = ifelse(nchar(top.ten$entity_name) > 20, top.ten$entity_name, "")) %>% 
      layout(title = "Top 10 Highest Cyber Breaches by Organization", margin = list(l = 150))
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
      layout(title = "How do data breaches behave over time?",
             xaxis = list(title = "Year (2003 - 2017)"),
             yaxis = list(title = "Number of data breaches"))
  })
  
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
      z = m, type = "heatmap",
      hoverinfo="text",
      text=custom_txt
    ) %>%
      layout(title="Heatmap of Breach Type and Data Sensitivity", margin=list(l=230,b=150))
  })
})

