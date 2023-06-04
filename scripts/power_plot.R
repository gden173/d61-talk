################################################################################
# Power Heatmap plot
################################################################################
# Read in the data 
csv_name <- "data/power_simulation.csv"
library(tidyverse)
library(hrbrthemes)
library(viridis)
library(latex2exp)
install.packages('extrafont')
library(extrafont)
font_import()
loadfonts()
fonttable()
df <- read.csv(csv_name, header=FALSE)
names(df) <- paste0(seq(-1, 1, length.out = 21))
df$beta21 <- paste0(seq(-1, 1, length.out = 21))
df <- gather(df,key="beta11", value="power", -beta21)
df$beta21 <- factor(df$beta21, levels = paste0(seq(-1, 1, length.out = 21)))
df$beta11 <- factor(df$beta11,levels = paste0(seq(-1, 1, length.out = 21)))
library(RColorBrewer)
library(viridisLite)
#coul <- colorRampPalette(brewer.pal(8, "PuBuGn"))(100)
p <- ggplot(df, aes(beta11, beta21, fill= power)) + 
  geom_tile() + scale_fill_viridis(discrete=FALSE, direction = -1)  + 
  labs(x = TeX('$\\beta_{(1)}$'),y = TeX('$\\beta_{(2)}$'))  + 
  theme(axis.title.y = element_text(angle = 0, vjust = 0.5, size=20,face="bold"),
        axis.title.x = element_text(size=20, face="bold"),
        axis.text = element_text(size=18, face="italic"), 
        legend.text=element_text(size=13), 
        legend.title = element_blank(), 
        legend.key.width = unit(1, "cm"), 
        legend.key.height = unit(3.93, "cm")
        ) + 
  scale_x_discrete(breaks =c("0.5", "0", "-0.5")) + 
  scale_y_discrete(breaks =c("0.5", "0", "-0.5"))  + 
  coord_fixed(ratio = 1)
ggsave("power_surface.png", plot = p)
