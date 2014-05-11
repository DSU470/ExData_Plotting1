# For detailed information regarding this assignment, please read the README.
# This script could serve as a simple codebook, based on code and comments only

# ASSIGNMENT: PLOT 1
# Loading the data: 
#   dataset has 2,075,259 rows and 9 columns. 
#   dataset missing values are coded as ?
# First calculate a rough estimate of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
# Only data from the dates 2007-02-01 and 2007-02-02 will be used.

# Load: library(data.table)

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
df.plot <- subset( df, !is.na(Global_active_power), select=c(Date, Global_active_power) )

# Plot1: a histogram based on Global Active Power
# Create the png file in workingdirectory
png(file = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(df.plot$Global_active_power, main="Globel Active Power", xlab="Globel Active Power (kilowatts)", col="red")
dev.off()
