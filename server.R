library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)

source('dataset.R')

shinyServer(function(input, output) {
  
  # Create bar graph of the cyber breaches based on the type of organization
  output$selectBox <- renderPlotly({
    
    # Passing dataset and input choice to function
    #OrgBarChart(breaches, input$choice)

  })
  
})

