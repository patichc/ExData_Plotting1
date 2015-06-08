library(graphics)

## WORKING DIRECTORY
##  Sets the working directory to the forder where the Project1 will be developed
setwd("~/DataScientist/ExploratoryDataA/Project 1")
## Set download directory if the directory does not exists it is created
DownloadDirectory <- "Downloads"
if (!(file.exists(DownloadDirectory))) {
  dir.create(DownloadDirectory)
}
##  Set the working directory to the forder where the Project 1 Downloads will be stored
setwd("~/DataScientist/ExploratoryDataA/Project 1/Downloads")

## DOWNLOAD
## Downloads the Electric Power Consumption (EPC) data into a local file
EPC.url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
EPC.zipFileName="ElectricHouseholdPowerConsumption.zip"
EPC.zipFile=download.file(
  url = EPC.url,
  destfile = EPC.zipFileName,
  mode = "wb")
EPC.downloadDate <- date
## Unzip the file on the local directory and the extracted file name is EPC.filename
EPC.fileName <- unzip(zipfile = EPC.zipFileName)

## READS FILE IN Data Frame
EPC.data = read.table(file = EPC.fileName,
                      header = TRUE,
                      sep = ";",
                      na.strings = "?")

## TIDY DATA FOR ANALYSIS
## Calculates the POSIXct object variable to represent datetime
EPC.tidyDateTime <- strptime(paste(EPC.data [,1],
                                  EPC.data [,2]),
                            "%d/%m/%Y %H:%M:%OS")
## Appends to the Dataframe a first column with the POSIXct object variable to represent datetime
EPC.tidyData <- cbind(EPC.tidyDateTime, EPC.data)
colnames(EPC.tidyData) <- c("DateTimePOSIXct",colnames(EPC.data))
## Creates a data frame with only the data needed for the analysys (subsets by date)
EPC.dataSubset <- subset(EPC.tidyData,
                        DateTimePOSIXct >= strptime("1/2/2007 00:00:00","%d/%m/%Y %H:%M:%OS")&
                        DateTimePOSIXct <  strptime("3/2/2007 00:00:00","%d/%m/%Y %H:%M:%OS"))

## PLOTS
## Open plot4.png file in working directory
png("plot4.png",width = 480, height = 480)
## Create 4 plot areas
par(mfcol = c(2,2), mar = c(5,4,2,1))
## add topleft plot: Line Plot for Global Active Power
plot(x = EPC.dataSubset[,"DateTimePOSIXct"],
     y = EPC.dataSubset[,"Global_active_power"],
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowwatts)")
## add bottomleft plot: Multi Line Plot for Sub metering1, Sub metering2 and Sub metering3 without x axis
matplot(EPC.dataSubset[,"DateTimePOSIXct"],
        cbind(EPC.dataSubset[,"Sub_metering_1"],
              EPC.dataSubset[,"Sub_metering_2"],
              EPC.dataSubset[,"Sub_metering_3"]),
        type="l",
        col=c(1,2,4),
        xlim = c(1170300000,1170500000),
        xlab = "",
        ylab = "Energy sub metering",
        xaxt = "n",
        mar = c(2,3,2,2))
## add x axis to plot
axis.POSIXct (1,
              at = c(strptime("1/2/2007 00:00:00","%d/%m/%Y %H:%M:%OS"),
                     strptime("2/2/2007 00:00:00","%d/%m/%Y %H:%M:%OS"),
                     strptime("3/2/2007 00:00:00","%d/%m/%Y %H:%M:%OS")),
              format = "%w", 
              xaxt = "s")
## add legend to plot
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c(1,4,2), 
       lty = 1)
## add topright plot: Line Plot for Voltage
plot(x = EPC.dataSubset[,"DateTimePOSIXct"],
     y = EPC.dataSubset[,"Voltage"],
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
## add Bottomright plot: Line Plot for Voltage
plot(x = EPC.dataSubset[,"DateTimePOSIXct"],
     y = EPC.dataSubset[,"Global_reactive_power"],
     type = "l",
     xlab = "datetime",
     ylab = "Global reactive power")
## Close the  png device (file is completed with the plot)## Close the  png device (file is completed with the plot)
dev.off()
## END

