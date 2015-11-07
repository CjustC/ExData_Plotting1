## Load libraries
## download file from server
## unpack file
## read in full file there are 2075259 rows in this dataset
## subset powerData to only grab dataes = c("1/2/2007","2/2/2007")
## remove large data file to use only smaller file with extracted dates
## Convert and combine Dates with times
## make globalActivePower numeric for plotting
## make variables numeric
## create plot
## Save plot to file

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
# read in file, subset data, & remove large dataset
powerData <- fread("household_power_consumption.txt", stringsAsFactors = FALSE, na.strings="?")
powerSubData <- powerData[powerData$Date %in% c("1/2/2007","2/2/2007") ,] # Subset Data
rm(powerData) # remove large dataset

# Convert/Combine Date & Time, make variables to numeric
datetime <- strptime(paste(powerSubData$Date, powerSubData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") # Convert & Combine Date, Time
globalActivePower <- as.numeric(powerSubData$Global_active_power)
subMetering1 <- as.numeric(powerSubData$Sub_metering_1)
subMetering2 <- as.numeric(powerSubData$Sub_metering_2)
subMetering3 <- as.numeric(powerSubData$Sub_metering_3)

# create plot
plot(datetime, subMetering1, type = "l", xlab = "", ylab="Enery Sub metering")
lines(datetime, subMetering2, type = "l", col = "red")
lines(datetime, subMetering3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1), col = c("black", "red", "blue"))

# Save to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

