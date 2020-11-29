library(ggplot2)


df <- read.table("C:\\Users\\hangc\\Documents\\exdata_data_household_power_consumption\\household_power_consumption.txt",sep=";",header =  TRUE)
df[ df == "?" ] <- NA
df$time_new <- paste(df$Date,df$Time,sep = ' ')
df$time_new <- strptime(df$time_new, format = "%d/%m/%Y %H:%M:%S")
df[,3:6] <- lapply(df[,3:6],function(x) as.numeric(x))
df_subset <- subset(df,df$time_new >="2007-02-01 00:00:00" & df$time_new < "2007-02-03 00:00:00")



#plot 1 
hist(df_subset$Global_active_power,
     main="Global Active Power",
     xlab="Global Active Power(kilowatts)",
     col="red"
     )

#plot2
x <- df_subset$time_new
y <- df_subset$Global_active_power

plot(x,
     y,
     type = "l",
     xlab = '',
     ylab="Global Active Power (kilowatts)")

#plot3

with(df_subset, {
        plot(time_new,Sub_metering_1, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(df_subset$time_new,df_subset$Sub_metering_2,col='Red')
        lines(df_subset$time_new,df_subset$Sub_metering_3,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df_subset, {
        plot(time_new,Global_active_power, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(time_new,Voltage, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(time_new,Sub_metering_1, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(time_new,Sub_metering_2,col='Red')
        lines(time_new,Sub_metering_3,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(time_new,Global_reactive_power, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()


