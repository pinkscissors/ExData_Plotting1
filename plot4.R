### download data
library(downloader)
myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "hse_pwr_cons.zip"
download(myUrl, "hse_pwr_cons.zip")

### unzip file
unzip(zipFile, exdir = ".")

### read in text file using a more limited number of rows
hse_pwr_cons<- read.table("household_power_consumption.txt",
                          header=T, sep= ";", dec=".", stringsAsFactors=FALSE, nrows=70000)

### subset the dates required
### 1.libraries
library(lubridate)
library(dplyr)
### 2.load data into package format
data_dates<-tbl_df(hse_pwr_cons)
### 3.remove original data
rm(hse_pwr_cons)
### 4.filter the rows required for the date range
mydata<- filter(data_dates, dmy(Date) == "2007-02-01"|dmy(Date) =="2007-02-02")

### preparation for the line graph Plots
### 1.convert the variables to be plotted within object data to numeric
as.numeric(mydata$Global_active_power)
as.numeric(mydata$Sub_metering_1)
as.numeric(mydata$Sub_metering_2)
as.numeric(mydata$Global_reactive_power)
as.numeric(mydata$Voltage)

### 2.set graphical parameter in par to make a 2 X 2 matrix of 4 plots
par(mfrow = c(2,2), cex.lab=0.75, cex.axis=0.75)

### 3.plot the 4 plots
with(mydata, {
  plot(dmy(Date)+hms(Time),  Global_active_power,
          type="l", ylab="Global Active Power", xlab="")
  plot(dmy(Date)+hms(Time), Voltage, type="l",xlab="datetime")
})
with(mydata, plot(dmy(Date)+hms(Time),  Sub_metering_1,
                  type="l", ylab="Energy sub metering",  xlab=""))
with(mydata, lines(dmy(Date)+hms(Time),  Sub_metering_2, col="Red"))
with(mydata, lines(dmy(Date)+hms(Time),  Sub_metering_3, col="Blue"))
legend("topright", lty="solid", col= c("black", "red", "blue"), bty="n",
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.75)
with(mydata, plot(dmy(Date)+hms(Time),  Global_reactive_power,
      type="l", ylab="Global_reactive_power",  xlab="datetime"))
### 3.copy plot1 to png file
dev.copy(png, file = "plot4.png")
dev.off()