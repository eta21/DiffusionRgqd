library(DiffusionRgqd)
# Remove any existing coefficients:
GQD.remove()
# Define the X dimesnion coefficients:
a10 <- function(t){1}
a11 <- function(t){-0.4}
c10 <- function(t){0.05}
# Define the Y dimension coefficients:
b01 <- function(t){-1}
b11 <- function(t){0.4}
b02 <- function(t){-0.2}
f01 <- function(t){0.1}
# Approximate the transition density
res <- BiGQD.density(Xs=5,Ys=5,Xt=seq(1,7,length=50),Yt=seq(0,6,length=50),s=0,
t=10,delt=1/100)

# Load simulated trajectory of the joint expectation:
data(SDEsim3)
attach(SDEsim3)
# Record graphs at time points along the trajectory:
time.index <- c(10,300,750,1000) +1
for(i in time.index)
{
# Now illustrate the density using a contour plot:
filled.contour(res$Xt,res$Yt,res$density[,,i],
main=paste0('Transition Density \n (t = ',res$time[i],')'),
color.palette=colorRampPalette(c('white','green','blue','red'))
,xlab='Prey',ylab='Preditor',plot.axes=
{
# Add trajectory of simulated expectation:
lines(my~mx,col='black',lty='dashed',lwd=2)
# Show the predicted expectation from BiGQD.density():
points(res$cumulants[5,i]~res$cumulants[1,i],bg='white',pch=21,cex=1.5)
axis(1);axis(2);
# Add a legend:
legend('topright',lty=c('dashed',NA),pch=c(NA,21),lwd=c(2,NA),
legend=c('Simulated Expectation','Predicted Expectation'))
})
}
