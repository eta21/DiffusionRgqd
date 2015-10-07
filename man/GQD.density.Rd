\name{GQD.density}
\alias{GQD.density}
\title{
Generate the Transition Density of a Scalar Generalized Quadratic Diffusion (GQD).
}
\description{
\code{GQD.density} approximates the transition density of a scalar generalized quadratic diffusion model (GQD). Given an initial value for the diffusion, \code{Xs}, the approximation is evaluated for all \code{Xt} at equispaced time-nodes given by splitting [\code{s}, \code{t}] into subintervals of length \code{delt}.
 }
\usage{
GQD.density(Xs, Xt, s, t, delt=1/100, Dtype='Saddlepoint', Trunc=c(4,4),
            P=100, alpha=0, lower=0, upper=50)
}
\arguments{
  \item{Xs}{Initial value of the process at time s.}
  \item{Xt}{Vector of values at which the transition density is to be evaluated over the trajectory of the transition density from time s to t.}
  \item{s}{The starting time of the process.}
  \item{t}{The time horizon up to and including which the transitional density is evaluated.}
  \item{delt}{Size of the time increments at which successive evaluations are made.} 
  \item{Dtype}{Character string indicating the type of density approximation (see details) to use. Types: \code{'Saddlepoint'}, \code{'Normal'}, \code{'Gamma'}, \code{'InvGamma'} and \code{'Beta'} are supported (default = \code{'Saddlepoint'}).}
  \item{Trunc}{Vector of length 2 containing the cumulant truncation order and the density truncation order respectively. May take on values 4, 6 and 8 with the constraint that \code{Trunc[1] >= Trunc[2]}. Default is \code{c(4,4)}.} 
\item{P}{Normalization parameter indicating the number of points to use when normalizing members of the Pearson system (see details)}
\item{alpha}{Normalization parameter controlig the mesh concentration when normalizing members of the Pearson system (see details). Increasing \code{alpha} decreases concentration around the mean and vice versa (default \code{alpha = 0}).}
\item{lower,upper}{Lower and upper bounds for the normalization range.}
}
\details{
\if{html}{\figure{TransDens1.png}{GQD}}


\code{GQD.density} constructs an approximate transition density for a class of quadratic diffusion models. This is done by first evaluating the trajectory of the cumulants/moments of the diffusion numerically as the solution of a system of ordinary differential equations over a time horizon \code{[s,t]} split into equi-distant points \code{delt} units apart. Subsequently, the resulting cumulants/moments are carried into a density approximant (by default, a saddlepoint approximation) in order to evaluate the transtion surface.
}

\value{
  \item{density}{A matrix giving the density over the spatio-temporal mesh whose vertices are defined by paired permutations of the elements of \code{X_t} and  \code{time}}
 \item{Xt}{ A vector of points defining the state space at which the density was evaluated(recycled from input).}
  \item{time}{A vector of time points at which the density was evaluated.}
  \item{cumulants}{A matrix giving the cumulants of the diffusion. Row i gives the i-th cumulant.}
  \item{moments}{A matrix giving the moments of the diffusion. Row i gives the i-th cumulant.}
  \item{mesh}{A matrix giving the mesh used for normalization of the density.}
}



\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.

Daniels, H.E. 1954 Saddlepoint approximations in statistics. \emph{Ann. Math. Stat.}, \bold{25}:631--650.

Feagin, T. 2007 A tenth-order Runge-Kutta method with error estimate. \emph{In Proceedings of the IAENG
Conf. on Scientifc Computing}.

Varughese, M.M. 2013 Parameter estimation for multivariate diffusion systems. \emph{Comput. Stat. Data An.},
\bold{57}:417--428.
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}


\section{Warning}{
\bold{Warning [1]}:
The system of ODEs that dictate the evolution of the cumulants do so approximately. Thus, although it is unlikely such cases will be encountered in inferential contexts, it is worth checking (by simulation) whether cumulants accurately replicate those of the target GQD. Furthermore, it may in some cases occur that the cumulants are indeed accurate whilst the density approximation fails. This can again be verified by simulation after which alternate density approximants may be specified through the variable \code{Dtype}. 

\bold{Warning [2]}:
The parameter \code{delt} is also used as the stepsize for solving a system of ordinary differential equations (ODEs) that govern the evolution of the cumulants of the diffusion. As such \code{delt} is required to be small for highly non-linear models in order to ensure sufficient accuracy.
} 

\seealso{
See \code{\link{GQD.mcmc}} and \code{\link{GQD.mle}} for likelihood based inference procedures for GQDs. 
}

\examples{

#===============================================================================
# Generate the transition density of a CIR process with time dependant
# drift and volatility.
#-------------------------------------------------------------------------------
  
  # Remove any existing coefficients
  GQD.remove()         
  
  # Define drift Coefficients. Note that the limiting mean is sinusoidal.
  G0 <- function(t){2*(10+sin(2*pi*(t-0.5)))}    
  G1 <- function(t){-2}
  
  # Define sinusoidal diffusion coefficient with `faster' oscillation.
  Q1 <- function(t){0.25*(1+0.75*(sin(4*pi*t)))}
  
  states     <-  seq(5,15,1/10) # State values
  initial    <-  8              # Starting value of the process
  Tmax       <-  5              # Time horizon
  Tstart     <-  1              # Time starts at 1
  increment  <-  1/100          # Incremental time steps
  
  # Generate the transitional density
  M <- GQD.density(Xs=initial,Xt=states,s=Tstart,t=Tmax,delt=increment)
  
  if(require(rgl, quietly = TRUE))
  {
    open3d(windowRect=c(50,50,640+50,50+640),zoom=0.95)
    persp3d(x=M$Xt,y=M$time,z=M$density,col=3,box=FALSE,xlab='State (X_t)',
            ylab='Time (t)',zlab='Density f(X_t|X_s)')
    play3d(spin3d(axis=c(0,0,1), rpm=3), duration=10)
  }else
  {
    persp(x=M$Xt,y=M$time,z=M$density,col=3,xlab='State (X_t)',ylab='Time (t)',
          zlab='Density f(X_t|X_s)',border=NA,shade=0.5,theta=145)
  }

#===============================================================================
# Generate the transition density for a diffusion process with restricted domain.
# The diffusion has reflective boundaries at 0 and 1.
#-------------------------------------------------------------------------------
  
  GQD.remove()         
  
  G0 <- function(t){0.4*(0.5+sin(2*pi*t))}    
  G1 <- function(t){-0.4}
  Q1 <- function(t){0.25}
  Q2 <- function(t){-0.25}
  
  states     <-  seq(0.005,0.995,1/200) 
  initial    <-  0.5              
  Tmax       <-  5              
  increment  <-  1/50          
  
  # Generate the transitional density
  M <- GQD.density(Xs=initial,Xt=states,s=0,t=Tmax,delt=increment,
                   Dtype='Beta',Trunc=c(8,8))
  
  if(require(rgl, quietly = TRUE))
  { 
    open3d(windowRect=c(50,50,640+50,50+640),zoom=0.95)
    persp3d(x=M$Xt,y=M$time,z=M$density,col='steelblue',box=FALSE,
            xlab='State (X_t)',ylab='Time (t)',zlab='Density f(X_t|X_s)')
    play3d(spin3d(axis=c(0,0,1), rpm=3), duration=10)
  }else
  {
    persp(x=M$Xt,y=M$time,z=M$density,col=3,xlab='State (X_t)',ylab='Time (t)',
          zlab='Density f(X_t|X_s)',border=NA,shade=0.5,theta=145)
  }
#===============================================================================

}

\keyword{Transition density }
\keyword{Cumulants }
\keyword{Moments }
\keyword{Saddlepoint }
\keyword{Pearson system }
