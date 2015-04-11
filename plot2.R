# Uncomment the following two lines to download and unzip the file
# download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="household_power_consumption.zip", method="curl")
# unzip("household_power_consumption.zip")

# Copy the appropriate data subset, including headers, into a file called 'data.txt' by running the following from a unix/linux/osx command line:
# head -n 1 household_power_consumption.txt > data.txt; cat household_power_consumption.txt | grep "^[12]/2/2007" >> data.txt

library(data.table)

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