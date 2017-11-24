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
  
})

