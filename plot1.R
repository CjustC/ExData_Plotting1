library(data.table)  # Needed for 'fread'

# download & unpack file
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
powerSubData <- powerData[powerData$Date %in% c("1/2/2007","2/2/2007") ,]
rm(powerData)

# Convert and combine Dates with times, make variables to numeric
datetime <- strptime(paste(powerSubData$Date, powerSubData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(powerSubData$Global_active_power)

# create histogram
hist(globalActivePower, main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# Save to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

