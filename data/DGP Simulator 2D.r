
 rm(list=ls(all=T))
 
 sim=function()
 {
    delt=1/2000
    tt=seq(0,100,delt)

    X=rep(10,length(tt))
    Y=rep(5,length(tt))
    d=0
    for(i in 2:length(tt))
    {
       d=d+delt
       X[i]=X[i-1]+(1*7.5-1*X[i-1]+1.0*Y[i-1])*delt      +0.5*sqrt(X[i-1]*Y[i-1])*rnorm(1,sd=sqrt(delt))
       Y[i]=Y[i-1]+(1.5*5-1.5*Y[i-1]+3*sin(0.25*pi*d))*delt+0.25*sqrt(Y[i-1])*rnorm(1,sd=sqrt(delt))
    }
    ttt = seq(1,length(tt),500)
 
    return(list(Xt=X[ttt],Yt=Y[ttt],time=tt[ttt]))
 }
 
 rs=sim()

 write.table(data.frame(rs),'SDEsim4.txt',row.names=F)
 
 plot(rs$Xt~rs$time,type='l',col=2,ylim=c(0,20))
 lines(rs$Yt~rs$time,type='l',col=3)
 
