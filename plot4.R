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

png("plot4.png", width=480, height=480, units="px", bg = "transparent")

# 2 rows, 2 cols of graphs
par(mfrow=c(2,2))

# 1st plot is basically plot2 with a slightly shorter Y-label
plot(dt$datetime, dt$Global_active_power, xlab="", ylab="Global Active Power", type="l")

# 2nd plot
plot(dt$datetime, dt$Voltage, xlab="datetime", ylab="Voltage", type="l")

# 3rd plot is basically plot3 without a box around the legend
xrange <- range(dt$datetime)
yrange <- range(dt$Sub_metering_1, dt$Sub_metering_2, dt$Sub_metering_3)
plot(xrange, yrange, xlab="", ylab="Energy sub metering", type="n")
lines(dt$datetime, dt$Sub_metering_1, col="black")
lines(dt$datetime, dt$Sub_metering_2, col="red")
lines(dt$datetime, dt$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"), bty="n")

# 4th plot
plot(dt$datetime, dt$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()