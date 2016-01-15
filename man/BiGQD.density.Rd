\name{BiGQD.density}
\alias{BiGQD.density}
\title{
Generate the Transition Density of a Bivariate Generalized Quadratic Diffusion Model (2D GQD).
}
\description{
\code{BiGQD.density} generates approximate transitional densities for bivariate generalized quadratic diffusions (GQDs). Given a starting coordinate, (\code{Xs}, \code{Ys}), the approximation is evaluated over a lattice \code{Xt} x \code{Yt} for an equispaced discretization (intervals of width \code{delt}) of the transition time horizon [\code{s}, \code{t}] .  
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
BiGQD.density(Xs, Ys, Xt, Yt, s, t, delt=1/100, Dtype='Saddlepoint', print.output=TRUE,
              eval.density=TRUE)
}
\arguments{
  \item{Xt}{x-Coordinates of the lattice at which to evaluate the transition density.}
  \item{Yt}{y-Coordinates of the lattice at which to evaluate the transition density.}
  \item{Xs}{Initial x-coordinate.}
  \item{Ys}{Initial y-coordinate.}
  \item{s}{Starting time of the diffusion.}
  \item{t}{Final time at which to evaluate the transition density.}
  \item{delt}{Step size for numerical solution of the cumulant system. Also used for the discretization of the transition time-horizon. See warnings \bold{[1]} and \bold{[2]}.}
  \item{Dtype}{The density approximant to use. Valid types are \code{"Saddlepoint"} (default) or \code{"Edgeworth"}.}
  \item{print.output}{If \code{TRUE} information about the model and algorithm is printed to the console. }
  \item{eval.density}{If \code{TRUE}, the density is evaluated in addition to calculating the moment eqns.}
}
\details{
\if{html}{\figure{TransDens2.png}{GQD}}

\code{BiGQD.density} constructs an approximate transition density for a class of quadratic diffusion models. This is done by first evaluating the trajectory of the cumulants/moments of the diffusion numerically as the solution of a system of ordinary differential equations over a time horizon \code{[s,t]} split into equi-distant points \code{delt} units apart. Subsequently, the resulting cumulants/moments are carried into a density approximant (by default, a saddlepoint approximation) in order to evaluate the transtion surface. 

 
}
\value{
  \item{density}{3D Array containing approximate density values. Note that the 3rd dimension represents time.}
  \item{Xmarginal}{2D Array containing approximate Xt-marginal density values (calculated using the univariate saddlepoint approximation).}
  \item{Ymarginal}{2D Array containing approximate Yt-marginal density values (calculated using the univariate saddlepoint approximation).}
  \item{Xt}{Copy of x-coordinates.}
  \item{Yt}{Copy of y-coordinates.}
  \item{time}{A vector containing the time mesh at which the density was evaluated.}
  \item{cumulants}{A matrix giving the cumulants of the diffusion. Cumulants are indicated by row-names.}
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
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}


\section{Warning}{
\bold{Warning [1]}:
The system of ODEs that dictate the evolution of the cumulants do so approximately. Thus, although it is unlikely such cases will be encountered in inferential contexts, it is worth checking (by simulation) whether cumulants accurately replicate those of the target GQD. Furthermore, it may in some cases occur that the cumulants are indeed accurate whilst the density approximation fails. This can again be verified by simulation.  

\bold{Warning [2]}:
The parameter \code{delt} is also used as the stepsize for solving a system of ordinary differential equations (ODEs) that govern the evolution of the cumulants of the diffusion. As such \code{delt} is required to be small for highly non-linear models in order to ensure sufficient accuracy.
} 

\seealso{
See \code{\link{BiGQD.mcmc}} and \code{\link{BiGQD.mle}} for likelihood based inference procedures for bivariate GQDs.}



\examples{
\donttest{
#===============================================================================
# Generate the transition density of a stochastic perturbed Lotka-Volterra
# preditor-prey model, with state-dependent volatility:
# dX = (1.5X-0.4*X*Y)dt          +sqrt(0.05*X)dWt
# dY = (-1.5Y+0.4*X*Y-0.2*Y^2)dt +sqrt(0.10*Y)dBt
#-------------------------------------------------------------------------------

# Remove any existing coefficients
GQD.remove()

# Define the X dimesnion coefficients
a10 = function(t){1.5}
a11 = function(t){-0.4}
c10 = function(t){0.05}

# Define the Y dimension coefficients
b01 = function(t){-1.5}
b11 = function(t){0.4}
b02 = function(t){-0.2}
f01 = function(t){0.1}

# Approximate the transition density
res = BiGQD.density(5,5,seq(3,8,length=25),seq(2,6,length=25),0,10,1/100)


#------------------------------------------------------------------------------
# Visuallize the density
#------------------------------------------------------------------------------

par(ask=FALSE)
# Load simulated trajectory of the joint expectation:
data(SDEsim3)
attach(SDEsim3)

# We will simulate some trajectories (crudely) as well:
N=1000; delt= 1/100  # 1000 trajectories
X1=rep(5,N)          # Initial values for each trajectory
X2=rep(5,N)

for(i in 1:1001)
{
  # Applly Euler-Murayama scheme to the LV-model
  X1=pmax(X1+(a10(d)*X1+a11(d)*X1*X2)*delt+sqrt(c10(d)*X1)*rnorm(N,sd=sqrt(delt)),0)
  X2=pmax(X2+(b01(d)*X2+b11(d)*X1*X2+b02(d)*X2^2)*delt+sqrt(f01(d)*X2)*rnorm(N,sd=sqrt(delt)),0)

  # Now illustrate the density:
  filled.contour(res$Xt,res$Yt,res$density[,,i],
  main=paste0('Transition Density \n (t = ',res$time[i],')'),
  color.palette=colorRampPalette(c('white','green','blue','red'))
  ,xlab='Prey',ylab='Preditor',plot.axes=
   {
     # Add simulated trajectories
     points(X2~X1,pch=20,col='grey47',cex=0.01)
     # Add trajectory of simulated expectation
     lines(my~mx,col='grey57')
     # Show the predicted expectation from BiGQD.density()
     points(res$cumulants[5,i]~res$cumulants[1,i],bg='white',pch=21,cex=1.5)
     axis(1);axis(2);
     # Add a legend
     legend('topright',lty=c('solid',NA,NA),col=c('grey57','grey47','black'),
             pch=c(NA,20,21),legend=c('Simulated Expectation','Simulated Trajectories'
             ,'Predicted Expectation'))
   })
}

#===============================================================================
}

}

\keyword{transition density}
\keyword{bivariate saddlepoint}
\keyword{bivariate Edgeworth}
\keyword{moments}
\keyword{cumulants}