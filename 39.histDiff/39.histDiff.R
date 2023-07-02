## setup
dir = "~/Documents/learn/visuals-R/"
setwd(paste0(dir,"39.histDiff")) 
pacman::p_load(ggplot2, plyr, gridExtra, grid, UpSetR, RColorBrewer)


## simulate data
data <- data.frame(Control = rnorm(1000, mean = 500, sd = 200),
                   Case = rnorm(1000, mean = 400, sd = 200))

head(data)


## plot
pdf("histDiff.pdf", height = 4, width = 6)

ggplot(data)+
  geom_histogram(aes(Case), binwidth = 20,
                 color = "white", fill = "#cc7833", alpha = 0.5)+
  geom_histogram(aes(Control), binwidth = 20,
                 color = "white", fill = "#75aadb", alpha = 0.5)+
  ggtitle("Density Histogram")+
  xlab("Density")+
  ylab("Expression")+
  theme_bw()

dev.off()