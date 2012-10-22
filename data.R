setwd('/home/git/seimunai/')
require(reshape)
require(ggplot2)
vote=read.table('getdata/items.csv',encoding='utf-8',sep=',',header=T,stringsAsFactors=F)
#vote=vote[which(vote$url_id<5035),]
tmp=as.character(vote[which(vote$url_id>9530),]$partija)
#vote=data.matrix(dcast(vote,seimunas+partija~url_id,value.var=('balsas') ))
factor=as.factor(vote$partija)
if(length(grep('AŽF',levels(factor)))>0)
  levels(factor)[grep('AŽF',levels(factor))]=levels(factor)[grep('LCSF',levels(factor))]

if(length(grep('TPPF',levels(factor)))>0)
  levels(factor)[grep('TPPF',levels(factor))]=levels(factor)[grep('LCSF',levels(factor))]


if(length(grep('JF',levels(factor)))>0)
  levels(factor)[grep('JF',levels(factor))]=levels(factor)[grep('LCSF',levels(factor))]

if(length(grep('TSF',levels(factor)))>0)
  levels(factor)[grep('TSF',levels(factor))]=levels(factor)[grep('TSLKDF',levels(factor))]

if(length(grep('NSF',levels(factor)))>0)
  levels(factor)[grep('TSF',levels(factor))]=levels(factor)[grep('LSDPF',levels(factor))]

if(length(grep('VLF',levels(factor)))>0)
  levels(factor)[grep('VLF',levels(factor))]=levels(factor)[grep('KPF',levels(factor))]

levels(factor)[which(sapply(levels(factor),nchar)==2)]=c("NO PARTY")
vote$partija=factor
vote=data.matrix(dcast(vote,partija~url_id,value.var=('balsas') ))
rownames(vote)=levels(factor)
vote=dist(vote %*% t(vote))
vote=cmdscale(vote)
vote=data.frame(x=as.numeric(vote[,1]),y=as.numeric(vote[,2]),party=rownames(vote))
#plot(vote)
#text(vote,tmp)

ggplot(vote,aes(x,y,color=party))+geom_text(aes(label=party))