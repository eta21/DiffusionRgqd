\name{GQD.mcmc}
\alias{GQD.mcmc}

\title{
MCMC Inference on Generalized Quadratic Diffusion Models (GQDs).
}
\description{
\code{GQD.mcmc()} uses parametrised coefficients (provided by the user as R-functions) to construct a C++ program in real time that allows the user to perform Bayesian inference on the resulting diffusion model. Given a set of starting parameters and other input parameters, a MCMC chain is returned for further analysis.
The structure of the model is predefined and coefficients may be provided for models nested within the generalized quadratic diffusion framework. That is, the saturated GQD model is given by: \strong{\deqn{dX_t = (G_0(t)+G_1(t)X_t+G_2(t)X_t^2)dt+\sqrt{Q_0(t)+Q_1(t)X_t+Q_2(t)X_t^2}dW_t}} where dW_t is Standard Brownian Motion.
}
\usage{
GQD.mcmc(X, time, mesh=10, theta, sds, updates, burns=min(round(updates/2),25000),
         Dtype='Saddle', Trunc=c(4,4), RK.order=4, P=200, alpha=0,
         lower=min(na.omit(X))/2, upper=max(na.omit(X))*2,
         exclude=NULL, plot.chain=TRUE, Tag=NA, wrt=FALSE, print.output=TRUE)
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
  \item{theta}{
The parameter vector of the process. \code{theta} are taken as the starting values of the MCMC chain and gives the dimension of the parameter vector used to calculate the DIC. Care should be taken to ensure that each element in \code{theta} is in fact used within the coefficient-functions, otherwise redundant parameters will be counted in the calculation of the DIC.
}
  \item{sds}{
  Proposal distribution standard deviations. That is, for the i-th parameter the proposal distribution is \emph{~ Normal(...,\code{sds}[i]^2)}
}
  \item{updates}{
The number of chain updates (including burned updates) to perform.
}
  \item{burns}{
The number of updates to burn. That is, the first \code{burns} values are omitted from the inference, although the entire chain is returned.
}
  \item{exclude}{ Vector indicating which transitions to exclude from the analysis. Default = \code{NULL}.}
  \item{plot.chain}{
  If \code{TRUE} (default), a trace plot is made of the resulting MCMC chain (see details).
}
\item{RK.order}{The order of the Runge-Kutta solver used to approximate the trajectories of cumulants. Must be 4 or (default) 10.}
  \item{Dtype}{Character string indicating the type of density approximation (see details) to use. Types: \code{'Saddlepoint'}, \code{'Normal'}, \code{'Gamma'}, \code{'InvGamma'} and \code{'Beta'} are supported (default = \code{'Saddlepoint'}).}
  \item{Trunc}{Vector of length 2 containing the cumulant truncation order and the density truncation order respectively. May take on values 4, 6 and 8 with the constraint that \code{Trunc[1] >= Trunc[2]}. Default is \code{c(4,4)}.} 
\item{P}{Normalization parameter indicating the number of points to use when normalizing members of the Pearson system (see details)}
\item{alpha}{Normalization parameter controlig the mesh concentration when normalizing members of the Pearson system (see details). Increasing \code{alpha} decreases concentration around the mean and vice versa (default \code{alpha = 0}).}
\item{lower,upper}{Lower and upper bounds for the normalization range.}
\item{Tag}{\code{Tag} can be used to name (tag) an MCMC run e.g. \code{Tag='Run_1'}}
\item{wrt}{If \code{TRUE} a .cpp file will be written to the current directory. For bug report diagnostics.}
\item{print.output}{If \code{TRUE} information about the model and algorithm is printed to the console. }
}
\details{

\code{GQD.mcmc()} operates by searching the workspace for functions with names that match the coefficients of the predefined stochastic differential equation. Only the required coefficients need to be specified e.g. \strong{\code{G0(t)}},\strong{\code{G1(t)}} and \strong{\code{Q0(t)}} for an Ornstein-Uhlenbeck model. Unspecified coefficients are ignored. When a new model is to be defined, the current model may be removed from the workspace by using the \code{\link{GQD.remove}} function, after which the new coefficients may be supplied.
}
\value{
  \item{par.matrix }{A matrix containing the MCMC chain on \code{theta}. }
  \item{acceptence.rate }{A vector containing the acceptance rate of the MCMC at every iteration. }
  \item{model.info }{A list of variables pertaining to inference calculations.}
  \item{model.info$elapsed.time}{The runtime, in h/m/s format,of the MCMC procedure (excluding compile time).}
  \item{model.info$time.homogeneous}{`No' if the model has time-homogeneous coefficients and `Yes' otherwise.}
  \item{model.info$p}{The dimension of \code{theta}.}
  \item{model.info$DIC}{Calculated Deviance Information Criterion.}
  \item{model.info$pd}{Effective number of parameters (see \code{model.info$DIC}).}
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
\note{
\bold{Note [1]:} When \code{plot.chain} is \code{TRUE}, a trace plot is created of the resulting MCMC along with the acceptance rate at each update. This may save time when scrutinizing initial MCMC runs. 
}

\section{Syntactical jargon}{
\bold{Synt. [1]:} The coefficients of the 2D GQD may be parameterized using the reserved variable \code{theta}. For example:

\code{G0 <- function(t){theta[1]*(theta[2]+sin(2*pi*(t-theta[3])))}}.


\bold{Synt. [2]:} Due to syntactical differences between R and C++ special functions have to be used when terms that depend on \code{t}. When the function cannot be separated in to terms that contain a single \code{t}, the \code{prod(a,b)} function must be used. For example:

\code{G0 <- function(t){0.1*(10+0.2*sin(2*pi*t)+0.3*prod(sqrt(t),1+cos(3*pi*t)))}}.

Here sqrt(t)*cos(3*pi*t) constitutes the product of two terms that cannot be written i.t.o. a single \code{t}. To circumvent this isue, one may use the \code{prod(a,b)} function. 

\bold{Synt. [3]:} Similarly, the ^ - operator is not overloaded in C++. Instead the \code{pow(x,p)} function may be used to calculate x^p. For example sin(2*pi*t)^3 in:

\code{G0 <- function(t){0.1*(10+0.2*pow(sin(2*pi*t),3))}}.

}

\seealso{
\code{\link{GQD.remove}}, \code{\link{GQD.mle}}, \code{\link{BiGQD.mcmc}}, \code{\link{BiGQD.mle}}, \code{\link{GQD.passage}} and \code{\link{GQD.TIpassage}}.  
}


\examples{
\donttest{
#===============================================================================
# This example simulates a time inhomogeneous diffusion and shows how to conduct
# inference using GQD.mcmc
#-------------------------------------------------------------------------------
 data(SDEsim1)
 attach(SDEsim1)
 par(mfrow=c(1,1))
 expr1=expression(dX[t]==2*(5+3*sin(0.5*pi*t)-X[t])*dt+0.5*sqrt(X[t])*dW[t])
 plot(Xt~time,type='l',col='blue',xlab='Time (t)',ylab=expression(X[t]),main=expr1)
#------------------------------------------------------------------------------
# Define parameterized coefficients of the process, and set up starting
# parameters.
# True model: dX_t = 2X_t(5+3sin(0.25 pi t)-X_t)dt+0.5X_tdW_t
#------------------------------------------------------------------------------

# Remove any existing coeffients. If none are pressent NAs will be returned, but
# this is a safeguard against overlapping.
GQD.remove()

# Define time dependant coefficients. Note that all functions have a single argument.
# This argument has to be `t' in order for the dependancy to be recognized.
# theta does not have to be defined as an argument.

G0 <- function(t){theta[1]*(theta[2]+theta[3]*sin(0.25*pi*t))}
G1 <- function(t){-theta[1]}
Q1 <- function(t){theta[4]*theta[4]}

theta.start  <- c(1,1,1,1)                    # Starting values for the chain
proposal.sds <- c(0.4,0.3,0.2,0.1)*1/2        # Std devs for proposal distributions
mesh.points  <- 10                            # Number of mesh points
updates      <- 50000                         # Perform 50000 updates

#------------------------------------------------------------------------------
# Run the MCMC procedure for the model defined above
#------------------------------------------------------------------------------

m1 <- GQD.mcmc(Xt,time,mesh=mesh.points,theta=theta.start,sds=proposal.sds,
               updates=updates)

# Calculate estimates:
GQD.estimates(m1,thin=200)
#===============================================================================

}
}
\keyword{Syntax}
\keyword{C++}
\keyword{MCMC}


