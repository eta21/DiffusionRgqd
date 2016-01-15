\name{GQD.dic}
\alias{GQD.dic}
\title{
Summarize MCMC Selection Output for a List of GQD.mcmc or BiGQD.mcmc objects.
}
\description{\code{GQD.dic()}  summarizes the MCMC output from a list of \code{GQD.mcmc()} objects. This may be used to neatly summarize the MCMC output of various models fitted to a given dataset.
}
\usage{
GQD.dic(model.list, type = "col")
}

\arguments{
  \item{model.list}{
A list of \code{GQD.mcmc()} objects.
}
\item{type}{Shoould output be of row (\code{'row'}) or column (\code{'col'}) format.
}
}
\details{
\code{GQD.dic()} summarizes the output from various models fitted via \code{GQD.mcmc()}. By ranking them according to DIC. \code{[=]} indicates which model has the minimal DIC.
\tabular{lrrrrrr}{
        \tab \code{Elapsed_Time}\tab \code{Time_Homogeneous}\tab           \code{p}\tab    \code{DIC}\tab     \code{pD}\tab   \code{N}\cr
\code{Model 1} \tab     \code{00:00:47}\tab               \code{No}\tab   \code{5.00     }\tab \code{    389.30}\tab   \code{3.92}\tab 201\cr
\code{Model 2} \tab     \code{00:01:00}\tab               \code{No}\tab   \code{5.00     }\tab \code{[=]386.45}\tab   \code{4.13}\tab 201\cr
\code{Model 3} \tab    \code{ 00:02:50}\tab               \code{No}\tab   \code{5.00     }\tab \code{    391.37}\tab   \code{3.94}\tab 201\cr
}}


\value{
  \item{}{A data frame with summary of model output. See Details.}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. Visit \url{http://etiennead.wix.com/diffusionr} for more details on the DiffusionRgqd package.
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}


\seealso{
  \code{\link{GQD.mcmc}}
}

\examples{
\donttest{
#===============================================================================
# Simulate a time inhomogeneous diffusion.
#-------------------------------------------------------------------------------

 data(SDEsim1)
 attach(SDEsim1)
 par(mfrow=c(1,1))
 expr1=expression(dX[t]==2*(5+3*sin(0.5*pi*t)-X[t])*dt+0.5*sqrt(X[t])*dW[t])
 plot(Xt~time,type='l',col='blue',xlab='Time (t)',ylab=expression(X[t]),main=expr1)


 #------------------------------------------------------------------------------
 # Define coefficients of model 1
 #------------------------------------------------------------------------------

  # Remove any existing coeffients. If none are pressent NAs will be returned, but
  # this is a safeguard against overlapping.
    GQD.remove()

  # Define time dependant coefficients. Note that all functions have a single argument.
  # This argument has to be `t' in order for the dependancy to be recognized.
  # theta does not have to be defined as an argument.

  G0 <- function(t){theta[1]*(theta[2]+theta[3]*sin(0.25*pi*t))}
  G1 <- function(t){-theta[1]}
  Q0 <- function(t){theta[4]*theta[4]}

  theta.start   <-  c(1,1,1,1)                     # Starting values for the chain
  proposal.sds  <-  c(0.8,0.1,0.1,0.1)             # Std devs for proposal distributions
  mesh.points   <-  10                             # Number of mesh points
  updates       <-  50000                          # Perform 50000 updates

  priors=function(theta){dnorm(theta[1],5,5)}
  m1 <- GQD.mcmc(Xt,time,mesh=mesh.points,theta=theta.start,sds=proposal.sds,
                 updates=updates)

 
 #------------------------------------------------------------------------------
 # Define coefficients of model 2
 #------------------------------------------------------------------------------

  GQD.remove()
  G0 <- function(t){theta[1]*(theta[2]+theta[3]*sin(0.25*pi*t))}
  G1 <- function(t){-theta[1]}
  Q1 <- function(t){theta[4]*theta[4]}

  proposal.sds  <-  c(0.8,0.1,0.1,0.1)
  m2 <- GQD.mcmc(Xt,time,mesh=mesh.points,theta=theta.start,sds=proposal.sds,
                 updates=updates)

  # Checkthe parameter estimates:
  GQD.estimates(m2,thin = 200)
 #------------------------------------------------------------------------------
 # Summarize the output from the models.
 #------------------------------------------------------------------------------

 GQD.dic(list(m1,m2))
 
#===============================================================================
}
}
\keyword{deviance information criterion (DIC)}
