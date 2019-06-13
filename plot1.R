#download household power consomption data set
if (file.exists("HPC.zip") == TRUE) {
  download.file("Electric power consumption", destfile = paste0(getwd(), "/HPC.zip"), method = curl)
}
#unzip the data set file
if (file.exists("household_power_consumption.txt") == TRUE) {
  unzip("HPC.zip")
}

#load necessary package
library(dplyr)

#read the data set file
data <-  read.table("household_power_consumption.txt", sep = ";", header = T, colClasses = c("character", "character", rep("numeric",7)), na.strings = "?")

#convert Date and Time
data$Date <-  as.Date(data$Date, "%d/%m/%Y")

#subset the data from 2007-02-01 to 2007-02-02
fildata <- filter(data, !is.na(Global_reactive_power))
fildata <- filter(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

#set the histogram
hist(fildata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#save the plot into png file
dev.copy(png, "plot1.png", width= 480, height = 480)
dev.off()


