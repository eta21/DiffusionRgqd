\name{SDEsim5}
\alias{SDEsim5}
\docType{data}
\title{
Simulated First Passage Times for a Time-Inhomogeneous Non-Linear Diffusion
}
\description{
A histogram with counts/density values for a 500000 simulated first passage times of a diffusion:
\if{html}{
 \figure{SDEsim5.png}
} 
\if{latex}{
\deqn{dX_t = \theta_1 X_t(10+0.2\sin(2\pi t)+0.3\sqrt{t}(1+\cos(3\pi t))-X_t)dt+\sqrt{0.1}X_tdB_t}
} 
starting in X_1 = 8 traversing a fixed barrier at B = 8.

}
\usage{data("SDEsim5")}
\format{
  A data frame with 92 observations on the following 3 variables.
  \describe{
    \item{\code{counts}}{Histogram counts for each bin.}
    \item{\code{density}}{Approximate density values.}
    \item{\code{mids}}{Midpoints for each bin.}
  }
}
\examples{
data(SDEsim5)
plot(SDEsim5$density ~ c(SDEsim5$mids-diff(SDEsim5$mids)[1] / 2), type = 's',
  lty = 'solid', lwd = 1, xlab = 'time', ylab = 'Density')

}
\keyword{datasets}
