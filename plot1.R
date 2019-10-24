## read the data
library(dplyr)
library(lubridate)

power_data <- read.table("./data/household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")
power_data <- power_data %>%
    mutate(Date = dmy(Date)) %>%
    filter(Date >= ymd("2007-02-01") & Date <= ymd("2007-02-02")) %>%
    mutate(datetime = as_datetime(paste(Date, Time))) %>%
    select(datetime, everything(), -Date, -Time)

## create the .png file
png("plot1.png")

## plot a histogram of the global active power
hist(power_data$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

## close the file
dev.off()