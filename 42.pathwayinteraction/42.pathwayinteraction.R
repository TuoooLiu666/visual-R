## setup
dir = "~/Documents/learn/visuals-R/"
pacman::p_load(ggplot2, tidyverse, ktplots, SingleCellExperiment,reticulate)

## load data & ready
ad=import('anndata')

adata = ad$read_h5ad('rna.h5ad')
counts <- Matrix::t(adata$X)
row.names(counts) <- row.names(adata$var)
colnames(counts) <- row.names(adata$obs)
sce <- SingleCellExperiment(list(counts = counts), colData = adata$obs, rowData = adata$var)

means <- read.delim('out/means.txt', check.names = FALSE)
pvalues <- read.delim('out/pvalues.txt', check.names = FALSE)
deconvoluted <- read.delim('out/deconvoluted.txt', check.names = FALSE)
interaction_grouping <- read.delim('interactions_groups.txt')

