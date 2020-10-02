#     2nd graph

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
png("plot2.png") 
par(mfrow = c(1,1)) # setup frame
plot(ds2$Date_Time, ds2$Global_active_power,type = "l",xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off() # save png