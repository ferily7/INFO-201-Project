library(dplyr)
library(plotrix)

setwd("~/Desktop/INFO201/INFO-201-Project")

breaches <- read.csv(file = "data/data_breaches.csv", stringsAsFactors = FALSE)


get.org <- breaches %>% 
  group_by(type_org) %>%
  summarize(count = n()) 
  
total.count <- sum(get.org$count)

get.org <- get.org %>%
  mutate(percent = round((count * 100)/total.count, digits = 2))

labels <- paste0(get.org$type_org, " ", get.org$percent, "%")

jpeg('data/pie_chart.jpg')
pie3D(get.org$percent, labels = labels, explode = 0.2, labelcex = 0.7, theta = pi/6)
dev.off()