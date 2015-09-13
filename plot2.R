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
png('plot2.png', width = 480, height = 480, units = 'px')

# Using type = l for line
plot(df$global_active_power ~ df$dt, type = 'l', xlab = '', 
     ylab = 'Global Active Power (kilowatts)')
dev.off()