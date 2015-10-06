GQD.estimates = function(x,thin = 100, burns)
{
  if(class(x)=='GQD.mle')
  {
    sigma <- sqrt(diag(solve(-x$opt$hessian)))
    upper <- x$opt$par+1.96*sigma
    Lower <- x$opt$par-1.96*sigma
    EstCI <- data.frame(Estimate=x$opt$par, Lower_95=Lower,Upper_95=upper)
    rownames(EstCI) <- paste0('theta[',1:length(x$opt$par),']')
    return(data.frame(round(EstCI,3)))
  }

   if(class(x)=='GQD.mcmc')
  {
     if(missing(burns))
     {
        burns.try =min(round(dim(x$par.matrix)[1]/2),25000)
        burns     = x$model.info$burns
        if(burns!=burns.try){burns=burns}else{burns=burns.try}
     }
     windw = seq(burns,dim(x$par.matrix)[1],thin)
     est = apply(x$par.matrix[windw,], 2, mean)
     CI=t(apply(x$par.matrix[windw,], 2, quantile,probs = c(0.05,0.95)))
     dat=data.frame(cbind(round(cbind(est,CI),3),'|',round(cor(x$par.matrix[windw,]),2)))
     rownames(dat)=paste0('theta[',1:dim(x$par.matrix)[2],']')
     colnames(dat) = c('Estimate','Lower_90','Upper_90','|',paste0('cor[,',1:dim(x$par.matrix)[2],']'))
     nper=dim(x$par.matrix)[2]
      if(nper==1){par(mfrow=c(1,2))}
      if(nper==2){par(mfrow=c(2,2))}
      if(nper==3){par(mfrow=c(2,2))}
      if(nper>3)
      {
        d1=1:((nper)+1)
        d2=d1
        O=outer(d1,d2)
        test=O-((nper)+1)
        test[test<0]=100
        test=test[1:4,1:4]
        test
        wh=which(test==min(test))

        d1=d1[col(test)[wh[1]]]
        d2=d2[row(test)[wh[1]]]
        par(mfrow=c(d1,d2))
      }
      cols=rainbow(nper)
     for(i in 1:dim(x$par.matrix)[2])
     {
        acf(x$par.matrix[windw,i],main=paste0('ACF: theta[',i,']\nThin=',thin,', Burns=',burns,', N=',length(windw)),col = cols[i],lwd=2)
     }
     return(dat)
  }

}
