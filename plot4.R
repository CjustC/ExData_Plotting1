library(data.table)  # Needed for 'fread'
# Download and unpack file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "q1.csv", 
              method = "curl")

if(!file.exists("./household_power_consumption.txt")) {
     download.file(DownURL, "dataset.zip")
     unzip("dataset.zip")
     unlink("dataset.zip")
}
# read in file
powerData <- fread("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings="?")
powerSubData <- powerData[powerData$Date %in% c("1/2/2007","2/2/2007") ,] # Subset Data
rm(powerData) # remove large dataset

# Convert/Combine Date & Time, make variables to numeric
datetime <- strptime(paste(powerSubData$Date, powerSubData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # Convert & Combine Date, Time
globalActivePower <- as.numeric(powerSubData$Global_active_power)
globalReactivePower <- as.numeric(powerSubData$Global_reactive_power)
voltage <- as.numeric(powerSubData$Voltage)
subMetering1 <- as.numeric(powerSubData$Sub_metering_1)
subMetering2 <- as.numeric(powerSubData$Sub_metering_2)
subMetering3 <- as.numeric(powerSubData$Sub_metering_3)

# layout of plots 2x2
par(mfrow = c(2, 2))

# plot 1
plot(datetime, globalActivePower, type = "l", xlab = "", ylab="Global Active Power (kilowatts)")

# plot 2
plot(datetime, voltage, type = "l", xlab = "datetime", ylab = "Voltage")

# plot 3
plot(datetime, subMetering1, type = "l", xlab = "", ylab="Enery Sub metering")
lines(datetime, subMetering2, type = "l", col = "red")
lines(datetime, subMetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), bty = "n", cex = 0.5, col = c("black", "red", "blue"))
# 'bty' removes the box, 'cex' shrinks the text, spacing added after labels for proper rendering

# plot 4
plot(datetime, globalReactivePower, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

# Save to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

