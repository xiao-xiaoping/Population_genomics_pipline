library(pophelper)
##read the result of admixture
admix <- list.files("admix", pattern = ".txt", full.names = T)
info <- read.table("sample_admix, stringsAsFactors = F)
onelabset1 <- info[1]
qlist_admix <- readQ(admix)
for(i in 1:length(qlist_admix)){
  row.names(qlist_admix[[i]]) <- info$sample
}
mink <- 2
maxk <- 6
k_order <- 1:length(qlist_admix)
klab=c(2,3,4,5,6)
plotQ(qlist_admix[k_order], imgoutput="join",sortind=NA,barbordersize=NA,outputfilename="admixture",imgtype="pdf", showindlab=F, showlegend=F, 
          sharedindlab =F,useindlab = T, showyaxis = T, basesize = 3, sppos = "right", showticks = T,splab = paste0("K = ", klab), splabsize = 8,                     splabface="bold",grplab=onelabset1,grplabspacer=0.05,grplabsize=2,grplabangle=90,grplabheight=1,width = 10, height = 2, panelspacer = 0.04,
          barbordercolour = NA,exportpath=getwd())