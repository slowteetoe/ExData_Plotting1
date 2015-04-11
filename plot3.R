# Uncomment the following two lines to download and unzip the file
# download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method="curl")
# unzip("household_power_consumption.zip")

# Copy the appropriate data subset, including headers, into a file called 'data.txt' by running the following from a unix/linux/osx command line:
# head -n 1 household_power_consumption.txt > data.txt; cat household_power_consumption.txt | grep "^[12]/2/2007" >> data.txt

library(data.table)

dt <- fread("data.txt", sep=";", na.strings="?")

dtobj <- strptime(paste(dt$Date,dt$Time),format="%d/%m/%Y %H:%M:%S", tz="")
# not sure why, but data.table doesn't like POSIXlt so this was an easy way to fix
suppressWarnings(
	d <- data.table(dtobj)
)
dt[,datetime:=d[,dtobj]]

# find the ranges for x and y since we'll be drawing multiple lines
xrange <- range(dt$datetime)
yrange <- range(dt$Sub_metering_1, dt$Sub_metering_2, dt$Sub_metering_3)
plot(xrange, yrange, xlab="", ylab="Energy sub metering", type="n")
lines(dt$datetime, dt$Sub_metering_1, col="black")
lines(dt$datetime, dt$Sub_metering_2, col="red")
lines(dt$datetime, dt$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))

dev.copy(png, "plot3.png", width=480, height=480, units="px", res=50)
dev.off()