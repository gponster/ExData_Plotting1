# Load data, assume set right working directory
df <- read.table('household_power_consumption.txt', 
    header = TRUE, sep = ";", colClasses= c('character', 'character', rep('numeric', 7)), 
    na.strings = '?')
names(df) <- tolower(names(df))

# Convert to date
df$date = as.Date(df$date, format = '%d/%m/%Y')

# Subset data
df = df[df$date >= as.Date('2007-02-01') & df$date <= as.Date('2007-02-02'),]

# Date time
df$dt = as.POSIXct(strptime(paste(df$date, df$time), '%Y-%m-%d %H:%M:%S'))

# Create and save plot
png('plot4.png', width = 480, height = 480, units = 'px')

# Make a 2x2 plots
par(mfrow = c(2, 2))

# Plot#1
plot(df$global_active_power ~ df$dt, type = 'l', xlab = '', 
     ylab = 'Global Active Power')

# Plot#2
plot(df$voltage ~ df$dt, type = 'l', xlab = 'datetime', ylab = 'Voltage')

# Plot#3
plot(df$sub_metering_1 ~ df$dt, type = 'l', xlab = '', 
     ylab = 'Energy sub metering')

# Add the lines for the sub_2, colored red
lines(df$sub_metering_2 ~ df$dt, col = 'Red')  

#Add the lines for the sub_3, colored blue
lines(df$sub_metering_3 ~ df$dt, col = 'Blue')  

#Add a legend
legend("topright", col = c('Black', 'Red', 'Blue'), 
       legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), 
       lty = 1)

# Plot#4
plot(df$global_reactive_power ~ df$dt, type = 'l', xlab = 'datetime', 
    ylab = 'Global_reactive_power')

dev.off()