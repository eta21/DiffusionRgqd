\name{GQD.TIpassage}
\alias{GQD.TIpassage}

\title{Compute the First Passage Time Density of a GQD With Time Inhomogeneous Coefficients.
}
\description{
\code{GQD.TIpassage()} solves first passage time problems for GQDs with time dependent coefficients: \strong{\deqn{dX_t = (G_0(t)+G_1(t)X_t+G_2(t)X_t^2)dt+\sqrt{Q_0(t)+Q_1(t)X_t+Q_2(t)X_t^2}dW_t}}  to a fixed barrier.
The function combines the cumulant truncation procedure of Varughese (2013) with a numerical solution to a non-singular Volterra integral equation for the first passage time density, developed by Buonocore et al. (1987), in order to generate an approximate solution.

}
\usage{
GQD.TIpassage(Xs,B, s, t, delt, theta=c(0), IEQ.type='Buonocore', wrt=FALSE)
}

\arguments{
  \item{Xs}{Initial value of the diffusion process at time \code{tmin}.}
  \item{B}{Fixed barrier (or first constant in static barier transform - see detail \bold{[1]}).}
  \item{s}{Starting time for the diffusion process (see detail \bold{[2]}).}
  \item{t}{The time horizon up to and including which the density is to be evaluated.}
  \item{delt}{Stepsize for  the solution of the first passage time density.}
  \item{theta}{Parameter vector for parameters contained in the coefficients (if required).}
  \item{IEQ.type}{Currently only \code{IEQ.type = "Buonocore"} is supported.}
  \item{wrt}{If \code{TRUE} a .cpp file will be written to the current directory. For bug report diagnostics.}

}
\details{
\bold{Detail [1]}: First passage throug a time dependant barrier may be analised by applying the transform:
\deqn{Y_t = X_t -B_t,} if \eqn{B_t} may can be decomposed as \deqn{B_t = k+f(t).} By applying Ito's lemma the revised drift and diffusion functionals, and first passage parameters may be inferred.

\bold{Detail [2]}: The starting time is of particular importance when the drift and/or diffusion terms are time-inhomogeneous. Take care to select the correct starting time - especially if the drift or diffusion components whch are time dependant have poles or singular points in the time domain.
}
\value{
  \item{density }{The approximate first passage time density.}
  \item{time    }{The time points at which the approximation is evaluated.}
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

\author{
Etienne A.D. Pienaar: \email{etiennead@gmail.com}
}

\note{
\bold{Note [1]:} The coefficients od the GQD may be parameterized using the reserved variable \code{theta}. For example:

\code{G0 <- function(t){theta[1]*(theta[2]+sin(2*pi*(t-theta[3])))}}

may be used so long as values are asigned in the function call, say

\code{GQD.TIpassage(Xs=3,B=11,tmin=1,tmax=10,delt=1/100,theta=c(1,10,0.5))}.


\bold{Note [2]:} Due to syntactical differences between R and C++ special functions have to be used when terms that depend on \code{t}. When the function cannot be separated in to terms that contain a single \code{t}, the \code{prod(a,b)} function must be used. For example (see examples below):

\code{G0 <- function(t){0.1*(10+0.2*sin(2*pi*t)+0.3*prod(sqrt(t),1+cos(3*pi*t)))}}.

Here sqrt(t)*cos(3*pi*t) constitutes the product of two terms that cannot be written i.t.o. a single \code{t}. To circumvent this isue, one may use the \code{prod(a,b)} function.

\bold{Note [3]:} Similarly, the ^ - operator is not overloaded in C++. Instead the \code{pow(x,p)} function may be used to calculate x^p. For example sin(2*pi*t)^3 in:

\code{G0 <- function(t){0.1*(10+0.2*pow(sin(2*pi*t),3))}}.

\bold{Note [4]:} \code{delt} is used as the stepsize of the Runge-Kutta method used to numerically solve a system of ODEs used to approximate the cumulants of the underlying diffusion procees. The 10th-order scheme of Feagin (2007) is used as the default method. 
}

\section{Warning }{
\bold{Warning [1]:} Some instability may occur when \code{delt} is large or where the saddlepoint approximation fails. As allways it is important to check both the validity of the diffusion process under the given parameters and the quality of the saddlepoint approximation. For a given set of parameters the latter can be checked using \code{\link[DiffusionRgqd]{GQD.density}}. 

\bold{Warning [2]:}The first passage time problem is considered from one side only i.e. Xs<B. For Xs>B one may equivalently consider Yt=-X_t, apply Ito's lemma and proceed as above.} 

\seealso{
\code{\link{GQD.density}} for functions that generate the transitional density of GQDs and \code{\link{GQD.mcmc}} for MCMC procedures for GQD models. 
}

\examples{
\donttest{
#=========================================================================
# Generate the first passage time density of a CIR process with time 
# dependant drift to a fixed barrier.
#-------------------------------------------------------------------------
  
  # Remove any existing coefficients.
  GQD.remove()         

  # Define the coefficients of the process.
  G0 <- function(t){10+0.5*sin(2*pi*t)}
  G1 <- function(t){-1}
  Q1 <- function(t){0.25}
  
  
  #Define the parameters of the first passage time problem.
  delt  <- 1/100         # The stepsize for the solution
  X0 <- 8                # The initial value of the process
  BB <- 11               # Fixed barrier
  T0 <- 2                # Starting time of the diffusion
  TT <- 10                # Time horizon of the computation

  # Run the calculation
  res1 <- GQD.TIpassage(X0,BB,T0,TT,delt)
 
  # Remove any existing coefficients.
  GQD.remove()         

  # Redefine the coefficients.
  G0 <- function(t){ 0.1*(10+0.2*sin(2*pi*t)+0.3*prod(sqrt(t),1+cos(3*pi*t)))}
  G1 <- function(t){-0.1*(1+0.2*sin(2*pi*t))}
  Q1 <- function(t){0.25}
  
  # Redefine the parameters of the f.p.t. problem.

  delt  <- 1/100
  X0 <- 8
  BB <- 11
  T0 <- 1
  TT <- 10

  # Run the calculation
  res2 <- GQD.TIpassage(X0,BB,T0,TT,delt)

#===============================================================================
# Plot the two solutions.
#===============================================================================
  expr1 <- expression(dX[t]==(10+0.5*sin(2*pi*t)-X[t])*dt+0.25*sqrt(X[t])*dW[t])
  expr2 <- expression(dX[t]==(0.1*(10+0.2*sin(2*pi*t)+0.3*sqrt(t)*(1+cos(3*pi*t))
                      -0.1*(1+0.2*sin(2*pi*t))*X[t])*dt+0.25*sqrt(X[t])*dW[t]))

  
  par(mfrow=c(1,1))
  plot(res1$density~res1$time,type='l',col='blue',
       ylab='Density',xlab='Time',main=expr1,cex.main=0.95)
  
  plot(res2$density~res2$time,type='l',col='red',
       ylab='Density',xlab='Time',main =expr2,cex.main=0.95)

#===============================================================================
# Let's see how sensitive the first passage density is w.r.t a speed parameter
# of a non-linear diffusion.
#===============================================================================
  
GQD.remove()
# Redefine the coefficients with a parameter theta:
G1 <- function(t){theta[1]*(10+0.2*sin(2*pi*t)+0.3*prod(sqrt(t),1+cos(3*pi*t)))}
G2 <- function(t){-theta[1]}
Q2 <- function(t){0.1}
# Now just give a value for the parameter in the standard fashion:
res3=GQD.TIpassage(8,12,1,4,1/100,theta=c(0.5))

plot(res3$density~res3$time,type='l',col=2,ylim=c(0,1.0),
main='First Passage Time Density',ylab='Density',xlab='Time',cex.main=0.95)
# Change the parameter and see the effect on the f.p.t. density.
th.seq=seq(0.1,0.5,1/20)
for(i in 2:length(th.seq))
{
  res3=GQD.TIpassage(8,12,1,4,1/100,,theta=c(th.seq[i]))
  lines(res3$density~res3$time,type='l',col=rainbow(10)[i])
}
lines(res3$density~res3$time,type='l',col=rainbow(10)[i],lwd=2)
legend('topright',legend=th.seq,col=rainbow(10),lty='solid',cex=0.75,
title=expression(theta[1]))
#===============================================================================
}
}
\keyword{Syntax}
\keyword{C++}
\keyword{First passage time}
