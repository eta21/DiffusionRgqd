\name{solver}
\alias{solver}

\title{
C++ Function to be Built Using \code{GQD.mle()} or \code{GQD.mcmc()}.
}
\description{
This is a peripheral function that is created in C++ using \code{GQD.mle()} or \code{GQD.mcmc()}. This is a non-critical function that is re-defined internally when the need arises. Included here for documentation purposes.
}
\usage{
solver(Xs, Xt, theta, N, delt, N2, tt, P, alpha, lower, upper, tro)
}

\arguments{
  \item{Xs}{
Vector of initial values for time series.
}
  \item{Xt}{
Vector of forward variables of time series.
}
  \item{theta}{
Parameter vector.
}
  \item{N}{
Number of steps.
}
  \item{delt}{
Step size.
}
  \item{N2}{
Number of transitions.

}
  \item{tt}{
Vector of starting times.
}
  \item{P}{
Normalisation nodes.
}
  \item{alpha}{
Spread parameter.
}
  \item{lower}{
Lower integration bound.
}
  \item{upper}{
Upper integration bound.
}
  \item{tro}{
Truncation order.
}
}

\value{
Varies by application.
}

\author{
Etienne A.D. Pienaar: \email{etiennead@gmail.com}
}