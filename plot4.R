# For detailed information regarding this assignment, please read the README.
# This script could serve as a simple codebook, based on code and comments only

# ASSIGNMENT: PLOT 4
# Loading the data: 
#   dataset has 2,075,259 rows and 9 columns. 
#   dataset missing values are coded as ?
# First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
# Only data from the dates 2007-02-01 and 2007-02-02 will be used.

# Load: library(data.table)

# In order to get labels/captions in English, set the Locale
Sys.setlocale("LC_TIME", "English") # Windows

# Rough estimate: 2075259 rows * 9 columns * 8byte/column = 142,50 Mb.
# 142,50 Mb will not cause issues at all
# Nevertheless, i prefer a clean load for only 2 days data.

# Read CSV file and subset it, initialise the column classes to non factors
df.init <- read.csv(file="household_power_consumption.txt", sep=";", nrows=100, na.strings="?", stringsAsFactors=FALSE)
df.init.classes <- sapply(df.init, class)
df <- subset(read.csv(file="household_power_consumption.txt", colClasses=df.init.classes, sep=";", na.strings="?"), ((as.Date(Date,"%d/%m/%Y")==as.Date("01/02/2007","%d/%m/%Y"))|(as.Date(Date,"%d/%m/%Y")==as.Date("02/02/2007","%d/%m/%Y"))) )

# nrows in file = 2075259. 
# nrows of the dataframe = 2880
# Data is loaded and subsetted into dataframe df, NA are not removed.
# Remove NAs, if any
df.plot <- subset( df, select=c(Date, Time, Global_active_power, Global_reactive_power, Voltage, Sub_metering_1, Sub_metering_2, Sub_metering_3) )
df.plot$DateTime <- as.POSIXct(paste(df.plot$Date,df.plot$Time), format = "%d/%m/%Y %H:%M:%S")

# Plot4:
# Create the png file in workingdirectory
png(file = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")
# 4 plots: 2 by 2
par(mfrow=c(2,2))
# Plot 1: Topleft
plot(df.plot$DateTime, df.plot$Global_active_power, type="l", main="", xlab="", ylab="Globel Active Power (kilowatts)")
# Plot 2: Topright
plot(df.plot$DateTime, df.plot$Voltage, type="l", main="", xlab="datetime", ylab="Voltage")
# Plot 3: Bottomleft
plot(x=df.plot$DateTime, y=df.plot$Sub_metering_1, type="l", col="black", main="", xlab="", ylab="Energy sub metering")
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n" )
lines(x=df.plot$DateTime, y=df.plot$Sub_metering_2, col="red")
lines(x=df.plot$DateTime, y=df.plot$Sub_metering_3, col="blue")
# Plot 4: Bottomright
plot(df.plot$DateTime, df.plot$Global_reactive_power, type="l", main="", xlab="datetime", ylab="Global_reactive_power")
dev.off()
