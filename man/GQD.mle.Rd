\name{GQD.mle}
\alias{GQD.mle}

\title{MLEs for Generalized Quadratic Diffusion Models (GQDs).
}
\description{
\code{GQD.mle()} constructs a C++ program in real time that allows the user to perform maximum likelihood inference on scalar GQDs. Given a set of starting parameters, the maximum likelihood estimates are calculated via minimization of minus the likelihood function via the built-in R-function \code{optim}.
The structure of the model is predefined and coefficients may be provided for models nested within the generalized quadratic diffusion framework. That is, the saturated GQD model is given by: \strong{\deqn{dX_t = (G_0(t)+G_1(t)X_t+G_2(t)X_t^2)dt+\sqrt{Q_0(t)+Q_1(t)X_t+Q_2(t)X_t^2}dW_t}} where dW_t is Standard Brownian Motion.
}
\usage{
GQD.mle(X, time, mesh=10, theta, control=NULL, method='Nelder-Mead', Dtype='Saddle', 
        Trunc=c(4,4), RK.order=4, P=200, alpha=0, lower=min(X)/2, upper=max(X)*2,
        exclude=NULL, Tag=NA, wrt=FALSE)
}

\arguments{
  \item{X}{
Time series (vector) of discretely observed points of the process of interest. These may be non-equidistant observations (see \code{time}).
}
  \item{time}{
A vector of time-stamps associated with each observation in \code{X}.
}
  \item{mesh}{
The number mesh points between any two given data points.
}
  \item{theta}{The set of starting parameters for the optimization routine.
}
  
  \item{control}{ List of control variables to be used by \code{\link{optim}}.}
  \item{method}{ Method to be used by \code{\link{optim}}.}
  \item{exclude}{ Vector indicating which transitions to exclude from the analysis. Default = \code{NULL}.}
  
  \item{RK.order}{The order of the Runge-Kutta scheme used. Value must be 4 or (default) 10.}
  
  \item{Dtype}{Character string indicating the type of density approximation (see details) to use. Types: \code{'Saddlepoint'}, \code{'Normal'}, \code{'Gamma'}, \code{'InvGamma'} and \code{'Beta'} are supported (default = \code{'Saddlepoint'}).}
  \item{Trunc}{Vector of length 2 containing the cumulant truncation order and the density truncation order respectively. May take on values 4, 6 and 8 with the constraint that \code{Trunc[1] >= Trunc[2]}. Default is \code{c(4,4)}.} 
\item{P}{Normalization parameter indicating the number of points to use when normalizing members of the Pearson system (see details)}
\item{alpha}{Normalization parameter controlig the mesh concentration when normalizing members of the Pearson system (see details). Increasing \code{alpha} decreases concentration around the mean and vice versa (default \code{alpha = 0}).}
\item{lower,upper}{Lower and upper bounds for the normalization range.}
\item{Tag}{\code{Tag} can be used to name (tag) an MCMC run e.g. \code{Tag='Run_1'}}
\item{wrt}{If \code{TRUE} a .cpp file will be written to the current directory. For bug report diagnostics.}
}

\value{
  \item{opt }{The output from \code{optim}.}
  \item{model.info }{A list of variables pertaining to inference calculations.}
  \item{model.info$elapsed.time}{The run-time, in h/m/s format,of the MCMC procedure (excluding compile time).}
  \item{model.info$time.homogeneous}{`No' if the model has time-homogeneous coefficients and `Yes' otherwise.}
  \item{model.info$p}{The dimension of \code{theta}.}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.

Daniels, H.E. 1954 Saddlepoint approximations in statistics. \emph{Ann. Math. Stat.}, \bold{25}:631--650.

Eddelbuettel, D. and Romain, F. 2011 Rcpp: Seamless R and C++ integration. \emph{Journal of Statistical Software}, \bold{40}(8):1--18,. URL \url{http://www.jstatsoft.org/v40/i08/}.

Eddelbuettel, D. 2013 \emph{Seamless R and C++ Integration with Rcpp}. New York: Springer. ISBN
978-1-4614-6867-7.

Eddelbuettel, D. and Sanderson, C. 2014 Rcpparmadillo: Accelerating R with high-performance C++
linear algebra. \emph{Computational Statistics and Data Analysis}, \bold{71}:1054--1063. URL
\url{http://dx.doi.org/10.1016/j.csda.2013.02.005}.

Feagin, T. 2007 A tenth-order Runge-Kutta method with error estimate. \emph{In Proceedings of the IAENG
Conf. on Scientifc Computing}.

Varughese, M.M. 2013 Parameter estimation for multivariate diffusion systems. \emph{Comput. Stat. Data An.},
\bold{57}:417--428.

}
\author{
Etienne A.D. Pienaar: \email{etiennead@gmail.com}
}
\section{Syntactical jargon}{

\bold{Synt. [1]:} The coefficients of the 2D GQD may be parameterized using the reserved variable \code{theta}. For example:

\code{a00 <- function(t){theta[1]*(theta[2]+sin(2*pi*(t-theta[3])))}}.

\bold{Synt. [2]:} Due to syntactical differences between R and C++ special functions have to be used when terms that depend on \code{t}. When the function cannot be separated in to terms that contain a single \code{t}, the \code{prod(a,b)} function must be used. For example:

\code{a00 <- function(t){0.1*(10+0.2*sin(2*pi*t)+0.3*prod(sqrt(t),1+cos(3*pi*t)))}}.

Here sqrt(t)*cos(3*pi*t) constitutes the product of two terms that cannot be written i.t.o. a single \code{t}. To circumvent this isue, one may use the \code{prod(a,b)} function. 

\bold{Synt. [3]:} Similarly, the ^ - operator is not overloaded in C++. Instead the \code{pow(x,p)} function may be used to calculate x^p. For example sin(2*pi*t)^3 in:

\code{a00 <- function(t){0.1*(10+0.2*pow(sin(2*pi*t),3))}}.

}

\section{Warning }{

\bold{Warning [1]}: The parameter \code{mesh} is used to discretize the transition horizons between successive observations. It is thus important to ensure that \code{mesh} is not too small when large time differences are present in \code{time}. Check output for max(dt) and divide by \code{mesh}.

\bold{Warning [2]:} Note that minus the likelihood is minimized, as such the \code{optim} output (hessian) needs to be adjusted accordingly if used for calculating confidence intervals. Furthermore, \code{GQD.mle} may be temperamental under certain conditions 

} 
\seealso{
\code{\link{GQD.remove}}, \code{\link{GQD.mcmc}}, \code{\link{BiGQD.mcmc}}, \code{\link{BiGQD.mle}}, \code{\link{GQD.passage}} and \code{\link{GQD.TIpassage}}. 
}

\examples{
\donttest{
#===============================================================================
# Simulate a time inhomogeneous diffusion.
#-------------------------------------------------------------------------------

  data(SDEsim1)
  attach(SDEsim1)
  par(mfrow=c(1,1))
  expr1=expression(dX[t]==2*X[t]*(5+3*sin(0.5*pi*t)-X[t])*dt+0.5*X[t]*dW[t])
  plot(Xt~time,type='l',col='blue',xlab='Time (t)',ylab=expression(X[t]),main=expr1)

 #------------------------------------------------------------------------------
 # Define coefficients of the process.
 #------------------------------------------------------------------------------

  GQD.remove()
  G0 <- function(t){theta[1]*(theta[2]+theta[3]*sin(0.25*pi*t))}
  G1 <- function(t){-theta[1]}
  Q0 <- function(t){theta[4]*theta[4]}

  theta.start  <- c(1,1,1,1)                      # Starting values for the chain
  mesh.points  <- 10                              # Number of mesh points

  m1 <- GQD.mle(Xt,time,mesh=mesh.points,theta=theta.start)

  GQD.remove()

  G1 <- function(t){theta[1]*(theta[2]+theta[3]*sin(0.25*pi*t))}
  G2 <- function(t){-theta[1]}
  Q2 <- function(t){theta[4]*theta[4]}

  theta.start  <- c(1,1,1,1)                      # Starting values for the chain
  mesh.points  <- 10                              # Number of mesh points

  m2 <- GQD.mle(Xt,time,mesh=mesh.points,theta=theta.start)

  # Check estimates:
  GQD.estimates(m1)
  GQD.estimates(m2)

  # Compare models:
  GQD.aic(list(m1,m2))

#===============================================================================
}
}
\keyword{Syntax}
\keyword{C++}
\keyword{Maximum likelihood}
