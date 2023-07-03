## setup
dir = "~/Documents/learn/visuals-R/"
pacman::p_load(ggplot2, tidyverse, corrplot, ComplexHeatmap)



## simulate data set
cor_matrix <- cor(mtcars)

corr_matrix <- cor_matrix  # 复制相关性矩阵

corr_matrix[corr_matrix == 1] <- NA # 将值为1的元素替换为NA
corr_matrix[upper.tri(corr_matrix) & corr_matrix > 0] <- 0  # 上三角大于0的值替换为0
corr_matrix[lower.tri(corr_matrix) & corr_matrix < 0] <- 0  # 下三角小于0的值替换为0
p.mat <- cor.mtest(cor_matrix)$p  # 计算相关系数的显著性
# preprocessing
p.mat[p.mat == 0] <- 0 
p.mat[corr_matrix != 0] <- 1


## plot
ht_list <- Heatmap(
  corr_matrix, 
  name = " ", 
  border = "white",
  col = colorRampPalette(c("#417e46", "#f7f8f9", "#6f2f7e"))(100),
  rect_gp = gpar(col = "white", lwd = 2),
  column_order = colnames(corr_matrix),
  row_order = rownames(corr_matrix),
  row_names_side = "left",  # 行标签放在左边
  column_names_side = "top",   # 列标签放在上边
  row_names_gp = gpar(
    fontsize = 10),
  column_names_gp = gpar(
    fontsize = 10),
  heatmap_legend_param = list(
    title = "correlation", 
    direction = "horizontal",
    legend_width = unit(10, "cm"),
    legend_height = unit(4, "cm")),
  cell_fun = function(j, i, x, y, w, h, fill) {
    if(p.mat[i, j] > 0.05) { # 为了结果美观修改，实际上因该上<0.05,可以加群讨论
      grid.text("*", x, y,
                gp = gpar(col = 'white',
                          fontsize = 25))
    } 
  }
)

pdf('C:/Users/tuooo/OneDrive/Desktop/visual-R/44.asymmetricheatmap/cor_heapmap.pdf',width = 8,height = 8)
draw(ht_list, heatmap_legend_side = "bottom")
dev.off()