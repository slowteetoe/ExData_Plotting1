# Obtain the appropriate data subset, including headers by running the following from a unix/linux/osx command line:
# head -n 1 household_power_consumption.txt > data.txt; cat household_power_consumption.txt | grep "^[12]/2/2007" >> data.txt
# This will create a file named 'data.txt'
library(data.table)

rm(list=ls())
dt <- fread("data.txt", sep=";", na.strings="?")
# handle date/time
dtobj <- strptime(paste(dt$Date,dt$Time),format="%d/%m/%Y %H:%M:%S", tz="")
# not sure why, but data.table doesn't like POSIXlt so this was an easy way to fix
suppressWarnings(
	d <- data.table(dtobj)
)
dt[,datetime:=d[,dtobj]]
plot(dt$datetime, dt$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
dev.copy(png, "plot2.png", width=480, height=480, units="px", res=100)
dev.off()