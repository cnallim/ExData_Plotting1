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

# CREATING PLOT # 4

#Launching graphic device 
png("plot4.png", width = 480, height = 480)

#Plotting tasks:

#Now I generate the layout and the "order of appearance" of the plots
par(mfrow=c(2,2))

#Here comes the first plot:
plot(dateTime, ds$Global_active_power, type="l", ylab="Global Active Power", xlab="")

#And now the second one:

plot(dateTime, ds$Voltage, type="l", ylab="Voltage", xlab="datetime")

# Turn of the third (several superimposed plots)
plot(dateTime, ds$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
lines(dateTime, ds$Sub_metering_2, type="l", col="red")
lines(dateTime, ds$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd =2.5, col=c("black", "red", "blue"), bty="n")

# And the last plot:
plot(dateTime, ds$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

#Time to shut off the graphic device:
dev.off()

#Now there is a plot4.png file in the woeking directory