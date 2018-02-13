a<-read.table("score.tab",header = T)
rownames(a)<-a$Drug
attach(a)

a$score1<-(c_target_cancer_direct_A_scoreA-min(c_target_cancer_direct_A_scoreA))/
  (max(c_target_cancer_direct_A_scoreA)-min(c_target_cancer_direct_A_scoreA))
a$score2<-(c_target_cancer_degree_B_scoreA-min(c_target_cancer_degree_B_scoreA))/
  (max(c_target_cancer_degree_B_scoreA)-min(c_target_cancer_degree_B_scoreA))
a$score3<-(c_target_cancerB_degree_B_scoreB-min(c_target_cancerB_degree_B_scoreB))/
  (max(c_target_cancerB_degree_B_scoreB)-min(c_target_cancerB_degree_B_scoreB))

S1<-(c_target_cancer_direct_A/c_target_A)*a$score1
S2<-((c_target_cancer_second_A/c_target_A)*(c_target_cancer_B/(c_target_B+1)))^0.5*a$score2
S3<-(c_target_cancerB_B/(c_target_B+1))*a$score3

ccc<-data.frame(S1,S2,S3)
View(ccc)
a$score<-S1+S2+S3

b<-read.table("all_cancer_drug.list",header = F)

m<-match(b$V1,row.names(a))
m<-m[!is.na(m)]
cancer<-a[m,]
cancer<-cancer[!is.na(cancer$score),]

c<-a[!is.na(a$score),]

library(ggplot2)
p<-ggplot(cancer,aes(score,..density..))+geom_histogram(binwidth=0.1)
p
ggplot(c,aes(score,..density..))+geom_histogram(binwidth=0.1)

write.table(a,file="score4.tab",sep="\t",col.names = T,row.names=F,quote=F)
detach(a)
