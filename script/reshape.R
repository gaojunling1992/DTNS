dat<-read.table("similar.tab",sep="\t",header=F)
colnames(dat)<-c("host","guest","num")
library(reshape)
dat2=cast(dat,host~guest,value="num")
write.table(dat2,file="SimilarFarme.tab",row.names=F,col.names=T,quote=F,sep="\t")


#dat=data.frame(host=c("A","A","A","E","E","G"),
#               guest=c("C","B","D","Q","F","W"),
#               num=c(2,1,2,3,0,2))
#library(reshape)
#dat2=cast(dat,host~guest,value="num")
#ggg<-as.vector(e$V1)
#g<-a[,ggg]
