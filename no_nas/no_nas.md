## Issue

I often need to plot a number of columns from clinical data sets using the same layout. I like to define a list of columns then use `lapply` to generate the plots:

```
# plot an output vs multiple columns in data from mydataset

scatterplots <- lapply(numeric_cols, function(thiscol){
  thisplot <- ggplot(data = mydataset, 
                     aes_q(x = as.name(thiscol),
                    y = as.name("Fixed.Column"))) +
                    # add geoms, etc.
```

However - if mydataset$thiscol includes NA I may get a warning.  I want to exclude rows with NA values from plotting only.  I could create a filtered data set but wanted to try something else.

## Solution
Use `dplyr` with 'standard evaluation' (which is not the standard- standard dplyr uses non-standard evaluation because R) plus `lazyeval::interp` to dynamically define a filter:

```
library(lazyeval) # supplies interp() function
...
scatterplots <- lapply(numeric_cols, function(thiscol){
  thisplot <- ggplot(data = tmb %>% 
                       filter_( interp(~(!is.na(var)), var = as.name(thiscol))), 
                     aes_q(x = as.name(thiscol),
                    y = as.name("Fixed.Column"))) +
                    # add geoms, etc.
```

Note the use of `filter_()` instead of the usual (non-standard) `filter()`.  

See https://cran.r-project.org/web/packages/lazyeval/vignettes/lazyeval.html for a taste of the joy that is standard evaluation.
