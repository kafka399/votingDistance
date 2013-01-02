setwd('/home/git/seimunai/')
require(reshape)
require(xts)
require(ggplot2)
vote=read.table('getdata/items14000.csv',encoding='utf-8',sep=',',header=T,stringsAsFactors=F)
vote=rbind(vote,read.table('getdata/items12000.csv',encoding='utf-8',sep=',',header=T,stringsAsFactors=F))

parl_names=as.factor(as.character(vote$pavarde))
parl_party=vote

vote$pavarde=parl_names
tmp=vote
vote=data.matrix(dcast(vote,pavarde~url_id,value.var=('balsas') ))
rownames(vote)=levels(parl_names)
vote=vote[-which(apply(vote,1, function(x) any(is.na(x)))),]
vote=dist(vote %*% t(vote))

vote=cmdscale(vote)
vote=data.frame(x=as.numeric(vote[,1]),y=as.numeric(vote[,2]),member=rownames(vote))
vote=cbind(vote,party=sapply(vote$member,function(x) parl_party$partija[last(which(as.character(x)==parl_party$pavarde))]))
vote$member = paste(vote$member,vote$party,sep='-')


ggplot(vote,aes(x,y,color=party))+geom_text(aes(label=member))
