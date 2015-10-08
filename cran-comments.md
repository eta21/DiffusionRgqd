## Test environments
* Local Windows 7 install, R 3.2.1
* win-builder (devel and release)

## R CMD check results
* There were no ERRORs or WARNINGs.
* There was one NOTE with four entries:

+ BiGQD.mcmc: no visible binding for global variable 'priors'
+ BiGQD.mcmc: no visible global function definition for 'priors'
+ GQD.mcmc: no visible binding for global variable 'priors'
+ GQD.mcmc: no visible global function definition for 'priors'

This is a result of the package interface and is of no consequence to how the package operates. If the function 'priors' is not specified by the user then it is created by GQD.mcmc or BiGQD.mcmc as needed. 

* PDF version of manual was OK.

## Resubmission
This is a resubmission. In this version I have:

* Corrected DISCRIPTION file errors as pointed out by CRAN staff.
* Corrected version number in DESCRIPTION file.
* Updated NAMESPACE file.
* Used \donttest{} for examples in excess of 5 secs runtime. Ran with  --run-donttest produced no additional ERRORs, WARNINGs or NOTEs.

