\name{GQD.estimates}
\alias{GQD.estimates}
\title{
Extract Parmaeter Estimates from \code{.mle()} or \code{.mcmc()} Objects.
}
\description{
\code{GQD.estimates()} calculates parameter estimates from \code{.mle()} or \code{.mcmc()} model objects.
}
\usage{
GQD.estimates(x, thin = 100, burns)
}

\arguments{
  \item{x}{List object of type 'GQD.mcmc' or 'GQD.mle'. That is, when \code{model =GQD.mcmc()} then \code{model} constitutes an appropriate object for \code{x}.  
}
  \item{thin}{
Thinnging level for parameter chain.
}
  \item{burns}{
Number of MCMC updates to discard before calculating estimates.
}
}

\value{
Data frame with parameter estimates and appropriate interval statistics.
}

\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.
}
\examples{
\donttest{
#===============================================================================
# This example simulates a time inhomogeneous diffusion and shows how to conduct
# inference using GQD.mcmc
#-------------------------------------------------------------------------------
library(DiffusionRgqd)
data(SDEsim1)
par(mfrow=c(1,1))
x <- SDEsim1
plot(x$Xt~x$time,type='l',col='blue')
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

G1 <- function(t){theta[1]*(theta[2]+theta[3]*sin(0.25*pi*t))}
G2 <- function(t){-theta[1]}
Q2 <- function(t){theta[4]*theta[4]}

theta.start  <- c(1,1,1,1)                    # Starting values for the chain
proposal.sds <- c(0.4,0.3,0.2,0.1)*1/2        # Std devs for proposal distributions
mesh.points  <- 10                            # Number of mesh points
updates      <- 50000                         # Perform 50000 updates

#------------------------------------------------------------------------------
# Run the MCMC procedure for the model defined above
#------------------------------------------------------------------------------

m1 <- GQD.mcmc(x$Xt,x$time,mesh=mesh.points,theta=theta.start,sds=proposal.sds,
               updates=updates,RK.order=4,wrt=T)

# Calculate estimates:
GQD.estimates(m1,thin=200)
#===============================================================================

}
}


\seealso{
\code{\link{GQD.mcmc}}, \code{\link{GQD.mle}}, \code{\link{BiGQD.mcmc}} and \code{\link{BiGQD.mle}}.
}

