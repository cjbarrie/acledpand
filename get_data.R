library(tidyverse)
library(acled.api)
library(zoo)

Sys.setenv(EMAIL_ADDRESS="ENTER EMAIL ADDRESS STRING HERE")
Sys.setenv(ACCESS_KEY="ENTER ACCESS KEY HERE")

data <- acled.api(country = NULL,
          region = NULL,
          start.date = "2017-01-01",
          end.date = "2021-01-01",
          add.variables = NULL,
          all.variables = FALSE,
          dyadic = FALSE,
          other.query = NULL)

data$date <- as.Date(data$event_date)
data$yrmonth <- as.yearmon(data$date)
data$yrmonth <- as.Date(data$yrmonth)

saveRDS(data, file = "acled1720.RDS")