library(data.table)

download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method="curl")

unzip("household_power_consumption.zip")

alldata <- fread("household_power_consumption.txt", sep=";", na.strings="?")

dt <- alldata[alldata$Date=="1/2/2007"|alldata$Date=="2/2/2007",]

dtobj <- strptime(paste(dt$Date,dt$Time),format="%d/%m/%Y %H:%M:%S", tz="")
# not sure why, but data.table doesn't like POSIXlt so this was an easy way to fix
suppressWarnings(
	d <- data.table(dtobj)
)
dt[,datetime:=d[,dtobj]]
# coerce metering to numeric
dt <- dt[, Sub_metering_1:=as.numeric(Sub_metering_1)]
dt <- dt[, Sub_metering_2:=as.numeric(Sub_metering_2)]
dt <- dt[, Sub_metering_3:=as.numeric(Sub_metering_3)]

png("plot3.png", width=480, height=480, units="px", bg = "transparent")

# find the ranges for x and y since we'll be drawing multiple lines
xrange <- range(dt$datetime)
yrange <- range(dt$Sub_metering_1, dt$Sub_metering_2, dt$Sub_metering_3)
plot(xrange, yrange, xlab="", ylab="Energy sub metering", type="n")
lines(dt$datetime, dt$Sub_metering_1, col="black")
lines(dt$datetime, dt$Sub_metering_2, col="red")
lines(dt$datetime, dt$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black","red","blue"))

dev.off()