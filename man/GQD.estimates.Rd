\name{GQD.estimates}
\alias{GQD.estimates}
\title{
Extract Parmaeter Estimates from \code{.mle()} or \code{.mcmc()} Objects.
}
\description{
\code{GQD.estimates calculates parameter estimates from \code{.mle()} or \code{.mcmc()} model objects.}
}
\usage{
GQD.estimates(x, thin = 100, burns)
}

\arguments{
  \item{x}{List object of type 'GQD.mcmc' or 'GQD.mle'. That is, when \code{model =GQD.mcmc()} then \code{model} constitutes an appropriate object for \code{x}.  
}
  \item{thin}{
Thinnging level for parameter chain.
}
  \item{burns}{
Number of MCMC updates to discard before calculating estimates.
}
}
\details{
}
\value{
Data frame with parameter estimates and appropriate interval statistics.
}
\references{
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\note{
}


\seealso{
\code{\link{GQD.mcmc}}, \code{\link{GQD.mle}}, \code{\link{BiGQD.mcmc}} and \code{\link{BiGQD.mle}}.
}
\examples{

}
