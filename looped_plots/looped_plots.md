## Issue
I need to plot TMB versus multiple clinical and process variables.  Each variable should be its own plot with 'variable' on the X axis and TMB on the Y.  Continuous variables should have scatter plots; categoricals should have box plots.  I don't want to write trivial variations of the same code, and I want all plots to have consistent look/feel.

## Solution
I wrote the function `plot_tmb_vs_var` which generates a plot for two specified columns.  Then I iterate over a list of column names to make each plot.  See the file `r_looped_plots.R` for details.

I added a few bells and whistles, particularly:

+ Generate scatter plots for a continuous X-axis variable or box + scatter for a factor/character
+ The ability to facet by a single column or a formula
+ The ability to change the ggplot theme by passing a different theme to the `ggtheme` argument
+ The option to color by another column