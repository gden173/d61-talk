###############################################################################
# Analysis of the butterfly data set 
# Gabriel Dennis
###############################################################################
rm(list = ls())
gc()
library(tidyverse)
library(readxl)
library(ggpubr)
# Load in the data 
dfy <- read_xlsx('data/butterfly_y.xlsx')
dfx <- read_xlsx('data/butterfly_x.xlsx')


# Load in the coefficients of the 14 dimensional model 
betas14 <- read.csv("data/butterfly_14_coefficients.csv")

# Give it row names
row.names(betas14) <- c("intercept", "building","urban.vegetation","mixed","short","tall")


# Get the predicted means 

dfx$intercept <- rep(1, 66)
dfx <- dfx[, c(6, 1:5)]

# Predictions
pred <- exp(as.matrix(dfx) %*% as.matrix(betas14))
plot_list<- list()
# Plot predictions vs data 
for (i in 1:14) {
  data = data.frame("prediction" = pred[, i], "counts" = as.matrix(dfy[, colnames(pred)[i]]))
  names(data)[2] <- "counts"
  plot_list[[i]] <- ggplot(data, aes(counts, prediction)) +
    geom_point(size=3) + ggtitle(tolower(str_replace_all(colnames(pred)[i], "[.]", " "))) +
    xlab("") + ylab("") + 
    theme( axis.text = element_blank(), 
           plot.title = element_text(size = 20, face = "italic", 
                                     hjust=0.5))
}
ggarrange(plotlist = plot_list, ncol=3, nrow=5)

ggsave("butterfly_14d_poisson.png",  plot = last_plot(),
      
       dpi=500)



#######################################################################
M <- cor(dfy)

library(RColorBrewer)
corrplot::corrplot(M, order = "AOE", tl.col = "black",  tl.srt = 45,tl.cex = 0.8, diag = FALSE,
         col=brewer.pal(n=8, name="RdYlBu"))
ggsave("butterfly_14d_corr.png")
