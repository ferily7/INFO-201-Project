library(dplyr)

data <- read.csv("data/data_breaches.csv", stringsAsFactors = FALSE)
# Transform and edit dataset to add clarity and ease of use
# 13 = year of 2017, 14 = recently -- group these as a whole
data$year[data$year == 14] <- 13 
data$year <- data$year + 2004
# Drop records_lost col due to superior measure records_lost_v2 col, then rename
data <- data %>% select(-records_lost) %>% rename(records_lost = records_lost_v2)
# Could display a quick "headline" story about one of these data breaches listed as "interesting"?
top.stories <- data %>% filter(interesting == "y") %>% select(description)
