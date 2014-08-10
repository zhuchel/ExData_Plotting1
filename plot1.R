#Read data
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', 
                 na.strings="?", check.names=F, stringsAsFactors=F)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#Apply date filter
data_subset <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Remove original bulk data from memory
rm(data)

#Plot basic histogram (Plot 1)
hist(data_subset$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

#Output to png graphics device
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
