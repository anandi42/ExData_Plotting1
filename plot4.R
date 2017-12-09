#Exploratory Data Analysis Project 1
##Code to Generate plot4.png
##Optional step (using downloadcheck.R in "helperfiles") included below to check  
##for presence of "household_power_consumption.txt" in directory /data. 
##This step can be skipped if user is sure file has been downloaded. 

#Optional Setup
source("~/downloadcheck.R")
##Setup steps
rm(list=ls())
setwd("~/data")
##Read Data from .txt file, and convert Date
power <- read.table("household_power_consumption.txt", stringsAsFactors=FALSE, header=TRUE, sep=";", na.strings="?")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
##Subset data, cleanup full dataset
plotdata <- rbind(subset(power, power$Date=="2007-02-01"),subset(power, power$Date=="2007-02-02"))
rm(power)
##Create a datetime variable
plotdata$dt<-paste(plotdata$Date, plotdata$Time)
plotdata$dt<-strptime(plotdata$dt, "%Y-%m-%d %H:%M:%OS")
plotdata$dt<-as.numeric(plotdata$dt)
##Axis label values for later
##Doing this extra step to make sure the X-axis labels display correctly
##(its possibly extraneous?)
thu <- min(plotdata$dt)
fri <- median(plotdata$dt)
sat <- max(plotdata$dt)
##Generate PNG device and make Plots
png(file="plot4.png", height=480, width=480)
par(mfrow=c(2,2))
##Plot 1
with(plotdata, plot(dt,Global_active_power,type="l",xlab=NA, ylab="Global active power", xaxt="n"))
axis(1, at=c(thu,fri,sat),labels=c("Thu","Fri","Sat"))
##Plot 2
with(plotdata, plot(dt,Voltage,type="l",xlab="datetime", ylab="Voltage", xaxt="n"))
axis(1, at=c(thu,fri,sat),labels=c("Thu","Fri","Sat"))
##Plot 3
with(plotdata, plot(dt,Sub_metering_1,type="l",xlab=NA, ylab="Energy sub metering", col="black", xaxt="n"))
with(plotdata, lines(Sub_metering_2~dt, col="red"))
with(plotdata, lines(Sub_metering_3~dt, col="blue"))
axis(1, at=c(thu,fri,sat),labels=c("Thu","Fri","Sat"))
axis(2, at=c(0,10,20,30))
legend("topright", legend=paste0("Sub_metering_",1:3), lwd=c(1,1,1),
col=c("black", "red", "blue"), bty="n")
##Plot 4
with(plotdata, plot(dt,Global_reactive_power,type="l",xlab="datetime", ylab="Global_reactive_power", xaxt="n"))
axis(1, at=c(thu,fri,sat),labels=c("Thu","Fri","Sat"))
dev.off()
