###############################################################################
# Analysis of the butterfly data set
# Gabriel Dennis
###############################################################################

suppressPackageStartupMessages({
  library(dplyr)
  library(readxl)
  library(ggpubr)
})

# Load in the data
dfy <- read_xlsx("data/butterfly_y.xlsx")
dfx <- read_xlsx("data/butterfly_X.xlsx")

# Load in the coefficients of the 14 dimensional model
betas14 <- read.csv("data/butterfly_14_coefficients.csv")

# Give it row names
row.names(betas14) <- c(
  "intercept",
  "building",
  "urban.vegetation",
  "mixed",
  "short",
  "tall"
)


# Get the predicted means

dfx$intercept <- rep(1, 66)
dfx <- dfx[, c(6, 1:5)]

# Predictions
pred <- exp(as.matrix(dfx) %*% as.matrix(betas14))

plot_list <- list()
# Plot predictions vs data
for (i in 1:14) {
  data <- data.frame(
    "prediction" = pred[, i],
    "counts" = as.matrix(dfy[
      , colnames(pred)[i]
    ])
  )
  names(data)[2] <- "counts"

  correlation <- cor(data$prediction, data$counts)
  b_name <- gsub("[.]", " ", colnames(pred)[i])

  ttl <- paste0(" `", b_name, "`: italic(", expression(italic(rho)), ")==italic(", round(correlation, 2), ")")
  sbtl <- paste0("(N==", sum(data$counts), ")")
  print(ttl)

  plot_list[[i]] <- ggplot(data, aes(counts, prediction)) +
    geom_point(size = 2, alpha = 0.6) +
    labs(
      title = parse(text = ttl),
      subtitle = parse(text = sbtl)
    ) +
    xlim(0, max(data$counts)) +
    ylim(0, max(data$prediction)) +
    xlab("") +
    ylab("") +
    theme_minimal() +
    theme(
      axis.text = element_blank(),
      axis.ticks = element_blank(),
    plot.subtitle = element_text(hjust = 0.5), 
      plot.title = element_text(
        size = 14,
        face = "italic",
        hjust = 0.5,
        family = "serif",
      ),
      panel.grid.major = element_line(colour = "grey", size = 0.2),
      panel.grid.minor = element_blank()
    )
}

ggpubr::ggarrange(plotlist = plot_list, ncol = 3, nrow = 5, align = "v")

ggsave("figures/butterfly_14d_poisson.png",
  plot = last_plot(),
  dpi = 500
)



#######################################################################
# M <- cor(dfy)
#
# library(RColorBrewer)
# corrplot::corrplot(M,
#   order = "AOE", tl.col = "black", tl.srt = 45, tl.cex = 0.8, diag = FALSE,
#   col = brewer.pal(n = 8, name = "RdYlBu")
# )
# ggsave("butterfly_14d_corr.png")


## How to combine "math" and numeric variables :
plot(1:10, type = "n", xlab = "", ylab = "", main = "plot math & numbers")
theta <- 1.23
mtext(bquote(hat(theta) == .(theta)), line = .25)
for (i in 2:9) {
  text(i, i + 1, substitute(
    list(xi, eta) == group("(", list(x, y), ")"),
    list(x = i, y = i + 1)
  ))
}
