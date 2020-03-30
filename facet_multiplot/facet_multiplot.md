## Issue
Faceting plots in ggplot() allows the visualization of multiple groups in a single plot.
However, if there are two many groups the plots get too small to read.

## Solution
+ Use `cut()` to subset grouping factor.
+ Use `tapply()` to generate a plot for each subset.  
+ Use `gridExtra::mArrangeGrob()` to display the subset plots  on multiple pages

## Example
(Not functional, need to update with demo dataset)

```
library(dplyr)
library(gridExtra)

# dummy dataset 'data' with two grouping columns, 'group_row' and 'group_col'.
# split 'group_row'into subsets.
# set number of subsets
ngroups <- 3

# define subset memberships
grouping <- cut(1:n_distinct(data$group_row), breaks = ngroups, labels = FALSE)

# generate a plot for each subset
# aes and geom not specified, illustration only
plots <- tapply(unique(data$group_row), grouping, function(thisgroup) {
  thisplot <- ggplot(data = filter(data, group_row %in% thisgroup), aes(...) +
  facet_grid(group_row ~ group_cols) +...
})

# print plots, one subset per page
marrangeGrob(plots, ncol = 1, nrow = 1,
  top = quote(paste("Title of My Plots, page", g)))
  
}
```