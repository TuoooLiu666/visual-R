
library(ggpubr)                 
dir = "~/Documents/learn/visuals-R/"
inputFile="input.txt"           
outFile="ggballoonplot.pdf"     
setwd(paste0(dir,"15.ggballoonplot"))     
data=read.table(inputFile,header=T,sep="\t",check.names=F,row.names=1)

#绘制气泡图
pdf(file=outFile,width=8,height=7)
ggballoonplot(data, fill = 'value') + 
  gradient_fill(c('blue', 'white', 'red'))
dev.off()
