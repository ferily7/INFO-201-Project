library(dplyr)
library(plotly)
library(ggplot2)

breaches <- read.csv("./data/data_breaches.csv", stringsAsFactors = FALSE)

# Transform and edit dataset to add clarity and ease of use
# 13 = year of 2017, 14 = recently -- group these as a whole
breaches$year[breaches$year == 14] <- 13 
breaches$year <- breaches$year + 2004

# Drop records_lost col due to superior measure records_lost_v2 col, then rename
breaches <- breaches %>% select(-records_lost) %>% rename(records_lost = records_lost_v2)

# Select random story from interesting list
top.stories <- breaches %>% filter(interesting == "y")
story <- top.stories[sample(nrow(top.stories), 1), ]


# Convert data_sensitivity column from integers to specific strings
breaches$data_sensitivity[breaches$data_sensitivity == 1] <- "General online info"
breaches$data_sensitivity[breaches$data_sensitivity == 20] <- "Sensitive PII"
breaches$data_sensitivity[breaches$data_sensitivity == 300] <- "Credit card info"
breaches$data_sensitivity[breaches$data_sensitivity == 4000] <- "Email credentials, health records"
breaches$data_sensitivity[breaches$data_sensitivity == 50000] <- "Bank account details"
