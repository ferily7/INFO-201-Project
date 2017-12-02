##Bar graph based on the years 

library(dplyr)
library(plotly)
library(ggplot2)

source('angie.data.R')

MakeBarChart <- function(datatype) {

  return (plot_ly(datatype, values = ~count, labels = ~leak_method, type = 'pie') %>%
         layout(title = 'Year vs. Leak Information',
                xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
                yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)))
}
