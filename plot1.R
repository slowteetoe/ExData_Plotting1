# Uncomment the following two lines to download and unzip the file
# download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method="curl")
# unzip("household_power_consumption.zip")

# Copy the appropriate data subset, including headers, into a file called 'data.txt' by running the following from a unix/linux/osx command line:
# head -n 1 household_power_consumption.txt > data.txt; cat household_power_consumption.txt | grep "^[12]/2/2007" >> data.txt

rm(list=ls())

library(data.table)

data <- fread("data.txt", sep=";", na.strings="?")

hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red", breaks=seq(0,8,by=0.5), xlim=c(0,6), ylim=c(0,1200), xaxt="n")

axis(side=1, at=c(0, 2, 4, 6))

dev.copy(png, "plot1.png", width=480, height=480, units="px", res=100)
dev.off()