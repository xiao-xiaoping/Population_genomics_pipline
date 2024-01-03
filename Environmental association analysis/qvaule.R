library(LEA)
library(tidyverse)


data <- read.table("fastlmm_p.out.txt", header=T)
## FDR control: Benjamini at level q
data$qvalue_b <- p.adjust(data$Pvalue,method = "bonferroni")
significant_snps.b <- data[data$qvalue_b < 0.01,]
write.table(significant_snps.b, file = "fastlmm_p.out_sig1_b.txt", sep = "\t", row.names = FALSE)
write.table(data, file = "fastlmm_p.out_b.txt", sep = "\t",row.names = FALSE)
