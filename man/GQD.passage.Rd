\name{GQD.passage}
\alias{GQD.passage}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Calculate the First Passage Time Density of a Time-Homogeneous GQD Process to a Fixed Barrier.
}
\description{
\code{GQD.passage} uses the cumulant truncation procedure of Varughese (2013) in conjunction with a Volterra-type integral equation developed by Buonocore et al. (1987) in order to approximate the first passage time density of a time-homogeneous univariate GQD \strong{\deqn{dX_t = (theta[1]+theta[2]X_t+theta[3]X_t^2)dt+\sqrt{theta[4]+theta[5]X_t+theta[6]X_t^2}dW_t,}}  to a fixed barrier. 
}
\usage{
GQD.passage(Xs, B, theta, t, delt)
}

\arguments{

  \item{Xs}{
Initial value of the process.
}
  \item{B}{Fixed barrier (>Xs).
}
  \item{theta}{Parameter vector giving the coefficients of the time-homogeneous GQD.
}
  \item{t}{The time horizon up to and including which the density is to be evaluated. 
}
  \item{delt}{Stepsize for  the solution of the first passage time density.
}
}

\value{

  \item{density }{The approximate first passage time density.}
  \item{time}{The time points at which the approximation is evaluated.}
  \item{prob.coverage}{The approximate cumulative probability coverage.}


}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.

A. Buonocore, A. Nobile, and L. Ricciardi. 1987 A new integral equation for the evaluation of first-passage-
time probability densities. \emph{Adv. Appl. Probab.} \bold{19}:784--800.

Daniels, H.E. 1954 Saddlepoint approximations in statistics. \emph{Ann. Math. Stat.}, \bold{25}:631--650.

Eddelbuettel, D. and Romain, F. 2011 Rcpp: Seamless R and C++ integration. \emph{Journal of Statistical Software}, \bold{40}(8):1--18,. URL \url{http://www.jstatsoft.org/v40/i08/}.

Eddelbuettel, D. 2013 \emph{Seamless R and C++ Integration with Rcpp}. New York: Springer. ISBN
978-1-4614-6867-7.

Eddelbuettel, D. and Sanderson, C. 2014 Rcpparmadillo: Accelerating r with high-performance C++
linear algebra. \emph{Computational Statistics and Data Analysis}, \bold{71}:1054--1063. URL
\url{http://dx.doi.org/10.1016/j.csda.2013.02.005}.

Feagin, T. 2007 A tenth-order Runge-Kutta method with error estimate. \emph{In Proceedings of the IAENG
Conf. on Scientific Computing}.

R. G. Jaimez, P. R. Roman and F. T. Ruiz. 1995 A note on the volterra integral equation for the
first-passage-time probability density. \emph{Journal of applied probability}, 635--648.

Varughese, M.M. 2013 Parameter estimation for multivariate diffusion systems. \emph{Comput. Stat. Data An.},
\bold{57}:417--428.
}
\author{Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\note{
\bold{Note [1]}: Since time-homogeneity is assumed for the present implementation, the interface of \code{\link{GQD.mcmc}} etc. is discarded and the model is inferred from the non-zero values of \code{theta}. For example \code{theta = c(0.5*10,-0.5,0,0.5^2,0,0)} defines an Ornstein-Uhlenbeck model.
}
\section{Warning}{
\bold{Warning [1]}: Some instability may occur when \code{delt} is large or where the saddlepoint approximation fails. As allways it is important to check both the validity of the diffusion process under the given parameters and the quality of the sadlepoint approximation. For a given set of parameters the latter can be checked using \code{\link[DiffusionRgqd]{GQD.density}}. 

\bold{Warning [2]}: The first passage time problem is considered from one side only i.e. Xs<B. For Xs>B one may equivalently consider Yt=-X_t, apply Ito's lemma and proceed as above.} 

\seealso{
\code{\link[DiffusionRgqd]{GQD.density}} for functions that generate the transitional density of GQDs. \code{\link{GQD.mcmc}} and  \code{\link{GQD.remove}} for MCMC procedures to perform inference on GQDs. 
}

\examples{
\donttest{
#===============================================================================
# Calculate the first passage time from state X_0 = 7 to X_T =10 for
# various diffusions, with T the first passage time.
#===============================================================================
  
  res1 <- GQD.passage(7,10,c(0.1*10,-0.1,0,0.2,0,0),25,1/100)
  res2 <- GQD.passage(7,10,c(0.1*10,-0.1,0,0,0.2,0),25,1/100)
  res3 <- GQD.passage(7,10,c(0,0.1*10,-0.1,0.5^2,0,0),25,1/100)
  res4 <- GQD.passage(7,10,c(0,0.1*10,-0.1,0,0,0.1^2),25,1/100) 

  expr1 <- expression(dX[t]==(1-0.1*X[t])*dt+sqrt(0.2)*dW[t])
  expr2 <- expression(dX[t]==(1-0.1*X[t])*dt+sqrt(0.2*X[t])*dW[t])
  expr3 <- expression(dX[t]==(1*X[t]-0.1*X[t]^2)*dt+0.5*dW[t])
  expr4 <- expression(dX[t]==(1*X[t]-0.1*X[t]^2)*dt+0.1*X[t]*dW[t])


#===============================================================================
# Plot the resulting first passage time densities.
#===============================================================================

  par(mfrow=c(2,2))
  plot(res1$density~res1$time,type='l',main=expr1,xlab='Time (t)',ylab='density',col='blue')
  plot(res2$density~res2$time,type='l',main=expr2,xlab='Time (t)',ylab='density',col='blue')
  plot(res3$density~res3$time,type='l',main=expr3,xlab='Time (t)',ylab='density',col='blue')
  plot(res4$density~res4$time,type='l',main=expr4,xlab='Time (t)',ylab='density',col='blue')

}
}
\keyword{Syntax}
\keyword{C++}
\keyword{First passage time}

