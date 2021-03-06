## This script implements Exporatory Data Analysis Course Project1 plot3, a multiline graph 
## of Energy Sub_metering 1, 2, and 3 vs. Time. 
## It reads the "household.power.consumptioon.txt" file into a data frame, and subsets it
## to the two day period from 2007-02-01 to 2007-02-02.  It converts the subset data frame
## Date and Time columns to Date and POSIXlt formats, and all the power metrics to numeric.

## The source file must be present in the working directory.
########################################
print("plot3.R running")
library(dplyr)
library(tidyr)
household.power <- read.table("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors=FALSE)

## allow the use of the dplyr filter function and subset to the 2 days in February 2007
household.power <- tbl_df(household.power)
household.power.2days <- filter(household.power, Date == "1/2/2007" | Date == "2/2/2007")

## convert the Date column
household.power.2days$Date <- as.Date(household.power.2days$Date, format = "%d/%m/%Y")

## paste Date and Time to dallow use of strptime()
dt.time <- paste(household.power.2days$Date, household.power.2days$Time)
convrt.dt.tm <- strptime(dt.time, format = "%Y-%m-%d %H:%M:%S")

## set the Time column to the converted POSIXlt format
household.power.2days$Time <- convrt.dt.tm

## convert all the power usage metrics to numerics
household.power.2days$Global_active_power  <- as.numeric(household.power.2days$Global_active_power)
household.power.2days$Global_reactive_power  <- as.numeric(household.power.2days$Global_reactive_power)
household.power.2days$Voltage  <- as.numeric(household.power.2days$Voltage)
household.power.2days$Global_intensity  <- as.numeric(household.power.2days$Global_intensity)
household.power.2days$Sub_metering_1  <- as.numeric(household.power.2days$Sub_metering_1)
household.power.2days$Sub_metering_2  <- as.numeric(household.power.2days$Sub_metering_2)

#################################################
## open the PNG grahic device with a widthe of 480 pixels and a height of 480 pixels. Save the plot 
## plot to plot3.png

png(filename = "plot3.png", width = 480, height = 480)

## Distinguish Sub_metering 1, 2, and 3 by colors black, red, and blue respectively.
## scale to the minimum and maximum values of Sub_metering_1, 0 to 38.
with(household.power.2days, {
        plot(Time, Sub_metering_1, type = "l", ylim=c(0.0,38.0), ylab = "Energy sub metering", xlab = "",col = "black")
        lines(Time, Sub_metering_2, type  = "l", ylim=c(0.0,38.0), ylab = "", xlab = "",col = "red")
        lines(Time, Sub_metering_3,type  ="l", ylim=c(0.0,38.0), ylab = "", xlab = "",col = "blue")
        legend("topright", lty = c(1,1), cex = 1.0 , col = c("black","red","blue"), legend = c("Sub metering_1", "Sub metering_2", "Sub metering_3")) 
})
dev.off()

print("plot3.R finished")
########################################
