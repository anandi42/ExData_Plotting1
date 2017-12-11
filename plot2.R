#Exploratory Data Analysis Project 1
##Code to Generate plot2.png

#The following code will:
#1) check for presence of downloaded data file in subdirectory called "~/power_data"
#2) read in data and create a lineplot of Global power consumption for the days speicified. 
#3) png file will be placed in a created directory, "~/power_plots/"

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
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

##Subset data, cleanup full dataset
plotdata <- rbind(subset(power, power$Date=="2007-02-01"),subset(power, power$Date=="2007-02-02"))
rm(power)

##Create a datetime variable
plotdata$dt<-paste(plotdata$Date, plotdata$Time)
plotdata$dt<-strptime(plotdata$dt, "%Y-%m-%d %H:%M:%OS")


##Save Plot as Png to /power_plots directory
ifelse(!dir.exists(paths = "~/power_plots"), dir.create("~/power_plots"), FALSE)
png(file="~/power_plots/plot2.png", height=480, width=480, units="px")
with(plotdata, plot(dt,Global_active_power,type="l",xlab=" ", ylab="Global Active Power (kilowatts)"))
dev.off()
