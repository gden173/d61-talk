################################################################
# Create the Power Table
################################################################
library(xtable)
csv_name <- "data/power_simulation.csv"
df <- read.csv(csv_name, header=FALSE)
names(df) <- paste0(seq(-1, 1, length.out = 21))
row.names(df) <- paste0(seq(-1, 1, length.out = 21))


# Print out the table
xtable(df)
print.xtable(xtable(df*100, digits=0))
