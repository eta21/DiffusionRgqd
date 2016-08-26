
# DiffusionRgqd
Inference and Analysis for Generalized Quadratic Diffusions

## What is DiffusionRgqd?
__DiffusionRgqd__ is collection of tools for performing inference and analysis on scalar and bivariate time-inhomogeneous diffusion processes with quadratic drift and diffusion terms in R.

## Why use DiffusionRgqd?
__DiffusionRgqd__ provides a simple interface that requires minimal mathematical input in order to perform analysis on non-linear, time-inhomogeneous diffusion processes. The package also makes use of C++ in order to maximize the computational efficiency of inference routines. As such it is possible to conduct inference on a plethora of models in a desktop environment without incurring excessively long computation times.

## Get DiffusionRgqd?
Check out [DiffusionRgqd](https://github.com/eta21/DiffusionRgqd) for the package source files, vignettes and other downloadable content or visit the [DiffusionRgqd CRAN page](https://CRAN.R-project.org/package=DiffusionRgqd).


# Installation Notes
Mac users may have to carry out some additional installation procedures in order for __DiffusionRjgqd__ to operate optimally. 

## Mac users:
To install the latest version of __Rcpp__, the latest version of R is needed.
To install __RcppArmadillo__, the __Fortran__ version used by R needs to be updated.
To install __rgl__, the computer needs to have X11 installed.
Update R to the latest version.
Run the following code:
install.packages("Rcpp", type = "source",dep=T) 

#### Open a Terminal and run the following code:

curl -O http://r.research.att.com/libs/gfortran-4.8.2-darwin13.tar.bz2 
sudo tar fvxz gfortran-4.8.2-darwin13.tar.bz2 -C / 

#### Back in R, run the following code:
install.packages("RcppArmadillo",dep=T) 

#### Make sure you have X11 installed. 
Go to Applications/Utilities and see if X11 is there. If not, you’ll need to install X11 or XQuartz. These are available from http://xquartz.macosforge.org/landing/

#### Back in R, run the following code:
```
install.packages(“rgl",dep=T) 
```

#### Download the DiffusionRjgqd package and run the code:
```
install.packages("~/DiffusionRgqd_0.1.3.tar.gz", repos = NULL, type = "source”)
```

#### Run the following code in R to see if the package works:
```
library(DiffpackRgqd) 
example(GQD.density)
example(GQD.mcmc)
```