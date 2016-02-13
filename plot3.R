
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

# Plot the first sub-meter
plot(hs$Date,
     hs$Sub_metering_1,
     type="l",
     xlab="",
     ylab="Energy sub metering")

# Plot the second sub-meter
lines(hs$Date,
      hs$Sub_metering_2,
      type="l",
      col="red")

# Plot the third sub-meter
lines(hs$Date,
      hs$Sub_metering_3,
      type="l",
      col="blue")

# Add the legend
legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),lwd=2,col=c("black","red","blue"))

# Save the figure
dev.off()