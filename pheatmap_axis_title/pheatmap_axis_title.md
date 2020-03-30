## Issue
I use the [pheatmap](https://cran.r-project.org/web/packages/pheatmap/index.html) package to draw heatmaps in R.  If I have a small number of rows or columns I label them individually, but with large numbers that doesn't work.  The `pheatmap` options allow for suppressing row/column labels but then viewers have no idea of what's being plotted.  I wanted to add a generic axis title to pheatmap for such cases.

## Solution
Since `pheatmap` doesn't return a plot object (it returns the clustering dendogram instead), setting the title requires using grid hooks.

Here's the solution I found on [StackOverflow](http://stackoverflow.com/questions/17538830/x-axis-and-y-axis-labels-in-pheatmap-in-r):

```
library(grid)
# create a grid hook for x axis title BEFORE generating heatmap
setHook("grid.newpage", function() { 
  pushViewport(viewport(x=1,y=1,width=0.9, height=0.9, 
                        name="vp", just=c("right","top")))}, 
  action="prepend")

# then create the heatmap
pheatmap(data_matrix, scale = "column",
                 show_colnames = FALSE, # suppress individual column names
                 ...
)

setHook("grid.newpage", NULL, "replace")

# now specify the axis title.  
grid.text("X-Axis Title Text", y=-0.05, x = 0.35, gp=gpar(fontsize=12))
```
Formatting is controlled by`gpar` and the x/y coordinates for the title may take some tweaking.

To add a y axis (row) title, use:  

```
grid.text("Y-Axis Title Text", x=-0.07, rot=90, gp=gpar(fontsize=12))
```

If you're planning to print labels for one axis, I suggest using them for row labels (i.e. fewer rows than columns) so the labels aren't rotated.  They'll be easier to read that way.