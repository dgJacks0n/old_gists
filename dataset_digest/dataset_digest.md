## Issue
A typical analysis workflow involves separate steps or even projects for data preparation (filtering, imputation, annotation...) and analysis (modelling, visualization...).  I typically separate these steps into distinct Rmarkdown reports; each report reads inputs from files, then writes its output to new files.  A change in the input file could lead to changes in the output; I wanted a quick way to check whether an input file has changed

## Solution
*Thanks to @papillos for suggesting this!*
Use MD5 hashes to check dataset contents and integrity. Encode the expected hash value in the analysis (during development) and throw an error if the actual dataset doesn't match (a 'tripwire').  If the changes are expected/legit, update the expected hash value.

```
library(digest)

# read a file using whatever method (text, haven, excel, Rds...)
dataset <- read.file("path/to/file")

# calculate md5 hash
digest <- digest(dataset, algo = md5)

# check vs expected - replace expected value with the actual md5 digest
if(digest != "<expected value>") {
    stop("MD5 digest for input does not match expected value")
}
```