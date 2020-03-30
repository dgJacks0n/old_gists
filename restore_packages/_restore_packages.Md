## Issue
Every time I update R, I have to go through and re-install all the packages I need.

My old system was to install R, start working, and see what broke.  This was a good way to get rid of packages I'd installed just to try out but it got a bit frustrating... and embarassing if somebody else was watching.  

## Solution
In my last update I decided to get organized.  Here's what I did:

1. BEFORE updating, run `installed_packages` and save the output to a file (.csv or similar).  This records what packages were installed before the update.  *Note: this misses some important info (where is the package from - CRAN? Bioconductor? Biogit?).  I need to write a script to capture this more effectively.*

2. Install the new versions of R and Rtools (needed for installation from git).

3. Source the script `reinstall_packages.R` (below) which installs the missing packages from CRAN, biogit or Bioconductor.  Figuring out where to get a package is a kludge; capturing the info BEFORE updating should make this smoother.