# Exploratory Data Analysis: Course Project 1
# Plot 1

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

# generate plot
png("plot1.png", width = 480, height = 480, bg = "transparent")
hist(febData$Global_active_power, main = "Global Active Power", col = "red", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
