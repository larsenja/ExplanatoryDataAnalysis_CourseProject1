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

# Plot 2
png(file="plot2.png",bg="white")
plot(finalData$aDate,finalData$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()