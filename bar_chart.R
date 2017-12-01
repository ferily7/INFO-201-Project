library(dplyr)
library(plotly)
library(ggplot2)

source('dataset.R')

# Creating a bar chart showing number of cyber breaches in each organization based on type 
#OrgBarChart <- function(breaches, choice){
  
  # Filtering data by input choice
  type.of.org <- breaches  %>%
    filter(type_org == "government")
  
  if(nrow(type.of.org) > 10){
    type.of.org <- arrange(type.of.org, -records_lost)
  }
  
  top.ten <- head(type.of.org, 10)

  #top.ten$abbreviation <- ifelse(nchar(top.ten$entity_name) > 25, paste0(substring(top.ten$entity_name, 0, 25), "..."), "NA")
  #top.ten$abbreviation <- ifelse(nchar(top.ten$entity_name) > 25, abbreviate(top.ten$entity_name), "NA")
  top.ten$abbreviation <- ifelse(nchar(top.ten$entity_name) > 20, abbreviate(top.ten$entity_name), top.ten$entity_name)  
  
  # Make Bar graph
  plot_ly(x = top.ten$records_lost, y = top.ten$abbreviation, type = 'bar', text = ifelse(nchar(top.ten$entity_name) > 20, top.ten$entity_name, "")) %>% 
    layout(margin = list(l = 150))
#}