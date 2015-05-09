# Following script will load data from exdata_data_household_power_consumption folder, 
# and plot graph of energy consumption for two days i.e 2007-02-01 & 2007-02-01.
# dplyr package is used to filter data.
# PNG file is generated using dev.copy function
#------------------------------------------------------------------------------------------------------------------------------------- 
# Important note- Before running this script please make sure that exdata_data_household_power_consumption folder containing txt file
# is copied into your working directory.
#-------------------------------------------------------------------------------------------------------------------------------------
# Author - Ankur Thakkar


library(dplyr)

# Reading data
powerConsumption <- read.table("./exdata_data_household_power_consumption//household_power_consumption.txt", na.strings = "?", sep=";", header = TRUE)

# Casting it to tbl_df for simplicity
powerConsumption <- tbl_df(powerConsumption)

# Type casting Date column from factor to Date 
powerConsumption$Date <- as.Date(powerConsumption$Date, format="%d/%m/%Y")

# Using filter to extract data for two days.
twoDaysData <- filter(powerConsumption, Date==(as.Date("2007-02-01")) | Date==(as.Date("2007-02-02")))

# merging date and time column into one
twoDaysData <- mutate(twoDaysData, DateTime=paste(Date, Time))

#converting datetime column to date time format using POSXct
twoDaysData$DateTime <- as.POSIXct(twoDaysData$DateTime)

# Setting margin for plot
par(mar=c(4,4,2,2.1))

# Setting 1 row and 1 column for plot
par(mfrow=c(1,1))

# Plotting required graph
plot(twoDaysData$DateTime, twoDaysData$Global_active_power, type="l", xlab=" ", ylab = "Global Active Power(kilowatts)")

# Generating PNG file
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()