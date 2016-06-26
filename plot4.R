
Sys.setenv("LANGUAGE"="En")
Sys.setlocale("LC_ALL", "English")

tempdata<-read.csv("household_power_consumption.txt",sep=";",header=TRUE,stringsAsFactors = FALSE)
datadf<-subset(tempdata,Global_active_power!="?"|Global_reactive_power!="?"|Voltage!="?"|Global_intensity!="?"|Sub_metering_1!="?"|Sub_metering_2!="?"|Sub_metering_3!="?")


datadf$Global_active_power<-as.numeric(datadf$Global_active_power)
datadf$Global_reactive_power<-as.numeric(datadf$Global_reactive_power)
datadf$Voltage<-as.numeric(datadf$Voltage)
datadf$Global_intensity<-as.numeric(datadf$Global_intensity)
datadf$Sub_metering_1<-as.numeric(datadf$Sub_metering_1)
datadf$Sub_metering_2<-as.numeric(datadf$Sub_metering_2)
datadf$Sub_metering_3<-as.numeric(datadf$Sub_metering_3)
datadf$Date<-as.Date(datadf$Date,format="%d/%m/%Y")

date1<-as.Date("2007-02-01")
date2<-as.Date("2007-02-02")

finalData<-datadf[datadf$Date>=date1 & datadf$Date<=date2,]
finalData$temp<-paste(finalData$Date,finalData$Time,sep=" ")
finalData$aDate<-strptime(finalData$temp,"%Y-%m-%d %H:%M:%S")

png(file="plot4.png",bg="white")

par(mar=c(3,3,3,3))
par(mfrow=c(2,2))


  plot(finalData$aDate,finalData$Global_active_power,type="l")
  mtext(side=2,text="Global Active Power",line=2)

  plot(finalData$aDate,finalData$Voltage,type="l",xlab="",ylab="")
  mtext(side=1,text="datetime",line=2)
  mtext(side=2,text="Voltage",line=2)

  plot(finalData$aDate,finalData$Sub_metering_1,type="l",col=c("black"))
  mtext(side=2,text="Energy sub metering",line=2)
  par(new=TRUE)
  
  plot(finalData$aDate,finalData$Sub_metering_2,type="l",axes=FALSE,col=c("red"))
  par(new=TRUE)
  plot(finalData$aDate,finalData$Sub_metering_3,type="l",axes=FALSE,col=c("blue"))

  par(new=FALSE)
  legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub metering 1","Sub metering 2","Sub metering 3"))     
  
  plot(finalData$aDate,finalData$Global_reactive_power,type="l")
  mtext(side=1,text="datetime",line=2)
  mtext(side=2,text="Global_reactive_power",line=2)

dev.off()