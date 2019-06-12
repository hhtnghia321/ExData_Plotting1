#download household power consomption data set
download.file("Electric power consumption", destfile = paste0(getwd(), "/HPC.zip"), method = curl)

#unzip the data set file
unzip("HPC.zip")

#load necessary package
library(dplyr)

#read the data set file
data <-  read.table("household_power_consumption.txt", sep = ";", header = T)

#convert Date and Time
data$Date <-  as.Date(data$Date, "%d/%m/%Y")
#data$Time <-- strptime(data$Time, format = "%H:%M:%S")

#subset the data from 2007-02-01 to 2007-02-02
fildata <- filter(data, Date == as.Date(c("2007-02-01","2007-02-02"), "%Y-%m-%d"))

#convert other variables into numeric type
fildata[3:9] <- lapply(fildata[3:9], as.character) %>% sapply(as.numeric)

#set the histogram
hist(fildata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power" )

#save the plot into png file
dev.copy(png, "plot1.png")
dev.off()