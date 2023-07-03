## setup
dir = "~/Documents/learn/visuals-R/"
pacman::p_load(ggplot2, tidyverse, readxl)


## load data
# data needs to be prepared before use
dat<-read_excel(paste0(dir,"data/20230521/figure1c.xlsx"))
head(dat)

plotrix::std.error(c(1,2,3))

dat %>% 
  rowwise() %>% 
  mutate(mean_value=mean(c(rep1,rep2,rep3)),
         std_error=plotrix::std.error(c(rep1,rep2,rep3))) %>% 
  ungroup() -> new.dat

