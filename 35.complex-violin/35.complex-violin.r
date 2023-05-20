## setup
dir = "~/Documents/learn/visuals-R/"
setwd(paste0(dir,"35.complex-heatmap"))  

# create example dataset
testA = matrix(runif(n = 380,0,1), 20, 19)
colnames(testA) =  paste0('cancer',LETTERS[1:19])
row.names(testA) =  paste0('sample',1:20)

## plot
### reshape data
library(reshape2)
datA = melt(testA,
            varnames = c('sample','cancer'),
            value.name = 'exp')

## color 
get_label_colors <- function(labels, pal="Dark2", labels_unique=NULL, alpha=1){
  if (is.null(labels_unique)){
    labels_unique <- sort(unique(labels))
  }
  palette <- RColorBrewer::brewer.pal(n=RColorBrewer::brewer.pal.info[pal, "maxcolors"], pal)
  
  lab2col <- list()
  i <- 1
  for (lab in labels_unique){
    lab2col[[lab]] <- grDevices::adjustcolor(palette[(i-1) %% length(palette) + 1], alpha)
    i <- i + 1
  }
  
  colors <- c()
  for (lab in labels){
    colors <- c(colors, lab2col[[lab]])
  }
  
  colors
}

colors = get_label_colors(unique(datA$cancer))

## fig
p1 <- ggplot(datA, aes(cancer,exp,fill = cancer))+
  geom_violin() + 
  coord_flip()+
  scale_fill_manual(values = colors) +
  stat_summary(fun= mean, geom = "point",
               shape = 19, size = 2, color = "black")+
  theme_bw()+
  geom_hline(aes(yintercept=0.6), colour="#565354", linetype="dashed")+
  geom_hline(aes(yintercept=0.3), colour="#565354", linetype="dashed")+
  xlab('')+
  ylab('A indicator\nindicator A')+
  theme(panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        axis.text.y = element_text(size = 12,
                                   face="bold"),
        legend.title=element_blank(),
        legend.position = 'none')

p1

## remove y axis
remove_y <- theme(
  axis.text.y = element_blank(),
  axis.ticks.y = element_blank(),
  axis.title.y = element_blank()
)

p <- list(
  p1,
  p1 + remove_y,
  p1+ remove_y,
  p1+ remove_y
)

# patch plots 
library(patchwork)
wrap_plots(p, nrow = 1) 
ggsave('complex_violin.pdf',width = 8,height = 6)
