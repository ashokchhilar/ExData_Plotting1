#Read the source data
datafile <- file("household_power_consumption.txt")

#get the relevant lines only as mentioned in assignment
lines <- grep("^[1,2]/2/2007", readLines(datafile), value = TRUE)
dtable <- read.table(text = lines, col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)

#close the datafile connection
close(datafile)

#Convert to Date Format to use later 
dtable$Date<-as.Date(dtable$Date, format="%d/%m/%Y")

#Merge the date and time to create the actual datetime
dtable$datetime=as.POSIXct(paste(dtable$Date, dtable$Time))

#open a file device to plot to
png(filename = "plot4.png", width = 480, height = 480,bg = "transparent")

#Actual Plot 4 needs grid layout
par(mfrow = c(2,2))
#graph 0,0
with(dtable, plot(Global_active_power ~ datetime, type = "l", ylab = "Global Active Power", xlab = ""))

#graph 0,1
with(dtable, plot(Voltage ~ datetime, type = "l", ylab = "Voltage"))

#grpah 1,0
with(dtable, plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy sub metering", xlab = "", col='black'))
with(dtable, lines(Sub_metering_2 ~ datetime, col = 'red'))
with(dtable, lines(Sub_metering_3 ~ datetime, col = 'blue'))

#legend of thrid graph used again from plot3.r
legend("topright", col = c("black", "red", "blue"), lty = 1, legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#fourth graph
with(dtable, plot(Global_reactive_power ~ datetime, type = "l", ylab = "Global_reactive_power"))
#save the file
dev.off()