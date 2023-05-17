#install.packages("ggplot2")


#input txt
#Term: GO 
#Ratio: gene ratio
#Count: enrichment count
#FDR: adjusted p-value


library(ggplot2)          
inputFile="input.txt"      
outFile="bubble.pdf"       
setwd("D:\\biowolf\\bioR\\29.bubble")                
rt = read.table(inputFile, header=T, sep="\t", check.names=F)      

#sort term by ratio
labels=rt[order(rt$Ratio),"Term"]
rt$Term = factor(rt$Term,levels=labels)

#plot
p = ggplot(rt,aes(Ratio, Term)) + 
    geom_point(aes(size=Count, color=FDR))
p1 = p + 
     scale_colour_gradient(low="red",high="blue") + 
     labs(color="FDR",size="Count",x="Gene ratio",y="Term")+
     theme(axis.text.x=element_text(color="black", size=10),axis.text.y=element_text(color="black", size=10)) + 
     theme_bw()
ggsave(outFile, width=7, height=5)    
