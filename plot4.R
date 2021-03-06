#Exploratory Data Analysis Project 1
##Code to Generate plot4.png

#The following code will:
#1) check for presence of downloaded data file in subdirectory called "~/power_data"
#2) read in data and create a panel plot showing 4 views of the Global Power consumption data.  
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

##Read Data from .txt file, and convert Date
power <- read.table("~/power_data/household_power_consumption.txt", stringsAsFactors=FALSE, header=TRUE, sep=";", na.strings="?")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")

##Subset data, cleanup full dataset
plotdata <- rbind(subset(power, power$Date=="2007-02-01"),subset(power, power$Date=="2007-02-02"))
rm(power)

##Create a datetime variable
plotdata$dt<-paste(plotdata$Date, plotdata$Time)
plotdata$dt<-strptime(plotdata$dt, "%Y-%m-%d %H:%M:%OS")
plotdata$dt<-as.numeric(plotdata$dt)

##Save Plot as Png to /power_plots directory

ifelse(!dir.exists(paths = "~/power_plots"), dir.create("~/power_plots"), FALSE)
png(file="~/power_plots/plot4.png", height=480, width=480)
par(mfrow=c(2,2))

##Plot 1
with(plotdata, plot(dt,Global_active_power,type="l",xlab=NA, ylab="Global active power", xaxt="n"))
axis(1, at=c(min(plotdata$dt),median(plotdata$dt),max(plotdata$dt)),labels=c("Thu","Fri","Sat"))

##Plot 2
with(plotdata, plot(dt,Voltage,type="l",xlab="datetime", ylab="Voltage", xaxt="n"))
axis(1, at=c(min(plotdata$dt),median(plotdata$dt),max(plotdata$dt)),labels=c("Thu","Fri","Sat"))

##Plot 3
with(plotdata, plot(dt,Sub_metering_1,type="l",xlab=NA, ylab="Energy sub metering", col="black", xaxt="n"))
with(plotdata, lines(Sub_metering_2~dt, col="red"))
with(plotdata, lines(Sub_metering_3~dt, col="blue"))
axis(1, at=c(min(plotdata$dt),median(plotdata$dt),max(plotdata$dt)),labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,10,20,30))
legend("topright", legend=paste0("Sub_metering_",1:3), lwd=c(1,1,1),
col=c("black", "red", "blue"), bty="n")

##Plot 4
with(plotdata, plot(dt,Global_reactive_power,type="l",xlab="datetime", ylab="Global_reactive_power", xaxt="n"))
axis(1, at=c(min(plotdata$dt),median(plotdata$dt),max(plotdata$dt)),labels=c("Thu","Fri","Sat"))
dev.off()
