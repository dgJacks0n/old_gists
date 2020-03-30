## Issue
Sometimes I want to use ggplot facets to divide a categorical axis based on a higher level group - for example, splitting subjects based on treatment arm.  By default, facet_grid and facet_wrap will show every subject in both panels even though subject is nested within arm.  I wanted a plot where each facet axis contains only the subjects in the appropriate group (arm).

## Solution
Use the `scales` and `space` arguments to `facet_grid()` to collapse empty spaces.
```
	plot +
     facet_grid(TRT01A_short ~ ., scales = "free", space = "free")
```
The `scales = "free"` setting allows each facet to use its own scales.  The `space` argument adjusts the relative size of each facet instead of making them equivalent.