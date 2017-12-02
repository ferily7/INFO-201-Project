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
  
  output$distplot <- renderPlotly({
    
    slider.year <- breaches %>% filter(year == input$obs) %>%
      group_by(leak_method) %>% summarise(count=n())
    colors <- reactive({
      return ( c('rgb(176, 208, 211)','rgb(192, 132, 151)','rgb(247, 175, 157)','rgb(247, 227, 175)','rgb(145, 175, 132)') )
      
    })
    
    plot_ly(slider.year, values = ~count, labels = ~leak_method, type = 'pie',
            marker = list(colors = colors(),line = list(color = '#FFFFFF', width = 1))) %>%
      layout(title = 'Information Leak Method Based On Year',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    
  })
  
  
})

