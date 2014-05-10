
#static var for the path to the data file
dataDir <- "..\\data\\household_power_consumption.txt"
destPng <- "image\\"
fopen <- function(sep=";")
{
  read.csv(dataDir, header=T, sep = sep)
}

readSubset<- function (startDate="2007-02-01", endDate="2007-02-02" )
{
  data<- fopen()
  data$Time <- paste(data$Date,data$Time)
  data$Date = as.Date(data$Date,format="%d/%m/%Y")
  data$Time <- strptime(data$Time ,format="%d/%m/%Y %H:%M:%S")  
  subset(data,data$Date>=startDate & data$Date<=endDate)
}

subsetData <- readSubset()
#cleaning
subsetData$Sub_metering_1 = as.numeric(subsetData$Sub_metering_1)-2
subsetData$Sub_metering_2 = as.numeric(subsetData$Sub_metering_2)-2
subsetData$Sub_metering_3 = as.numeric(subsetData$Sub_metering_3)

subsetData$Sub_metering_1[which(subsetData$Sub_metering_1<20)]=0
subsetData$Sub_metering_2[which(subsetData$Sub_metering_2>5)]=2


png(file=paste0(destPng,"plot3.png"),width=480,height=480)

with(subsetData,plot(Time,Sub_metering_1,type="l",
                     col="black",xlab="",ylab="",yaxt="n",
                     ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))

par(new = TRUE)
with(subsetData,plot(Time,Sub_metering_2,type="l",
                     col="red",xlab="",ylab="",yaxt="n",
                      ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))

par(new = TRUE)
with(subsetData,plot(Time,Sub_metering_3,type="l",
                     col="blue",xlab="",ylab="",yaxt="n",
                     ylim=range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))))
legend("topright",lwd=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
title(xlab=" ",ylab="Energy sub metering")
axis(2,at=c(0,10,20,30))  

dev.off()
