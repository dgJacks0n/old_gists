# package_installer.R
# script to install packages from a previously saved list.
# e.g. after an R upgrade

# read package listing from a file
pkg_file <- "./R/R_331_pkgs.csv" # output from installed.packages.  Note - need to add repo/source info!
pkgs <- read.csv(pkg_file, stringsAsFactors = FALSE)


# get current installed packages
installed <- installed.packages()[,"Package"]

needed <- !(pkgs$Package %in% installed )

add <- pkgs[needed, "Package"]

# what packages are in CRAN?  Note - this would be much easier if I'd captured the repository in my file!!
in_cran <- available.packages()[,"Package"]

from_cran <- intersect(add, in_cran)

# install packages from cran
install.packages(from_cran, dependencies = TRUE)
 
# manually specify biogit packges and owners 
from_biogit <- c("envDocument" = "jacksod", "analysisTemplate" = "jacksod",
             "SiteMinderBMS" = "russom", 
            "rXpress" = "russom", "purrPull" = "jacksod"
            )

git_url <- "http://biogit.pri.bms.com"

lapply(names(from_biogit), function(p) { 
  pkg_url <- paste(git_url, from_biogit[p], p, sep = "/")
  devtools::install_git(pkg_url, subdir = p)}
  )



# try bioconductor

# update installed list
installed <- installed.packages()[,"Package"]

remaining <- add[!(add %in% installed)]

# set up bioconductor installer
source("https://bioconductor.org/biocLite.R")
biocLite(ask = FALSE)
biocLite(remaining, ask = FALSE, suppressUpdates = FALSE)

# add a couple more non-standard
devtools::install_git("https://biogit.pri.bms.com/brettc/bmsshinyfw") # connie's framework
devtools::install_git("https://biogit.pri.bms.com/jacksod/pvca") # my mods to PVCA


