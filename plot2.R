library(data.table)

download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method="curl")

unzip("household_power_consumption.zip")

alldata <- fread("household_power_consumption.txt", sep=";", na.strings="?")

dt <- alldata[alldata$Date=="1/2/2007"|alldata$Date=="2/2/2007",]

# handle date/time
dtobj <- strptime(paste(dt$Date,dt$Time),format="%d/%m/%Y %H:%M:%S", tz="")
# not sure why, but data.table doesn't like POSIXlt so this was an easy way to fix
suppressWarnings(
	d <- data.table(dtobj)
)
dt[,datetime:=d[,dtobj]]

png("plot2.png", width=480, height=480, units="px", bg = "transparent")

plot(dt$datetime, dt$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")

dev.off()