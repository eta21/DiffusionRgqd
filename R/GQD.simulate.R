GQD.simulate=function(Xs=0,s=0,t=10,delt=1/10,sim.delt=1/1000,M=1,Stype='Trajectory',seed=NULL)
{
  if(!is.null(NULL))
  {
     set.seed(seed)
  }
  pow=function(x,p)
  {
    x^p
  }
  prod=function(a,b){a*b}
  
  namess=c('G0','G1','G2','Q0','Q1','Q2')
  func.list=rep(0,6)
  obs=objects(pos=1)
  for(i in 1:6)
  {
    if(sum(obs==namess[i])){func.list[i]=1}
  }
  mmuu='('
  ssgg=mmuu
  for(i in 1:3)
  {
    if(func.list[i]==1)
    {
      mmuu=paste0(mmuu,'+(',body(namess[i])[2],')*X^',i-1)
    }
    if(func.list[i+3]==1)
    {
      ssgg=paste0(ssgg,'+(',body(namess[i+3])[2],')*X^',i-1)
    }
  }
  mmuu=paste0(mmuu,')')
  ssgg=paste0(ssgg,')')
  
  mu=function(X,t){}
  body(mu)= parse(text = mmuu)
  sig=function(X,t){}
  body(sig)= parse(text = ssgg)
  
  
  #print(body('sig'))
  #print(body('mu'))
  X=rep(Xs,M)
  d=s
  d2=s+delt
  tt=seq(s,t,sim.delt)
  tt2=seq(s,t,delt)
  
  if(Stype=='Trajectory')
  {
    storage = matrix(0,M,length(tt2))
    storage[,1]=X
    k=1
    for(i in 2:length(tt))
    {
      X=X+mu(X,d)*sim.delt+sqrt(abs(sig(X,d)))*rnorm(M,sd=sqrt(sim.delt))
      d=d+sim.delt
      if(round(d2,5)==round(d,5))
      {
        k=k+1
        storage[,k] = X
        d2=d2+delt
      }
    }
  }
  if(Stype=='Terminal')
  {
    for(i in 2:length(tt))
    {
      X=X+mu(X,d)*sim.delt+sqrt(abs(sig(X,d)))*rnorm(M,sd=sqrt(sim.delt))
      d=d+sim.delt
    }
    storage=X
    tt2 = NA
  }
  if(M==1)
  {return(list(paths=storage[1,],time=tt2))}
  return(list(paths=storage,time=tt2))
  

}