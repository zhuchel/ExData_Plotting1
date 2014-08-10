#Read data
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', 
                 na.strings="?", check.names=F, stringsAsFactors=F)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Apply date filter
data_subset <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Remove original bulk data from memory
rm(data)

#Store local time settings
time_loc = Sys.getlocale("LC_TIME")
#Disable local time settings, otherwise localized days of week would be plotted
Sys.setlocale("LC_TIME", "C")
#Convert dates
data_subset$Datetime <- as.POSIXct(paste(as.Date(data_subset$Date), data_subset$Time))

#Create Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data_subset, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l")
})

#Output to png graphics device
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

#Restore local time settings
Sys.setlocale("LC_TIME", time_loc)
