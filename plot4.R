#download household power consomption data set
if (file.exists("HPC.zip") == FALSE) {
  download.file("Electric power consumption", destfile = paste0(getwd(), "/HPC.zip"), method = curl)
}

#unzip the data set file
if (file.exists("household_power_consumption.txt") == FALSE) {
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

#set line chart
par(mfrow= c(2,2))

  #Global active plot
  plot(fildata$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "",xaxt = "n", xlim = c(0,3000))
  axis(1, at =c(0,1500,3000), labels = c("Thu", "Fri", "Sat"))
  
  #Voltage plot
  plot(fildata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime",xaxt = "n", xlim = c(0,3000))
  axis(1, at =c(0,1500,3000), labels = c("Thu", "Fri", "Sat"))
  
  #Energy Sub plot
  plot(fildata$Sub_metering_1, type = "l", ylab = "Energy Sub metering", xlab = "" ,xaxt = "n", xlim = c(0,3000), col = "black")
  axis(1, at =c(0,1500,3000), labels = c("Thu", "Fri", "Sat"))
  lines(fildata$Sub_metering_2, col = "red")
  lines(fildata$Sub_metering_3, col = "blue")
  legend("topright",legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1 , cex = 0.9, bty = "n")

  #Global reactive plot
  plot(fildata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime",xaxt = "n", xlim = c(0,3000))
  axis(1, at =c(0,1500,3000), labels = c("Thu", "Fri", "Sat"))
  
#save the plot into png file
dev.copy(png, "plot4.png")
dev.off()
