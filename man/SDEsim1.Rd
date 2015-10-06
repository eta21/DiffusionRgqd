\name{SDEsim1}
\alias{SDEsim1}
\docType{data}
\title{
A Simulated Diffusion with Sinusoidal Drift and State-Dependant Diffusion Coefficient.
}
\description{
The dataset contains discretely sampled observations for a simulated stochastic differential equation (SDE) with dynamics:

{\deqn{dX_t = 2(5+3*sin(pi(t-0.5))-X_t)dt+0.5*sqrt(X_t)dW_t}} where \code{dW_t} is standard Brownian motion, \code{t} is time and \code{X_0 = 7}.
}
\usage{data(SDEsim1)}
\format{
  A data frame with 201 observations with the following variables:
  \enumerate{
    \item{\code{Xt}   : A numeric vector of simulated observations.}
    \item{\code{time}  : A numeric vector of time nodes at which \code{Xt} was observed.}
  }
}
\details{
The process was simulated by numerically solving the SDE using a Euler-Maruyama scheme with stepsize = 1/2000. Subsequently each 200-th observation was recorded in order to construct the resulting time series.
}
\source{
%%  ~~ reference to a publication or URL from which the data were obtained ~~
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.
}

\examples{
data(SDEsim1)
plot(rev(SDEsim1),type='l',col='blue',main='SDEsim1')
}
\keyword{datasets}
