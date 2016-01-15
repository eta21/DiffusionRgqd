\name{GQD.remove}
\alias{GQD.remove}

\title{
Remove the Coefficients of a GQD Model.
}
\description{Removes any existing coefficient functions from the current workspace. 
}
\usage{
GQD.remove()
}

\details{
\code{GQD.remove} clears the workspace of functions with names that match the coefficients of the 1D GQD. This may be used when more than one model is specified  in a given session.
}
\value{
No value is returned.
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.
}
\author{
Etienne A.D. Pienaar: \email{etiennead@gmail.com}
}
\note{
\code{GQD.remove} simply searches the workspace for functions with definitions that match the form of the DiffusionRgqd interface and removes them from the workspace, freeing up the user to redefine a diffusion with new coefficients. 
}



\seealso{
\code{\link{GQD.density}} and \code{\link{BiGQD.density}}.
}
\keyword{remove models}


