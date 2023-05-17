library(tidyverse)
library(gghalves)


min <- runif(20, min = -0.3, max = 0.1)
max <- runif(20, min = 0.2, max = 0.9)

####### 构造模拟数据 ---------------
data <- data.frame(otus = rep(paste0("otu", 1), 100),
                   correlation = runif(100, min = min[1], max = max[1]),
                   group = sample(c("Specialist phage", "Generalist phage"),
                                  100, replace = T))

# 批量构建数据，这一步的目的是尽量保证组与组之间差别大一些
for (i in 2:20) {
  data_tmp <- data.frame(otus = rep(paste0("otu", i), 100),
                         correlation = runif(100, min = min[i], max = max[i]),
                         group = sample(c("Specialist phage", "Generalist phage"),
                                        100, replace = T))
  data <- rbind(data, data_tmp)
}

########### 绘图 -------------------
ggplot(data, aes(otus, correlation))+
  # 绘制分半箱线图：
  geom_half_boxplot(fill = "#75aadb", alpha = 0.6)+
  # 绘制分半散点图：
  geom_half_point_panel(aes(color = group), size = 0.5,
                        # 调整抖动散点的宽度：
                        transformation = position_jitter(width = 0.2))+
  # 添加横线：
  geom_hline(yintercept = 0, color = "grey", linetype = "dashed")+
  # 散点颜色模式：
  scale_color_manual(name = "", values = c("#a1b4c3", "#fbc47e"))+
  # 主题调整：
  theme_classic()+
  # 调整图例位置：
  theme(legend.position = "top")+
  # 修改图例散点大小：
  guides(color = guide_legend(override.aes = list(size = 4)))

ggsave("half-boxplot-dots/plot.pdf", height = 5, width = 10)
