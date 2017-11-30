library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)

source('dataset.R')

shinyServer(function(input, output) {
  
  # Create bar graph of the cyber breaches based on the type of organization
  output$selectBox <- renderPlotly({
    # Filtering data by input choice
    type.of.org <- breaches  %>%  
      filter(type_org == input$choice)
    
    # Make Bar graph
    plot_ly(x = type.of.org$records_lost, y = type.of.org$entity_name, type = 'bar') %>% 
      layout(margin = list(l = 300))
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
})

