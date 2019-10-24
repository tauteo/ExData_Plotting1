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
png("plot4.png")

## create a 2x2 grid for placing plots, fill rows first
par(mfrow = c(2,2))

## (1,1) plot a line plot of global active power vs. datetime
plot(power_data$datetime, power_data$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")

## (1,2) plot a line plot of Voltage vs. datetime
plot(power_data$datetime, power_data$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")

## (2,1) plot line plots of energy sub metering
with(power_data, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l"))
with(power_data, points(datetime, Sub_metering_2, col = "red", type = "l"))
with(power_data, points(datetime, Sub_metering_3, col = "blue", type = "l"))
legend("topright", 
       col = c("black", "red", "blue"), 
       legend = vars_select(names(power_data), starts_with("Sub")),
       lty = "solid",
       bty = "n")

## (2,2) plot a line plot of global reactive power vs. datetime
plot(power_data$datetime, power_data$Global_reactive_power, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Global_reactive_power")

## close the file
dev.off()