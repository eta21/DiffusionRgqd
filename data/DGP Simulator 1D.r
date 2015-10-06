 rm(list=ls(all=T))

 sim=function()
 {
    delt=1/2000
    tt=seq(0,100,delt)
    X=rep(7,length(tt))
    d=0
    for(i in 2:length(tt))
    {
       d=d+delt
       X[i]=X[i-1]+2*(5+3*sin(1*pi*d)-X[i-1])*delt      +0.5*sqrt(X[i-1])*rnorm(1,sd=sqrt(delt))

    }
    ttt = seq(1,length(tt),500)

    return(list(Xt=X[ttt],time=tt[ttt]))
 }

 rs=sim()

 write.table(data.frame(rs),'SDEsim1.txt',row.names=F)

 plot(rs$Xt~rs$time,type='l',col=2,ylim=c(0,20))