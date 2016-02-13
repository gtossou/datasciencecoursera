
#Get data

url <- 'http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'

if (!file.exists('data/exdata-data-NEI_data.zip')) {
  download.file(url, 'data/exdata-data-NEI_data.zip')
  unzip('data/exdata-data-NEI_data.zip', exdir='./data')
}

hs <- read.csv("./data/household_power_consumption.txt",
                 sep=";",header = TRUE,
                 na.strings="?")



#Convert factors in date/time and subset data

hs$Date<-as.Date(hs$Date, format="%d/%m/%Y")
hs$Time<-as.character(hs$Time)
sub_hs <- hs[ which(hs2$Date=="2007-02-01" | hs2$Date=="2007-02-02",) ]


# Start the png device

png(filename="plot1.png", height=480, width=480, bg="transparent")

# Plot the histogram

hist(sub_hs$Global_active_power,
     col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency")

# Save the figure

dev.off()