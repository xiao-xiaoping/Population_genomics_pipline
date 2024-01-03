library(ggplot2)
library(RColorBrewer)
library(ggsci)
#read data
data<- read.table("pca_98.eigenvec",sep ="\t",header=T)
eigenval <- scan("pca_98.eigenval")
# first convert to percentage variance explained
pve <- data.frame(PC = 1:98, pve = eigenval/sum(eigenval)*100)
#pve_plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light()
# calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)
#pca_plot
pca <- ggplot(data,aes(x=PC1,y=PC2,color=Group))+ geom_point(size=3)+ scale_color_npg()
ggsave(pca12, file='pca_pc12.pdf', width=8, height=6)