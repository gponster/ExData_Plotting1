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
png('plot3.png', width = 480, height = 480, units = 'px')

# Using type = l for line
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

dev.off()