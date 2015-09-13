# Load data, assume set right working directory
df <- read.table('household_power_consumption.txt', 
    header = TRUE, sep = ";", colClasses= c('character', 'character', rep('numeric', 7)), 
    na.strings = '?')
names(df) <- tolower(names(df))

# Convert to date
df$date = as.Date(df$date, format = '%d/%m/%Y')

# Subset data
df = df[df$date >= as.Date('2007-02-01') & df$date <= as.Date('2007-02-02'),]

# Create and save plot
png('plot1.png', width = 480, height = 480, units = 'px')
hist(df$global_active_power, col = 'red', 
    xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency', 
    main = 'Global Active Power')
dev.off()