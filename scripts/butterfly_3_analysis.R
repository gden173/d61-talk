################################################################################
# Author: Gabriel Dennis
# Analysis of butterfly data set for top 3 species
################################################################################

# Libraries
suppressPackageStartupMessages({
  library(ggplot2)
  library(dplyr)
  library(ggpubr)
})

# Load the data
load("data/fh-butter.RData")

# Load the predictions
pred <- read.csv("data/butterfly3d_predictions.csv")
# environment variables
# response variables

# Top three species: Colias.philodice,Pieris.rapae, Colias.eurytheme

# Covariates:

# ------------------------------------------------------------------------------
species <- c("Colias.philodice", "Pieris.rapae", "Colias.eurytheme")
top3 <- resp[, species]
names(pred) <- species
titles <- c("Colias philodice", "Pieris rapae", "Colias eurytheme")
plot_list <- list()
# Plot predictions vs data
for (i in 1:3) {
  data <- data.frame("prediction" = pred[, i], "counts" = as.matrix(top3[, i]))
  names(data)[2] <- "counts"
  correlation <- cor(data$prediction, data$counts)
  b_name <- gsub("[.]", " ", colnames(pred)[i])

  ttl <- paste0(" `", b_name, "`: italic(", expression(italic(rho)), ")  ==italic(", round(correlation, 2), ")")
  print(ttl)
  sbtl <- paste0("(N==", sum(data$counts), ")")

  plot_list[[i]] <- ggplot(data, aes(counts, prediction)) +
    geom_point(aes(color = sqrt(counts^2 + prediction^2)), size = 5) +
    scale_color_gradient(
      low = "grey",
      high = cpal$vermillion,
    ) +
    labs(
      title = parse(text = ttl),
      subtitle = parse(text = sbtl)
    ) +
    xlab("") +
    ylab("") +
    scale_x_continuous(limits = c(0, 70)) +
    scale_y_continuous(limits = c(0, 25)) +
    theme_minimal() +
    theme(
      legend.position = "none",
      plot.subtitle = element_text(
        hjust = 0.5,
        size = 20,
        face = "italic",
        family = "serif"
      ),
      plot.title = element_text(
        size = 25,
        face = "italic",
        hjust = 0.5,
        family = "serif",
      ),
      axis.text = element_text(size = 20, face = "italic", family = "serif", color = "black"),
      panel.grid.minor = element_blank(),
    )
}
ggarrange(plotlist = plot_list, ncol = 3, nrow = 1)

ggsave("figures/butterfly_3d_poisson.png")
