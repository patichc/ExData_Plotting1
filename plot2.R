library(graphics)

## WORKING DIRECTORY PREPARATION
##  Sets the working directory to the forder for Project 1
setwd("~/DataScientist/ExploratoryDataA/Project 1")
## Set download directory if the directory does not exists it is created
DownloadDirectory <- "Downloads"
if (!(file.exists(DownloadDirectory))) {
        dir.create(DownloadDirectory)
}
## Set figures directory if the directory does not exists it is created
FiguresDirectory <- "Figures"
if (!(file.exists(FiguresDirectory))) {
        dir.create(FiguresDirectory)
}

## DOWNLOAD
##  Set the working directory to the forder where the Project 1 Downloads will be stored
setwd("~/DataScientist/ExploratoryDataA/Project 1/Downloads")
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
##  Set the working directory to the forder where the Project 1 Figures will be stored
setwd("~/DataScientist/ExploratoryDataA/Project 1/Figures")
## Open plot2.png file in working directory
png("plot2.png",width = 480, height = 480)
## Line Plot for Global Active Power
plot(x = EPC.dataSubset[,"DateTimePOSIXct"],
     y = EPC.dataSubset[,"Global_active_power"],
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowwatts)",
     mar = c(2,3,2,2))
## Close the  png device (file is completed with the plot)
dev.off()
## END

