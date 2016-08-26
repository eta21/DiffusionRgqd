\name{GQD.plot}
\alias{GQD.plot}
\title{
Quick Plots for DiffusionRgqd Objects 
}
\description{
\code{GQD.plot()} recognizes output objects calculated using routines from the \bold{DiffusionRgqd} package and subsequently constructs an appropriate plot, for example a perspective plot of a transition density.
}
\usage{
GQD.plot(x, thin = 1, burns, h = FALSE, palette = "mono")
}
\arguments{
  \item{x}{
Generic GQD-objects, i.e. \code{res = GQD.density()}.
}
  \item{thin}{
Thinning interval for \code{.mcmc} objects.
}
  \item{burns}{
Number of parameter draws to discard for \code{.mcmc} objects.
}
  \item{h}{
  if \code{TRUE} a histogram is drawn i.s.o. a trace plot.
}
\item{palette}{Colour palette for drawing trace plots. Default \code{palette = 'mono'}, otherwise a qualitative palette will be used.}
}

\value{Varies in accordance with input type.
}
\author{
Etienne A.D. Pienaar: \email{etiannead@gmail.com}
}
\references{
Updates available on GitHub at \url{https://github.com/eta21}. 
}


\seealso{
\code{\link{GQD.mcmc}}, \code{\link{GQD.mle}}, \code{\link{GQD.density}}, \code{\link{BiGQD.density}} etc.  
}
\examples{
  \donttest{
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
  
  GQD.plot(M)
  }
}
\keyword{plot}

