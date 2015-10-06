\name{BiGQD.mle}
\alias{BiGQD.mle}

\title{
Calculate Maximum Likelihood Estimates for a 2D GQD Model.
}
\description{
\code{BiGQD.mle()} uses parametrised coefficients (provided by the user as R-functions) to construct a C++ program in real time that allows the user to perform maximum likelihood inference on the resulting diffusion model. The user may specify any model within the GQD framework by defining parametrised functions giving the form of the coefficients of the model. See the package manual for a description of the process.
}
\usage{
BiGQD.mle(X, time, mesh = 10, theta, control = NULL, method = "Nelder-Mead", max.iter = 2000, 
          exclude = NULL, RK.order = 4, Tag = NA, Dtype ="Saddlepoint")
}

\arguments{
 \item{X}{A matrix containing rows of data points to be modelled. Though observations are allowed to be non-equidistant, observations in both dimensions are assumed to occur at the same time epochs.
}
  \item{time}{A vector containing the time epochs at which observations were made.
}
  \item{mesh}{The number of mesh points in the time discretisation. 
}
  \item{theta}{The parameter vector starting values.
}
  \item{max.iter}{The maximum number of iterations of the optimizer. 
}
\item{exclude}{ Vector indicating which transitions to exclude from the analysis. Default = \code{NULL}.}
\item{RK.order}{The order of the Runge-Kutta solver used to approximate the trajectories of cumulants. Must be 4 (default) or 10.}
\item{Tag}{\code{Tag} can be used to name (tag) an MCMC run e.g. \code{Tag='Run_1'}}
\item{Dtype}{The density approximant to use. Valid types are \code{"Saddlepoint"} (default), \code{"Edgeworth"} or \code{"Normal"}.}
}
\details{

}
\value{
  \item{opt }{The output from optim. }

  \item{model.info }{A list of variables pertaining to inference calculations.}
  \item{model.info$elapsed.time}{The runtime, in h/m/s format,of the MCMC procedure (excluding compile time).}
  \item{model.info$time.homogeneous}{`No' if the model has time-homogeneous coefficients and `Yes' otherwise.}
  \item{model.info$p}{The dimension of \code{theta}.}
}
\references{
Visit \url{https://sites.google.com/site/diffusionronline/} for more details on the DiffusionRgqd package.

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
\code{\link{GQD.remove}}, \code{\link{BiGQD.mcmc}}, \code{\link{GQD.mcmc}}, \code{\link{GQD.mle}}, \code{\link{GQD.passage}} and \code{\link{GQD.TIpassage}}.   
}

\examples{
#===============================================================================
# Simulate a time inhomogeneous diffusion.
#-------------------------------------------------------------------------------
 
 rm(list=ls(all=TRUE))

  Bisim3=function()
  {
     delt=1/1000
     sdelt=sqrt(delt)
     tt=seq(0,50,delt)
     N=length(tt)
     X1=rep(5,N)
     X2=rep(5,N)
     d=0
     for(i in 2:N)
     {
       X1[i]=X1[i-1]+1.5*(5+2*sin(2*pi*d)-X1[i-1])*delt+0.7*sqrt(X1[i-1])*rnorm(1,sd=sdelt)
       X2[i]=X2[i-1]+1.5*(5-X2[i-1])*delt+1*sqrt(X2[i-1])*rnorm(1,sd=sdelt)
       d=d+delt
     }
     sttt= seq(1,N,by=100)
     return(list(X=rbind(X1[sttt],X2[sttt]),tt=tt[sttt]))
  }
  x=Bisim3()

  plot(x$X[1,]~x$tt,type='l',col='blue',ylim=c(0,10))#range(x$X))
  lines(x$X[2,]~x$tt,col='green')


  X=t(x$X)
  time=x$tt


 #------------------------------------------------------------------------------
 # Define the coefficients of a proposed model
 #------------------------------------------------------------------------------


  a00=function(t){theta[1]+theta[2]*sin(2*pi*t)}
  a10=function(t){-theta[3]}
  c10=function(t){theta[4]*theta[4]}

  b00=function(t){theta[5]}
  b01=function(t){-theta[6]}
  f01=function(t){theta[7]*theta[7]}
 
 #------------------------------------------------------------------------------
 # Calculate MLEs
 #------------------------------------------------------------------------------

  m1=BiGQD.mle(X,time,mesh=20,theta =c(3,2,1,3,3,10,3),max.iter=3000)

  GQD.estimates(m1)
#===============================================================================

}

