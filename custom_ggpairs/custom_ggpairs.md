## Issue
The `ggpairs()` function in the `GGally` package provides a ggplot-based pairs plot that compares multiple columns in a data set.  One half of the plot provides pairwise scatter plots that are essential for viewing data relationships.  However, for large data sets (1k or more rows) the points quickly become over-plotted, obscuring the overall relationship.  The plots also take a long time to render.

## Solution
The default plots in ggpairs can be over-ridden by a a custom plotting function.  In this case, we use a custom plot with `stat_bin_2d` to aggregate points within 2-d bins of the plot.  The fill aesthetic maps a color to the density (number of points) in each bin.  This addresses the overplotting issue, illustrates the overall distribution more clearly, and speeds up rendering.

1.  Define a custom plotting function that generates the individual scatter plots.  The plot data and mapping (aes) are supplied as arguments to this function.  
    
    ```
    customPlot <- function(data, mapping, ..., low = 0, high = 1, bins_n = 33,
                           fontsize = 8) {
      ggplot(data = data, mapping = mapping) +
        stat_bin2d(bins = bins_n) +
        scale_color_viridis() +
        theme_minimal(fontsize)
    }
    ```
You will need to set a fairly small fontsize for these plots.
2. Tell `ggpairs` to use our custom plot function for scatterplots instead of the default.  I put the scatter plots on the lower triangle of the matrix but they can be swapped.
    
    ```
      pairplot <- ggpairs(corr_table, lower = list( continuous = customPlot),
                               upper = list( continuous = wrap("cor", size = 3)),
                               title = "Pairs Plot Example" # UPDATE for your plot ;-)
                               ) +
        theme_dj(10) # affects the top-level title, etc - not the individual axes
    ```
