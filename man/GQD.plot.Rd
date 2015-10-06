\name{GQD.plot}
\alias{GQD.plot}
\title{
Quick Plots for DiffusionRgqd Objects 
}
\description{
\code{GQD.plot()} recognizes output objects calculated using routines from the \bold{DiffusionRgqd} package and subsequently constructs an appropriate plot, for example a perspective plot of a transition density.
}
\usage{
GQD.plot(x, thin = 1, burns, h = FALSE)
}
\arguments{
  \item{x}{
Generic GQD-objects, i.e. \code{res = GQD.density()}.
}
  \item{thin}{
Thinning interval for \code{.mcmc} objects.
}
  \item{burns}{
Number of parameter draws to discard for \code{.mcmc} objects.
}
  \item{h}{
  if \code{TRUE} a histogram is drawn i.s.o. a trace plot.
}
}
\details{
}
\value{Varies in accordance with input type.
}
\references{
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\note{
}


\seealso{
\code{\link{GQD.mcmc}}, \code{\link{GQD.mle}}, \code{\link{GQD.density}}, \code{\link{BiGQD.density}} etc.  
}
\examples{
}
