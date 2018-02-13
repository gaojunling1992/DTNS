library(pheatmap)
a<-read.table("SimilarFarme.tab",row.names = 1,header = T,sep="\t")
annotation = read.table("annotation.tab",row.names=1,header=F,sep="\t")
colnames(annotation)=c("cancer","ATC")

pheatmap(a,color=colorRampPalette(rev(c("red","white","blue")))(100),
		 annotation_col=annotation,annotation_row=annotation,
		 show_rownames=F,show_colnames=F, legend=T,file="a.png")
