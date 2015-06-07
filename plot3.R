# Exploratory Data Analysis: Course Project 1
# Plot 3

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
png("plot3.png", width = 480, height = 480, bg = "transparent")
plot(febData$DateTime, febData$Sub_metering_1, type = "n",
     ylab = "Energy sub metering", xlab = "")
lines(febData$DateTime, febData$Sub_metering_1, type = "l")
lines(febData$DateTime, febData$Sub_metering_2, type = "l", col = "red")
lines(febData$DateTime, febData$Sub_metering_3, type = "l", col = "blue")
legend("topright", lty = c(1, 1, 1), col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
