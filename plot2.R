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
png("plot2.png")

## plot a line plot of the global active power vs. time
plot(power_data$datetime, power_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)")

## close the file
dev.off()