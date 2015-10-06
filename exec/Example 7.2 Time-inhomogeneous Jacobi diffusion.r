library(DiffusionRgqd)
GQD.remove()

# Set some parameter values:
a <- 1.5; b <- 0.6; cc <- 1; X0 <- 0.5;

# Give the coefficient form of the diffusion.:
G0 <- function(t){a*(b*(1+0.25*sin(pi*t)))}
G1 <- function(t){-a}
Q1 <- function(t){cc}
Q2 <- function(t){-cc}
# What states should the density be evaluated at:
states=seq(1/1000,1-1/1000,1/1000)

# Generate the transitional density for truncation orders 4,6 and 8:
res1 <- GQD.density(X0,states,0,2,1/100,Dtype='Beta',Trunc=c(4,4))
res2 <- GQD.density(X0,states,0,2,1/100,Dtype='Beta',Trunc=c(6,6))
res3 <- GQD.density(X0,states,0,2,1/100,Dtype='Beta',Trunc=c(8,6))

N <- 100000 # Number of trajectories to simulate.
smdelt <- 1/1000 # Simulation stepsize.
d <- 0 # A variable for tracking time.
X <- rep(X0,N)
# Take snapshots of the density at these times.
when <- c(0,0.25,0.5,1,1.75)
for(i in 2:(2/smdelt))
{
# A Euler-Maruyama type approximation:
X <- pmax(pmin(X + (G0(d)+G1(d)*X)*smdelt
+sqrt(Q1(d)*X+Q2(d)*X^2)*rnorm(length(X),sd=sqrt(smdelt)),1),0)
d <- d+smdelt
if(any(when==round(d,3)))
{
index <- which(res1$time==round(d,3))
hist(X,col='gray85',freq=F,breaks=30,
main=paste0('Transitional Density at t = ',round(d,3)),ylim=c(0,3))
lines(res1$density[,index]~res1$Xt,col='red',lty='dotdash',lwd=2)
lines(res2$density[,index]~res2$Xt,col='green',lty='solid',lwd=2)
lines(res3$density[,index]~res3$Xt,col='blue',lty='dashed',lwd=2)
legend('top', legend=c('Truncation: (4,4).','Truncation: (6,6).',
'Truncation: (8,8).'), col = c('red','green','blue'),
lty=c('dotdash','solid','dashed'),lwd=2,bg='white')
}
}
