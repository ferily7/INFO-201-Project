library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)

source('dataset.r')

df.year.test <- breaches %>% group_by(leak_method) %>% summarise(count=n())
