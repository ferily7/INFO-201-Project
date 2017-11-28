library(dplyr)
library(plotly)
library(ggplot2)

source('dataset.R')

# Creating a bar chart showing number of cyber breaches in each organization based on type 
OrgBarChart <- function(breaches, choice){
  
  # Filtering data by input choice
  type.of.org <- breaches  %>%
    filter(type_org == choice)
  
  # Make Bar graph
  plot_ly(x = type.of.org$records_lost, y = type.of.org$entity_name, type = 'bar') %>% 
    layout(margin = list(l = 300))
}