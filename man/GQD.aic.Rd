\name{GQD.aic}
\alias{GQD.aic}
\title{
Summarize MLE Selection Output for a List of GQD.mle or BiGQD.mle objects.
}
\description{\code{GQD.aic()}  summarizes the MCMC output from a list of \code{GQD.mle()} objects. This may be used to neatly summarize the MCMC output of various models fitted to a given dataset.
}
\usage{
GQD.aic(model.list, type = "col")
}

\arguments{
  \item{model.list}{
A list of \code{GQD.mle()} objects.
}
  \item{type}{Shoould output be of row (\code{'row'}) or column (\code{'col'}) format.
}
}
\details{
\code{GQD.aic()} summarizes the output from various models fitted via \code{GQD.mle()}. By ranking them according to DIC. \code{[=]} indicates which model has the minimal DIC.
\tabular{lrrrrrr}{
       \tab \code{Convergence}\tab \code{p}\tab \code{min.likelihood} \tab      \code{AIC}    \tab       \code{BIC}\tab   \code{N}\cr
\code{Model 1}\tab           \code{0}\tab \code{5}\tab       \code{171.5576} \tab \code{[=] 353.1152}\tab  \code{[=] 369.6317}\tab \code{201}\cr
\code{Model 2}\tab           \code{0}\tab \code{5}\tab       \code{185.7518} \tab     \code{381.5036}\tab      \code{398.0201}\tab \code{201}\cr
}
}


\value{
  \item{}{A data frame with summary of model output. See Details.}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\note{
}

\seealso{
  \code{\link{GQD.mle}}
}

\examples{
#===============================================================================
# Simulate a time inhomogeneous diffusion.
#-------------------------------------------------------------------------------

  data(SDEsim1)
  attach(SDEsim1)
  par(mfrow=c(1,1))
  expr1=expression(dX[t]==2*(5+3*sin(pi*(t-0.5))-X[t])*dt+0.5*sqrt(X[t]))
  plot(Xt~time,type='l',col='blue',xlab='Time (t)',ylab=expression(X[t]),main=expr1)

 #------------------------------------------------------------------------------
 # Define coefficients of the process.
 #------------------------------------------------------------------------------

  GQD.remove()
  G0 <- function(t){theta[1]+theta[2]*sin(2*pi*(t-theta[3]))}
  G1 <- function(t){-theta[4]}
  Q0 <- function(t){theta[5]*theta[5]}

  theta.start  <- c(10,1,5,0.2,1)                 # Starting values for the chain
  mesh.points  <- 10                              # Number of mesh points
  
  m1 <- GQD.mle(Xt,time,mesh=mesh.points,theta=theta.start)

  GQD.remove()
  G0 <- function(t){theta[1]+theta[2]*sin(pi*(t-theta[3]))}
  G1 <- function(t){-theta[4]}
  Q1 <- function(t){theta[5]*theta[5]}

  theta.start  <- c(10,1,5,0.2,1)                 # Starting values for the chain
  mesh.points  <- 10                              # Number of mesh points

  m2 <- GQD.mle(Xt,time,mesh=mesh.points,theta=theta.start)

  m1$opt$par
  m1$opt$convergence
  m2$opt$par
  m2$opt$convergence


  GQD.aic(list(m1,m2))

#===============================================================================

}
\keyword{ kwd1 }
\keyword{ kwd2 }
