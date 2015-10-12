\name{DiffusionRgqd-package}
\alias{DiffusionRgqd-package}
\alias{DiffusionRgqd}
\docType{package}
\title{
A package for Performing Inference and Analysis on Generalized Quadratic Diffusion Processes (GQDs).
}
\description{
\bold{DiffusionRgqd} is a toolbox for performing analysis and inference on a class of diffusion processes with quadratic drift and diffusion. The package consists of functions for performing likelihood based inference and transitional density approximations for both 1D and 2D GQDs. For scalar diffusions, a module is provided for solving first passage time problems for both time homogeneous and time inhomogeneous GQDs.  
}
\details{
\tabular{ll}{
Package: \tab DiffusionRgqd\cr
Type: \tab Package\cr
Version: \tab 0.1.2\cr
Date: \tab 2015-11-01\cr
License: \tab GPL (>= 2)\cr
}
The package is designed around an interface whereby the user supplies standard R-functions dictating the functional form of the coefficients of the GQD.  
For example, for scalar GQDs nested within the stochastic differential equation: \strong{\deqn{dX_t = (G_0(t)+G_1(t)X_t+G_2(t)X_t^2)dt+\sqrt{Q_0(t)+Q_1(t)X_t+Q_2(t)X_t^2}dW_t,}} the user supplies \strong{\code{G0(t)}},\strong{\code{G1(t)}} and \strong{\code{Q1(t)}}  etc. These coefficients may depend on a both vector of parameters and time. 
The package handles all the necessary mathematics and algorithmic construction. Furthermore, computational efficiency is optimized by constructing algorithms in C++ using the \bold{Rcpp} and \bold{RcppArmadillo} libraries. 

Functions included in the package:
\tabular{lcl}{
\code{\link{BiGQD.density}} \tab:\tab Generate the transitional density of a 2D GQD.\cr    
\code{\link{BiGQD.mcmc}}*   \tab:\tab Conduct inference via MCMC on a 2D GQD.\cr 
\code{\link{BiGQD.mle}}*    \tab:\tab Calculate MLEs for a 2D GQD.\cr 
\code{\link{GQD.density}}   \tab:\tab Generate the transitional density of a 1D GQD.\cr    
\code{\link{GQD.mcmc}}*     \tab:\tab Conduct inference via MCMC on a 1D GQD.\cr 
\code{\link{GQD.mle}}*      \tab:\tab Calculate MLEs for a 1D GQD.\cr 
\code{\link{GQD.passage}}*  \tab:\tab Approximate the first passage time density of a time homogeneous GQD to a barrier.\cr 
\code{\link{GQD.TIpassage}}*\tab:\tab Approximate the first passage time density of a time-inhomogeneous GQD to a barrier.\cr
}
* Functions use C++. 
}

\author{
Etienne A.D. Pienaar: \email{etiennead@gmail.com}

Maintainer: Etienne A.D. Pienaar (\email{etiennead@gmail.com})
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.
}
\keyword{ package }
\keyword{ C++}
\seealso{
\code{\link{BiGQD.mcmc}}, \code{\link{BiGQD.mle}}, \code{\link{GQD.mcmc}}, \code{\link{GQD.dic}}, \code{\link{GQD.mle}},\code{\link{GQD.remove}}, \code{\link{GQD.passage}}, \code{\link{GQD.TIpassage}} and \code{\link{GQD.density}}. 
}

\examples{
\dontrun{
example(GQD.density)
example(BiGQD.density)
}
}
