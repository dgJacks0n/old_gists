# set path to qpdf so I can pass R CMD check --as-cran
# set R_QPDF variable.  Example is for my laptop; update for your installation!
Sys.setenv(R_QPDF = "C:/Users/jacksod/Documents/qpdf-6.0.0-bin-mingw64/qpdf-6.0.0/bin/qpdf.exe")

# make sure it took
Sys.which(Sys.getenv("R_QPDF", "qpdf"))
