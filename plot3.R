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
png("plot3.png")

## plot a line plot of the sub metering 1 vs. datetime
with(power_data, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
## add a line plot of sub metering 2 vs. datetime
with(power_data, points(datetime, Sub_metering_2, col = "red", type = "l"))
## add a line plot of sub metering 3 vs. datetime
with(power_data, points(datetime, Sub_metering_3, col = "blue", type = "l"))
## add a legend
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = vars_select(names(power_data), starts_with("Sub")),
       lty = "solid")

## close the file
dev.off()