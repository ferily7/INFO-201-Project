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
# Convert data_sensitivity column from integers to specific strings
data$data_sensitivity[data$data_sensitivity == 1] <- "General online info"
data$data_sensitivity[data$data_sensitivity == 20] <- "Sensitive PII"
data$data_sensitivity[data$data_sensitivity == 300] <- "Credit card info"
data$data_sensitivity[data$data_sensitivity == 4000] <- "Email credentials, health records"
data$data_sensitivity[data$data_sensitivity == 50000] <- "Bank account details"
