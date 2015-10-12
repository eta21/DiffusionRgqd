## Test environments
* Local Windows 7 install, R 3.2.1
* win-builder (devel and release)
* win-builder (devel and release)

## R CMD check results
* There were no ERRORs or WARNINGs.
* There were no NOTEs.
* PDF version of manual was OK.

## Resubmission
This is a resubmission. In this version I have:

* Corrected DESCRIPTION file errors as pointed out by CRAN staff.
* Corrected version number in DESCRIPTION file.
* Updated NAMESPACE file.
* Used \donttest{} for examples in excess of 5 secs runtime. Ran with  --run-donttest produced no additional ERRORs, WARNINGs or NOTEs.
* Fixed LinkingTo RcppArmadillo issue that was not found on any other checks but on CRAN.

