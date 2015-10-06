\name{DiffusionRgqd-package}
\alias{DiffusionRgqd-package}
\alias{DiffusionRgqd}
\docType{package}
\title{
A package for Performing Analysis and Inference on Generalized Quadratic Diffusion Processes (GQDs).
}
\description{
\bold{DiffusionRgqd} is a toolbox for performing analysis and inference on a class of diffusion processes with quadratic drift and diffusion. The package consists of functions for performing likelihood based inference and transitional density approximations for both 1D and 2D GQDs. For scalar diffusions, a module is provided for solving first passage time problems for both time homogeneous and time inhomogeneous GQDs.  
}
\details{
\tabular{ll}{
Package: \tab DiffusionRgqd\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2014-05-19\cr
License: \tab What license is it under?\cr
}
The package is designed around an interface whereby the user supplies standard R-functions dictating the functional form of the coefficients of the GQD.  
For example, for scalar GQDs nested within the stochastic differential equation:
\bold{\deqn{dX_t = (G0(t)+G1(t)X_t+G2(t)X_t^2)dt+\sqrt(Q0(t)+Q1(t)X_t+Q2(t)X_t^2)dW_t}} 
the user supplies \strong{\code{G0(t)}},\strong{\code{G1(t)}} and \strong{\code{Q1(t)}}  etc. These coefficients may depend on a both vector of parameters and time. 
The package handles all the necessary mathematics and algorithmic construction. Furthermore, computational efficiency is optimized by constructing algorithms in C++ using the \bold{Rcpp} and \bold{RcppArmadillo} libraries. 

Functions included in the package:
\tabular{lcl}{
\code{\link{BiQGD.density}} \tab:\tab Generate the transitional density of a 2D GQD.\cr    
\code{\link{BiQGD.mcmc}}*   \tab:\tab Conduct inference via MCMC on a 2D GQD.\cr 
\code{\link{BiQGD.mle}}*    \tab:\tab Calculate MLEs for a 2D GQD.\cr 
\code{\link{QGD.density}}   \tab:\tab Generate the transitional density of a 1D GQD.\cr    
\code{\link{QGD.mcmc}}*     \tab:\tab Conduct inference via MCMC on a 1D GQD.\cr 
\code{\link{QGD.mle}}*      \tab:\tab Calculate MLEs for a 1D GQD.\cr 
\code{\link{QGD.passage}}*  \tab:\tab Approximate the first passage time density of a time homogeneous GQD to a barrier.\cr 
\code{\link[DiffusionRgqd]{QGD.TIpassage}}*\tab:\tab Approximate the first passage time density of a time-inhomogeneous GQD to a barrier.\cr
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
\seealso{
\code{\link[DiffusionRgqd]{BiQGD.mcmc}}, \code{\link{BiQGD.mcmc.select}}, \code{\link[DiffusionRgqd]{BiQGD.mle}},  \code{\link{BiQGD.remove}}, \code{\link[DiffusionRgqd]{QGD.mcmc}}, \code{\link{QGD.mcmc.select}}, \code{\link[DiffusionRgqd]{QGD.mle}},\code{\link{QGD.remove}}, \code{\link{QGD.passage}}, \code{\link{QGD.TIpassage}} and \code{\link{QGD.density}}. 
}

\examples{
example(GQD.density)
example(BiGQD.density)

example(GQD.mcmc)
example(BiGQD.mcmc)

example(GQD.passage)
example(GQD.TIpassage)
}
