###############################################################################
# Analysis of the butterfly data set 
# Gabriel Dennis
###############################################################################
rm(list = ls())
gc()
library(tidyverse)
library(readxl)


# Load in the distribution  data 
df <- read.csv('data/burns_distributions.csv') %>%
      group_by(burn_severity, death) %>%
      summarise_all(sum)

# Plot densities
ggplot(df, aes(burn_severity, maxD)) + geom_point()


ggplot(df, aes(burn_severity, minD)) + geom_point()
