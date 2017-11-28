library(dplyr)
library(plotly)

setwd("~/Desktop/INFO201/INFO-201-Project")

breaches <- read.csv(file = "data/data_breaches.csv", stringsAsFactors = FALSE)


get.org <- breaches %>% 
  group_by(type_org) %>%
  summarize(count = n()) 
  

plot_ly(get.org, values = ~count, labels = ~type_org, type = "pie" ) %>%
  layout(title = 'Type of Organizations affected by the data breaches',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))