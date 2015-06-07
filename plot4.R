# Exploratory Data Analysis: Course Project 1
# Plot 4

# download data set
if(!file.exists("household_power_consumption.txt")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        temp <- tempfile()
        download.file(fileUrl, temp, method = "curl")
        data <- read.table(unz(temp, "household_power_consumption.txt"),
                           header = TRUE, sep = ";", na.strings="?") 
        unlink(temp)
} else {
        data <- read.table("household_power_consumption.txt", header = TRUE, 
                           sep = ";", na.strings="?")
}

# subset data
strptime(data$Time, format = "%H:%M:%S")
as.Date(data$Date, format = "%d/%m/%y")
febData <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007", ]

# generate datetime stamp
febData <- cbind(paste(febData$Date, febData$Time), febData)
colnames(febData)[1] <- "DateTime"
febData$DateTime <- strptime(paste(febData$Date, febData$Time), "%d/%m/%Y %H:%M")

# generate plot
png("plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(2,2))

# plot 1
plot(febData$DateTime, febData$Global_active_power, type = "l",
     ylab = "Global Active Power", xlab = "")

# plot 2
plot(febData$DateTime, febData$Voltage, type = "l",
     ylab = "Voltage", xlab = "datetime")

# plot 3
plot(febData$DateTime, febData$Sub_metering_1, type = "n",
     ylab = "Energy sub metering", xlab = "")
lines(febData$DateTime, febData$Sub_metering_1, type = "l")
lines(febData$DateTime, febData$Sub_metering_2, type = "l", col = "red")
lines(febData$DateTime, febData$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "blue", "red"), bty = "n", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# plot 4
plot(febData$DateTime, febData$Global_reactive_power, type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

dev.off()


