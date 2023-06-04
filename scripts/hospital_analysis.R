###############################################################################
# Analysis of the hospital data set 
# Gabriel Dennis
###############################################################################
rm(list = ls())
gc()
library(tidyverse)
library(readxl)
# Load in the data 
df <- read.csv('data/hospital.csv')

df <- df[, c(-1, -2)]
names(df) <- c("age", "gender", "smoking",
               "quarter 1", "quarter 2", "quarter 3", "quarter 4")



library(RColorBrewer)
corrplot::corrplot(cor(df[, 4:ncol(df)]), order = "AOE", tl.col = "black",  tl.srt = 45,tl.cex = 0.8, diag = FALSE,
                   col=brewer.pal(n=8, name="RdYlBu"))
