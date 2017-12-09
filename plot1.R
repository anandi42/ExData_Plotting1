#Exploratory Data Analysis Project 1
##Code to Generate plot1.png

#The following code will:
#1) check for presence of downloaded data file in subdirectory called "~/power_data"
#2) read in data and create a histogram of global ative power in Kilowatts for the days speicified. 
#3) file will be placed 


#Setup
rm(list=ls())
#Setup -- data download
setwd("~")
filepath <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipname <- "household_power_consumption.zip"
filename <- "~/power_data/household_power_consumption.txt"

if (file.exists(filename)) {
  print("File present!")
} else { 
  dir.create("~/power_data")
  download.file(filepath, zipname) 
  unzip(zipname, exdir="~/power_data")}


#Read in the data 
power <- read.table("~/power_data/household_power_consumption.txt", stringsAsFactors=FALSE, header=TRUE, sep=";", na.strings="?")
#Format date variable
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
#Subset -- can change date range showed below 
plotdata <- rbind(subset(power, power$Date=="2007-02-01",select="Global_active_power"), subset(power, power$Date=="2007-02-02", select="Global_active_power"))
#Clear out uneeded dataset
rm(power)

##Generate Plot as png
ifelse(dir.exists(paths = "~/power_plots"), dir.create("~/power_plots"), FALSE)
png(file="plot1.png", height=480, width=480, units = "px")
hist(plotdata$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red")
dev.off()
