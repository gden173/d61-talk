################################################################################
# Author: Gabriel Dennis
# Analysis of butterfly data set for top 3 species
################################################################################
rm(list = ls())
gc()
# Libraries
library(tidyverse)
library(ggpubr)
# Load the data 
load('data/fh-butter.RData')

# Load the predictions 
pred <- read.csv('data/butterfly3d_predictions.csv')
# environment variables
# response variables

# Top three species: Colias.philodice,Pieris.rapae, Colias.eurytheme

# Covariates:

# ------------------------------------------------------------------------------
species <- c("Colias.philodice","Pieris.rapae", "Colias.eurytheme")
top3 <- resp[, species]
names(pred) <- species
titles <- c("colias philodice","pieris rapae", "colias eurytheme")
plot_list<- list()
# Plot predictions vs data 
for (i in 1:3) {
  data = data.frame("prediction" = pred[, i], "counts" = as.matrix(top3[, i]))
  names(data)[2] <- "counts"
  plot_list[[i]] <- ggplot(data, aes(counts, prediction)) +
                    geom_point(size=5) + ggtitle(species[i]) +
                    xlab("") + ylab("")  + ggtitle(titles[i])+
                    scale_x_continuous(limits = c(0, 70)) + 
                    scale_y_continuous(limits = c(0, 25)) +
                    theme(plot.title = element_text(size = 25, face = "italic", hjust = 0.5), 
                          axis.text = element_text(size=20))
   
}
ggarrange(plotlist = plot_list, ncol=3, nrow=1)

ggsave("butterfly_3d_poisson.png")

# print(xtable(coefficients, display=c("s","s", "g","g","g","g")), math.style.exponents = TRUE, include.rownames = F)

