#################################################
# Plotting the Sorbinil Joint distribution
# For the symmetric model
# #############################################

suppressPackageStartupMessages({
  library(ggplot2)
})

# Load in the data
sorbinal_data <- read.csv("data/sorbinil_data.csv")
sorbinal_data <- sorbinal_data[, c(-1, -2)]
sorbinal_fit <- read.csv("data/sorbinil_distributions.csv")
names(sorbinal_fit) <- c("t11", "t10", "t01", "t00")

df <- cbind(sorbinal_data, sorbinal_fit) |>
  dplyr::group_by(left_eye, right_eye) |>
  dplyr::summarise_all(sum)



means <- matrix(c(
  1.8700, 1.8700,
  1.8700, 2.3000,
  2.3000, 1.8700,
  2.3000, 2.3000
), byrow = TRUE, ncol = 2)

##

# Define colors to use to match d61

d61_green <- rgb(48, 184, 136, maxColorValue = 255)

cpal <- list(
  green = rgb(48, 184, 136, maxColorValue = 255),
  plum = rgb(109, 32, 119, maxColorValue = 255),
  dark_mint = rgb(0, 122, 83, maxColorValue = 255),
  vermillion = rgb(228, 0, 43, maxColorValue = 255),
  ocean_blue = rgb(0, 75, 135, maxColorValue = 255),
  midnight_blue = rgb(0, 49, 60, maxColorValue = 255),
  fuchsia = rgb(223, 25, 149, maxColorValue = 255),
  forest = rgb(120, 190, 32, maxColorValue = 255),
  gold = rgb(255, 184, 28, maxColorValue = 255),
  teal = rgb(45, 204, 211, maxColorValue = 255)
)

grid_points <- expand.grid(
  x_axis = seq(0, 4, by = 0.5),
  y_axis = seq(0, 4, by = 0.5)
)

thm <-
  theme_minimal() +
  theme(
    legend.position = "none",
    axis.text = element_text(
      size = 14, face = "bold",
      color = cpal$midnight_blue
    ),
    axis.ticks = element_blank(),
    axis.title = element_text(
      size = 20, face = "italic",
      color = cpal$midnight_blue
    ),
    panel.grid.major = element_line(colour = "black", size = 0.2),
    panel.grid.minor = element_line(colour = "black", size = 0.2),
    panel.border = element_blank(),
  )


plot_margin <- function(
    df,
    x = right_eye,
    y = left_eye,
    tt,
    mean_x,
    mean_y,
    x_lab,
    y_lab) {
  grid_points <- expand.grid(
    x_axis = seq(0, 4, by = 0.5),
    y_axis = seq(0, 4, by = 0.5)
  )
  ggplot2::ggplot(
    df,
    ggplot2::aes(
      x = {{ x }},
      y = {{ y }},
      size = {{ tt }},
      alpha = {{ tt }}
    )
  ) +
    ggplot2::geom_point(data = df, aes(size = {{ tt }})) +
    ggplot2::geom_point(
      data = df,
      ggplot2::aes(x = mean_x, y = mean_y),
      colour = d61_green,
      shape = 17,
      size = 15
    ) +
    ggplot2::scale_size_continuous(range = 100 * range(df |> dplyr::pull({{ tt }}))) +
    ggplot2::geom_point(
      data = grid_points,
      ggplot2::aes(x_axis, y_axis),
      size = 0.5,
      inherit.aes = FALSE
    ) +
    ggplot2::xlab(x_lab) +
    ggplot2::ylab(y_lab) +
    ggplot2::xlim(0, 4) +
    ggplot2::ylim(0, 4) +
    thm
}

p1 <- plot_margin(
  df,
  x = right_eye,
  y = left_eye,
  tt = t11,
  mean_x = means[1, 1],
  mean_y = means[1, 2],
  x_lab = "sorbinal",
  y_lab = "sorbinil"
) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

p2 <- plot_margin(
  df,
  x = right_eye,
  y = left_eye,
  tt = t01,
  mean_x = means[2, 1],
  mean_y = means[2, 2],
  x_lab = "placebo",
  y_lab = "sorbinil"
) +
  theme(
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

p3 <- plot_margin(
  df,
  x = right_eye,
  y = left_eye,
  tt = t10,
  mean_x = means[3, 1],
  mean_y = means[3, 2],
  x_lab = "sorbinil",
  y_lab = "placebo"
)


p4 <- plot_margin(
  df,
  x = right_eye,
  y = left_eye,
  tt = t00,
  mean_x = means[4, 1],
  mean_y = means[4, 2],
  x_lab = "placebo",
  y_lab = "placebo"
) +
  theme(
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  )

ggpubr::ggarrange(plotlist = list(p1, p2, p3, p4), ncol = 2, nrow = 2)
ggsave("figures/sorbinil_pmfs.png")
