
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

png(file=paste0(destPng,"plot2.png"),width=480,height=480)
plot(x=subsetData$Time,
     y=as.numeric(subsetData[,3])/500, 
     ylab="Global Active Power (kilowatts)",     
     type="l")
dev.off()
