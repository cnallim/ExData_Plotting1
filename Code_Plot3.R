#LOADING AND PREPARING DATA SET

# Notice: the following steps are common for all plots, since the output of this
# step (a data set for Feb. 1st and 2nd, 2007, with a proper Datetime vector) will
#be fed to the create the required Base Graphics plots. Dut to the instrutions, 
#repeat this steps in every R code script before launching the plotting phase
#itself.

#Download zip files, unzip and store file in directory ("DIRECTORY")
#I now have file household_power_consumption.txt in ("DIRECTORY")

#I set ("DIRECTORY") as the working diretory in R
#I load it into R (using fread / library(data.table))

completeds<- fread("household_power_consumption.txt", sep=";", na.strings= "?")

#I inspect it and subset the desired dates:

ds<- completeds[66637:69516,]

#This data set has 2880 observations of 9 variables

#I check variable types with str(ds)
# / Time are character type. The rest are numeric.

#Now I work to have one vector with Date + time combined (and Date in format YYYY/mm/dd)

date <- as.character(as.Date(ds$Date, "%d/%m/%Y"))
#Check the output: 
#  head(date)
# "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01" "2007-02-01"

#Now I combine Date + time:

x<-paste(date,ds$Time)

#What do I have? I check it:
#str(x)
#chr [1:2880] "2007-02-01 00:00:00" "2007-02-01 00:01:00" ...

#So I convert it by doing:
dateTime <- strptime(x, "%Y-%m-%d %H:%M:%S")

#And now:
#str(dateTime)
#POSIXlt[1:2880], format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" ...

# CREATING PLOT # 3

#Choosing and launching a graphic device:

png("plot3.png", height=480, width=480)

#Plotting tasks:

#Creation of first subplot (Sub_metering_1)
plot(dateTime, ds$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
#Adding second subplot (Sub_metering_2)
lines(dateTime, ds$Sub_metering_2, type="l", col="red")
#Adding third subplot (Sub_metering_3)
lines(dateTime, ds$Sub_metering_3, type="l", col="blue") 
# Adding legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd =2.5, col=c("black", "red", "blue"), cex=0.75)

#Closing graphic device:
dev.off()

#Now there is a "plot3.png" file in the working directory.