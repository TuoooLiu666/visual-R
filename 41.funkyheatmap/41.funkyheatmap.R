## setup
dir = "~/Documents/learn/visuals-R/"
pacman::p_load(ggplot2, tidyverse, funkyheatmap, kableExtra)


## load data & inspect
dat1 <- diamonds %>% 
  rownames_to_column(., "id") %>% 
  head(20)

DT::datatable(dat1)

## basic plot
funky_heatmap(dat1, 
              column_info = NULL,
              row_info = NULL,
              column_groups = NULL,
              row_groups = NULL,
              palettes = NULL,
              scale_column = T,
              add_abc = T,
              col_annot_offset = 3,
              col_annot_angle = 35,
              removed_entries = NULL,
              expand = c(xmin = 0, xmax = 2, ymin = 0, ymax = 0)
)


## complex plot
# data ready
data("dynbenchmark_data")
dat2 <- dynbenchmark_data$data
colnames(dat2)[1:12]

preview_cols <- c(
  "id",
  "method_source",
  "method_platform",
  "benchmark_overall_norm_correlation",
  "benchmark_overall_norm_featureimp_wcor",
  "benchmark_overall_norm_F1_branches",
  "benchmark_overall_norm_him",
  "benchmark_overall_overall"
)
dat2[,preview_cols]


# plot
column_groups <- dynbenchmark_data$column_groups # column
column_info <- dynbenchmark_data$column_info 
row_groups <- dynbenchmark_data$row_groups  #row
row_info <- dynbenchmark_data$row_info
palettes <- dynbenchmark_data$palettes # color


p <- funky_heatmap(
  data = dat2,
  column_info = column_info,
  column_groups = column_groups,
  row_info = row_info,
  row_groups = row_groups,
  palettes = palettes,
  col_annot_offset = 3
)	

# ggsave("C:/Users/tuooo/OneDrive/Desktop/visual-R/41.funkyheatmap/funky-heatmap.png",
#        p,
#        width=15, height=8, 
#        units = "in", dpi = 720)
