####Downloading and rreading the file 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "file1.zip")
data <- read.csv2(unzip("file1.zip"), colClasses = "character")

####Subsetting data for those dates we are interested in 
two_days <- subset(data, Date=="2/2/2007" | Date=="1/2/2007")

####Converting data type to Date/Time class
two_days$Time <- strptime(paste(two_days$Date,two_days$Time), format="%d/%m/%Y %H:%M:%S")
two_days$Date <- as.Date(two_days$Date,format="%d/%m/%Y")

png(filename = "plot4.png")
par(mfrow=c(2,2))
with(two_days,{
        plot(Time,as.numeric(Global_active_power), type = "l", ylab = "Global Active Power",xlab="")
        plot(Time,as.numeric(Voltage), type = "l", ylab = "Voltage",xlab="datetime")
        plot(Time,as.numeric(Sub_metering_1), type = "l", ylab = "Energy sub metering",xlab="")
        lines(Time,as.numeric(Sub_metering_2), col="red")
        lines(Time,as.numeric(Sub_metering_3), col="blue")
        legend("topright", legend = names(two_days[,7:9]),col = c("black","red","blue"), lty=1,bty="n")
        plot(Time,Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()