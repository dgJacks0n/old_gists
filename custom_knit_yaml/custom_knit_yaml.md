## Issue
By default, when a Rmarkdown document is rendered the output goes into the same directory as the input .Rmd file.  Our default hierarchy is to put reports into the *results* subdirectory but have code in the *code* subdirectory.  This can be changed when a file is rendered programmatically (e.g. a script or Makefile) but it's not obvious how to change this when a document is knit using RStudio's buttons/menus.

## Solution
(blatantly stolen from @russom)

There is an undocumented option for a custom knit hook that can be used to override the default output directory when a document is rendered within RStudio.  To use it, insert this line into the YAML header of a Rmarkdown file:
```
knit: (function(inputFile, encoding) { rmarkdown::render(inputFile, output_dir = paste(here::here(), "results", sep = "/"), envir = new.env()) })
```
This example redirects the output from the knit button or menu option to the results subdirectory of the project directory as defined by `here::here()`.  

## Caveats
If you use this hook, be aware of the following:

+ You will lose the ability to change output formats (pdf/html/word) via drop-down menus.  The output will default to the first defined format in your YAML header.  You can change this as an argument to `rmarkdown::render`.
+ The `here::here()` command identifieds the project directory by looking for a .git subdirectory or a .Rproj or .here file the **first** time it is called.  Subsequent changes to the working directory will **not** change the value returned by `here()`.  I have had good experience using `here()` with RStudio projects, but if you're not doing something to start your R session with the project directory as your root then you may have issues.