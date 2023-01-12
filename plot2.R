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

global_active_power <- as.numeric(hpc$Global_active_power)

# save plot
png(file="plot2.png",width=480, height=480)

# Plot 2
plot(hpc$Time,global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",
     main="Global Active Power Vs Time") 

dev.off()