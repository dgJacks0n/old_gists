## Issue
When checking a package using `R CMD check --as-cran` one of the steps involves running the **qpdf** program to reduce the size of vignette PDFS.  Because they can be huge - up to 20 kb!  If you don't have qpdf installed and 'findable' by R then your checks will throw an error.  Then `devtools::release` won't upload your package.  Then you won't be famous.  Ever.

## Solution
First, install the appropriate version of **qpdf** from https://sourceforge.net/projects/qpdf.  

Next, tell R how to find your installation.  The code in *qpdf_path.R* shows how to set the path.  I source this file prior to running `R CMD check` because I don't do it very often.  Make sure to update the value of `R_QPDF` to point to your install (hint- it shouldn't still include "jacksod"!).
