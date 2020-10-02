#     4th graph

############## read data & setup Dates_Times ##############
data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";")
# extract only required dates
ds <- subset(data,(data$Date == "1/2/2007")|(data$Date == "2/2/2007"))
# convert to dates
ds2 <- mutate(ds,Date = as.Date(Date,format = "%d/%m/%Y"))
# add the Date_Time column that combines Date&Time into Date_Time
ds2 <- mutate(ds2,Date_Time = strptime(paste(Date,Time,sep = " "),
                                       format = "%Y-%m-%d %H:%M:%S"))
############## end reading & setup ##############

# clear current plots if exist
while(dev.cur()!= 1){
  dev.off()
}

# plot the graph
png("plot4.png");
par(mfrow = c(2,2)); # setup frame

# topleft plot
plot(ds2$Date_Time, ds2$Global_active_power,type = "l",xlab = "", 
     ylab = "Global Active Power");
# topright plot
plot(ds2$Date_Time, ds2$Voltage,type = "l",xlab = "datetime", 
     ylab = "Voltage");
# bottomleft plot
plot(ds2$Date_Time, ds2$Sub_metering_1,type = "l",xlab = "", 
     ylab = "Energy sub metering");
lines(ds2$Date_Time, ds2$Sub_metering_2,col = "red");
lines(ds2$Date_Time, ds2$Sub_metering_3,col = "blue");

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       pch = "——",col = 1:3, bty = "n",cex = 1);

plot(ds2$Date_Time, ds2$Global_reactive_power,type = "l",xlab = "datetime", 
     ylab = "Global_reactive_power");
dev.off() # save png
