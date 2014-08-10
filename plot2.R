#Read data.
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

#Create Plot 2
plot(data_subset$Global_active_power~data_subset$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#Output to png graphics device
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
#Restore local time settings
Sys.setlocale("LC_TIME", time_loc)
