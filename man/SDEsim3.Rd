\name{SDEsim3}
\alias{SDEsim3}
\docType{data}
\title{
Simulated Stochastic Lotka-Volterra Eqns
}
\description{
The dataset contains discretely sampled observations for a simulated stochastic differential equation (SDE) with dynamics:
\if{html}{
{\deqn{dX_t = (1.5X_t-0.4X_tY_t)dt+sqrt(0.05X_t)dW_t}} 
{\deqn{dY_t = (-1.5Y_t+0.4X_tY_t-0.2Y_t^2)dt+sqrt(0.1X_t)dB_t}} 
}
\if{latex}{
{\deqn{dX_t = (1.5X_t-0.4X_tY_t)dt+\sqrt{0.05X_t}dW_t}} 
{\deqn{dY_t = (-1.5Y_t+0.4X_tY_t-0.2Y_t^2)dt+\sqrt{0.1X_t}dB_t}}
}
where \code{dW_t} and \code{dB_t} are standard Brownian motions, \code{t} is time and \code{X_0 = 5}, \code{Y_0 = 5}.
}
\usage{data("SDEsim3")}
\format{
  A data frame with 1001 observations on the following 3 variables.
  \describe{
    \item{\code{time}}{A numeric vector of time nodes at which means are calculated (\code{time[i+1]-time[i] = 1/4}).}
    \item{\code{mx}}{Mean Xt trajectory of the diffusion.}
    \item{\code{my}}{Mean Yt trajectory of the diffusion.}
  }
}

\keyword{datasets}
