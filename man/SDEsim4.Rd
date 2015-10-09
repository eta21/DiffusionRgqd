\name{SDEsim4}
\alias{SDEsim4}
\docType{data}
\title{
A Simulated Non-Linear Bivariate Diffusion With Time-Inhomogeneous Coefficients
}
\description{
The dataset contains discretely sampled observations for a simulated stochastic differential equation (SDE) with dynamics:
\if{html}{
{\deqn{dX_t = (1.0(7.5-X_t)+1.5Y_t)dt+0.5sqrt(X_tY_t)dW_t}} 
{\deqn{dY_t = (1.5(5-Y_t)+3sin(0.25 pi t ))dt+0.25sqrt(Y_t)dB_t}} 
}
\if{latex}{
{\deqn{dX_t = (1.0(7.5-X_t)+1.5Y_t)dt+0.5\sqrt{X_tY_t}dW_t}} 
{\deqn{dY_t = (1.5(5-Y_t)+3\sin(0.25 \pi t ))dt+0.25\sqrt{Y_t}dB_t}} 
}
where \code{dW_t} and \code{dB_t} are standard Brownian motions, \code{t} is time and \code{X_0 = 10}, \code{Y_0 = 5}.
}
\usage{data("SDEsim4")}
\format{
  A data frame with 401 observations on the following 3 variables.
  \describe{
    \item{\code{Xt}}{Xt trajectory of the diffusion.}
    \item{\code{Yt}}{Yt trajectory of the diffusion.}
    \item{\code{time}}{Time vector.}
  }
}
\details{
For a full analysis of this dataset check out Example 7.5 in the example scripts at \url{https://github.com/eta21/DiffusionRgqd-Downloads}. 
}

\examples{
data(SDEsim4)
data(SDEsim4)
attach(SDEsim4)
# Have a look at the time series:
plot(Xt~time,type='l',col='blue',ylim=c(0,25),main='Simulated Data',
xlab='Time (t)',ylab='State',axes=FALSE)
lines(Yt~time,col='red')
axis(1,seq(0,100,5))
axis(1,seq(0,100,5/10),tcl=-0.2,labels=NA)
axis(2,seq(0,25,2))
axis(2,seq(0,25,2/10),tcl=-0.2,labels=NA)

}
\keyword{datasets}
