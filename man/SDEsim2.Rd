\name{SDEsim2}
\alias{SDEsim2}
\docType{data}
\title{
A Simulated Non-Linear Bivariate Diffusion
}
\description{
The dataset contains discretely sampled observations for a simulated stochastic differential equation (SDE) with dynamics:
\if{html}{
{\deqn{dX_t = 2.0(Y_t-X_t)dt+0.3sqrt(X_tY_t)dW_t}} 
{\deqn{dY_t = 1.0(5-Y_t)dt+0.5sqrt(Y_t)dB_t}} 
}
\if{latex}{
{\deqn{dX_t = 2.0(Y_t-X_t)dt+0.3\sqrt{X_tY_t}dW_t}} 
{\deqn{dY_t = 1.0(5-Y_t)dt+0.5\sqrt{Y_t}dB_t}} 
}
where \code{dW_t} and \code{dB_t} are standard Brownian motions, \code{t} is time and \code{X_0 = 5}, \code{Y_0 = 5}.}
\usage{data("SDEsim2")}
\format{
  A data frame with 801 observations on the following 3 variables.
  \describe{
    \item{\code{Xt}}{Xt trajectory of the diffusion.}
    \item{\code{Yt}}{Yt trajectory of the diffusion.}
    \item{\code{time}}{Time vector (\code{time[i+1]-time[i] = 1/8}).}
  }
}

\details{
For a full analysis of this dataset check out Example 7.5 in the example scripts at \url{https://github.com/eta21/DiffusionRgqd-Downloads}. 
}
\examples{
 data(SDEsim2)
  data(SDEsim2)
  attach(SDEsim2)
  # Have a look at the time series:
  plot(Xt~time,type='l',col='blue',ylim=c(2,10),main='Simulated Data',xlab='Time (t)',ylab='State',
       axes=FALSE)
  lines(Yt~time,col='red')
  expr1=expression(dX[t]==2(Y[t]-X[t])*dt+0.3*sqrt(X[t]*Y[t])*dW[t])
  expr2=expression(dX[t]==(5-Y[t])*dt+0.5*sqrt(Y[t])*dB[t])
  text(50,9,expr1)
  text(50,8.5,expr2)
  axis(1,seq(0,100,5))
  axis(1,seq(0,100,5/10),tcl=-0.2,labels=NA)
  axis(2,seq(0,20,2))
}
\keyword{datasets}
