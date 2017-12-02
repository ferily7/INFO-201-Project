library(dplyr)
library(plotly)

source('dataset.R')

get.org <- breaches %>% 
  group_by(type_org) %>%
  summarize(count = n()) 
  

plot_ly(get.org, values = ~count, labels = ~type_org, type = "pie" ) %>%
  layout(title = 'Type of Organizations Affected by the Data Breaches',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))