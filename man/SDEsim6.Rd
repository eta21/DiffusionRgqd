\name{SDEsim6}
\alias{SDEsim6}
\docType{data}
\title{
Simulated First Passage Times for a Time-Inhomogeneous Non-Linear Diffusion
}
\description{
A dataset of 500000 simulated first passage times of a diffusion:
\if{html}{
 \figure{SDEsim5.png}
} 
\if{latex}{
\deqn{dX_t = \theta_1 X_t(10+0.2\sin(2\pi t)+0.3\sqrt{t}(1+\cos(3\pi t))-X_t)dt+\sqrt{0.1}X_tdB_t}
} 
starting in X_1 = 8 traversing a fixed barrier at B = 8.

}
\usage{data("SDEsim6")}
\format{
\describe{
    \item{\code{fpt.sim.times}}{500 000 simulated first passage times.}
  }
}
\examples{
data("SDEsim6")
hist(fpt.sim.times, freq = FALSE, col = 'gray85', border = 'white',
  main = 'First Passage Time Density', ylab = 'Density', xlab = 'Time',
  breaks = 100)

}
\keyword{datasets}
