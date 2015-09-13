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
png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")

#Plot 2 is simple line plot
with(dtable, plot(Global_active_power~datetime, type = "l", ylab="Global Active Power(kilowatts", xlab=""))

#save the file
dev.off()