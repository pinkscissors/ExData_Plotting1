## download data
library(downloader)
myUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "hse_pwr_cons.zip"
download(myUrl, "hse_pwr_cons.zip")

## unzip file
unzip(zipFile, exdir = ".")

## read in text file using a more limited number of rows
hse_pwr_cons<- read.table("household_power_consumption.txt",
      header=T, sep= ";", dec=".", stringsAsFactors=FALSE, nrows=70000)

## subset the dates required
## 1.libraries
library(lubridate)
library(dplyr)
## 2.load data into package format
data_dates<-tbl_df(hse_pwr_cons)
## 3.remove original data
rm(hse_pwr_cons)
## 4.filter the rows required for the date range
mydata<- filter(data_dates, dmy(Date) == "2007-02-01"|dmy(Date) =="2007-02-02")

## preparation for the histogram Plot 1
## 1.convert single variable to numeric
histdata<- as.numeric(mydata$Global_active_power)
## 2.plot to screen
hist(histdata, main = "Global Active Power",
     xlab ="Global Active Power (kilowatts)", col = "Red")
## 3.copy plot1 to png file
dev.copy(png, file = "plot1.png")
dev.off()
