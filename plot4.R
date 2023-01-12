# Read data
hpc <- read.table("household_power_consumption.txt",skip=1,sep=";")
# rename columns
colnames(hpc) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                   "Sub_metering_1","Sub_metering_2","Sub_metering_3")
# subset data
hpc <- hpc[hpc$Date=="1/2/2007" | hpc$Date =="2/2/2007",]

# cast Date as "as.date"
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

# cast and format time
hpc$Time <- strptime(hpc$Time, format="%H:%M:%S")
hpc[1:1440,"Time"] <- format(hpc[1:1440,"Time"],"2007-02-01 %H:%M:%S")
hpc[1441:2880,"Time"] <- format(hpc[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

# cast character columns in numeric columns
global_active_power <- as.numeric(hpc$Global_active_power)
voltage <- as.numeric(hpc$Voltage)
sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
global_reactive_power <- as.numeric(hpc$Global_reactive_power)

# save plot
png(file="plot4.png",width=480, height=480)

# Plot 4
par(mfrow=c(2,2))

plot(hpc$Time,global_active_power,type="l",  xlab="",ylab="Global Active Power")  
plot(hpc$Time,voltage, type="l",xlab="datetime",ylab="Voltage")
plot(hpc$Time,hpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(hpc$Time, sub_metering_1,col="black")
lines(hpc$Time, sub_metering_2,col="red")
lines(hpc$Time, sub_metering_3,col="blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.5)
plot(hpc$Time,global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

dev.off()