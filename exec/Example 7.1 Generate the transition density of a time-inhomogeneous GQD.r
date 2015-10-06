 library(DiffusionRgqd)
 GQD.remove()

 G0 <- function(t){2*(10+sin(2*pi*(t-0.5)))}
 G1 <- function(t){-2}
 Q1 <- function(t){0.25*(1+0.75*(sin(4*pi*t)))}

 states    <- seq(5,15,1/10)
 initial   <- 8
 Tmax      <- 5
 Tstart    <- 1
 increment <- 1/100

 M <- GQD.density(Xs=initial,Xt=states,s=Tstart,t=Tmax,delt=increment)

 library(rgl)
 open3d(windowRect=c(50,50,640+50,50+640),zoom=0.95)
 persp3d(x=M$Xt,y=M$time,z=M$density,col=3,box=F,xlab='State (X_t)',ylab=
 'Time(t)',zlab='Density f(X_t|X_s)')
