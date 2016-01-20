\name{BiGQD.mle}
\alias{BiGQD.mle}

\title{
Calculate Maximum Likelihood Estimates for a 2D GQD Model.
}
\description{
\code{BiGQD.mle()} uses parametrised coefficients (provided by the user as R-functions) to construct a C++ program in real time that allows the user to perform maximum likelihood inference on the resulting diffusion model.
\if{html}{
\code{BiGQD.density} generates approximate transitional densities for a class of bivariate diffusion processes with SDE:

\figure{BivEqn1.png}

where

\figure{BivEqn2.png}

and

\figure{BivEqn3.png}



}
\if{latex}{
\code{BiGQD.density()} approximates the transitional density of jump diffusions of the form:
\deqn{d\mathbf{X}_t = \boldsymbol\mu(\mathbf{X}_t,t)dt +\boldsymbol\sigma(\mathbf{X}_t,t)d\mathbf{W}_t\\}
where
\deqn{\mu^{(1)}(\mathbf{X}_t,t)= \sum_{i+j\leq 2}a_{ij}(t)X_t^iY_t^j,\\}
\deqn{\mu^{(2)}(\mathbf{X}_t,t)= \sum_{i+j\leq 2}b_{ij}(t)X_t^iY_t^j,\\}
and
\deqn{\boldsymbol\sigma(X_t,Y_t,t)\boldsymbol\sigma^{\prime}(X_t,Y_t,t) = (\gamma^{(i,j)}(\mathbf{X}_t,t))_{i,j=1,2}\\}
such that
\deqn{\gamma^{(1,1)}(\mathbf{X}_t,t)= \sum_{i+j\leq 2}c_{ij}(t)X_t^iY_t^j,\\}
\deqn{\gamma^{(1,2)}(\mathbf{X}_t,t)= \sum_{i+j\leq 2}d_{ij}(t)X_t^iY_t^j,\\}
\deqn{\gamma^{(2,1)}(\mathbf{X}_t,t)= \sum_{i+j\leq 2}e_{ij}(t)X_t^iY_t^j,\\}
\deqn{\gamma^{(2,2)}(\mathbf{X}_t,t)= \sum_{i+j\leq 2}f_{ij}(t)X_t^iY_t^j.\\}

 }
}
\usage{
BiGQD.mle(X, time, mesh=10, theta, control=NULL, method='Nelder-Mead', RK.order=4,
          exclude=NULL, Tag=NA, Dtype='Saddlepoint', rtf= runif(2,-1,1), wrt=FALSE,
          print.output=TRUE)
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
  \item{control}{ List of control variables to be used by \code{\link{optim}}.}
  \item{method}{ Method to be used by \code{\link{optim}}.}
  
\item{exclude}{ Vector indicating which transitions to exclude from the analysis. Default = \code{NULL}.}
\item{RK.order}{The order of the Runge-Kutta solver used to approximate the trajectories of cumulants. Must be 4 (default) or 10.}
\item{Tag}{\code{Tag} can be used to name (tag) an MCMC run e.g. \code{Tag='Run_1'}}
\item{Dtype}{The density approximant to use. Valid types are \code{"Saddlepoint"} (default), \code{"Edgeworth"} or \code{"Normal"}.}
\item{rtf}{Starting vector for internal use.}
\item{wrt}{If \code{TRUE} a .cpp file will be written to the current directory. For bug report diagnostics.}
\item{print.output}{If \code{TRUE} information about the model and algorithm is printed to the console. }
}

\value{
  \item{opt }{The output from optim. }

  \item{model.info }{A list of variables pertaining to inference calculations.}
  \item{model.info$elapsed.time}{The runtime, in h/m/s format,of the MCMC procedure (excluding compile time).}
  \item{model.info$time.homogeneous}{`No' if the model has time-homogeneous coefficients and `Yes' otherwise.}
  \item{model.info$p}{The dimension of \code{theta}.}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}.

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
\donttest{
#===============================================================================
# This example simulates a bivariate time homogeneous diffusion and shows how
# to conduct inference using BiGQD.mle(). We fit two competing models and then
# use the output to select a winner.
#-------------------------------------------------------------------------------

  data(SDEsim2)
  data(SDEsim2)
  attach(SDEsim2)
  # Have a look at the time series:
  plot(Xt~time,type='l',col='blue',ylim=c(2,10),main='Simulated Data',xlab='Time (t)',ylab='State',
       axes=FALSE)
  lines(Yt~time,col='red')
  expr1=expression(dX[t]==2(Y[t]-X[t])*dt+0.3*sqrt(X[t]*Y[t])*dW[t])
  expr2=expression(dY[t]==(5-Y[t])*dt+0.5*sqrt(Y[t])*dB[t])
  text(50,9,expr1)
  text(50,8.5,expr2)
  axis(1,seq(0,100,5))
  axis(1,seq(0,100,5/10),tcl=-0.2,labels=NA)
  axis(2,seq(0,20,2))
  axis(2,seq(0,20,2/10),tcl=-0.2,labels=NA)

 #------------------------------------------------------------------------------
 # Define the coefficients of a proposed model
 #------------------------------------------------------------------------------
  GQD.remove()
  a00 <- function(t){theta[1]*theta[2]}
  a10 <- function(t){-theta[1]}
  c00 <- function(t){theta[3]*theta[3]}

  b00 <- function(t){theta[4]}
  b01 <- function(t){-theta[5]}
  f00 <- function(t){theta[6]*theta[6]}

  theta.start <- c(3,3,3,3,3,3)
  X           <- cbind(Xt,Yt)

  # Calculate MLEs
  m1=BiGQD.mle(X,time,10,theta.start)

 #------------------------------------------------------------------------------
 # Remove old coefficients and define the coefficients of a new model
 #------------------------------------------------------------------------------
  GQD.remove()
  a10 <- function(t){-theta[1]}
  a01 <- function(t){theta[1]*theta[2]}
  c11 <- function(t){theta[3]*theta[3]}

  b00 <- function(t){theta[4]*theta[5]}
  b01 <- function(t){-theta[4]}
  f01 <- function(t){theta[6]*theta[6]}

  theta.start <- c(3,3,3,3,3,3)

  # Calculate MLEs
  m2=BiGQD.mle(X,time,10,theta.start)

 # Compare estimates:
  GQD.estimates(m1)
  GQD.estimates(m2)

 #------------------------------------------------------------------------------
 # Compare the two models
 #------------------------------------------------------------------------------

  GQD.aic(list(m1,m2))


#===============================================================================
}
}
\keyword{syntax}
\keyword{C++}
\keyword{maximum likelihood}
