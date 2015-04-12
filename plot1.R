# Uncomment the following two lines to download and unzip the file

library(data.table)

download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method="curl")

unzip("household_power_consumption.zip")

alldata <- fread("household_power_consumption.txt", sep=";", na.strings="?")

data <- alldata[alldata$Date=="1/2/2007"|alldata$Date=="2/2/2007",]

# fix global active power, it's supposed to be numeric
data <- data[, Global_active_power:=as.numeric(Global_active_power)]

png("plot1.png", width=480, height=480, units="px", bg = "transparent")

hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red", breaks=seq(0,8,by=0.5), xlim=c(0,6), ylim=c(0,1200), xaxt="n")

axis(side=1, at=c(0, 2, 4, 6))

dev.off()