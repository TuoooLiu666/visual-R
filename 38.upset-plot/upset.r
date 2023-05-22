## setup
dir = "~/Documents/learn/visuals-R/"
setwd(paste0(dir,"38.upset-plot")) 
pacman::p_load(ggplot2, plyr, gridExtra, grid, UpSetR, RColorBrewer)

# readin dataset from R package
movies <- read.csv(system.file("extdata", "movies.csv", package = "UpSetR"),
                   header=TRUE, sep=";" )


# plot
######### 批量修改 ---------------
# 先创建颜色，有多少个柱子就设置多少个颜色：
library(RColorBrewer)

colors <- colorRampPalette(brewer.pal(9, "Set1"))(27)

query_list <- list()

tmp <- unique(movies[, c("Drama", "Comedy", "Action", "Thriller", "Romance")])
tmp <- tmp[rowSums(tmp) != 0, ]

for (i in 1:27) {
  query_list[[i]] <- list(query = intersects,
                          params = list(colnames(tmp)[which(tmp[i,] == 1)]),
                          color= colors[i], active = T)
}

pdf("plot.pdf", height = 3, width = 6)
upset(movies,
      # 数据集数量：
      nsets = 5,
      # 柱形图与矩阵图大小比例：
      mb.ratio = c(0.65, 0.35),
      # 修改左侧柱形颜色：
      sets.bar.color = colors[sample(1:27, 5)],
      # 柱形排序：
      order.by = "freq", decreasing = T,
      # 修改条形的颜色和矩阵散点的颜色：
      queries = query_list,
      # 矩形散点的阴影颜色：
      shade.color = NA
)
dev.off()
