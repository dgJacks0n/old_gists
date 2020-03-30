## Issue

The `dplyr::group_by` and `dplyr::summarise` functions calculate within-group statistics but expect the summary function to return a single value.  However, the `quantile` function can calculate several quantiles in a single call using a vector of propabilities:

```
library(dplyr)

# calculate Q1, median and Q3 for MPG across all cars
quantile(mtcars$mpg, probs = c(1:3/4)) # works, gives named vector of Q1, median and Q3

> mtcars %>% group_by(cyl) %>% summarise(mpgQ3 = quantile(mpg, probs = 0.75)) # works, gives just Q3

mtcars %>% group_by(cyl) %>% summarise(Mpg_Quantiles = quantile(mpg, probs = c(1:3/4)))
# result: Error: Column `Mpg_Quantiles` must be length 1 (a summary value), not 3
```

Unfortunately we can't combine these easily:

```
# calculate groupwise Q1, median and Q3 mpg
mtcars %>% group_by(cyl) %>% summarise(quantiles = quantile(mpg, probs = c(1:3/4)))
```

I could calculate separate summaries for each quantile but that's too much typing.  

## Solution
I found this alternative at https://stackoverflow.com/questions/37845915/how-to-use-quantile-with-dplyr-and-group-by/37846490:
```
mtcars %>% group_by(cyl) %>% 
  summarise( nest_col = list(data.frame(qval = quantile(mpg, prob = c(1:3/4))) %>% 
                             rownames_to_column('quantile'))) %>% 
  unnest()
```
Additional summary stats can be calculated but will get repeated for all quantiles:
```
mtcars %>% 
  group_by(cyl) %>% 
  summarise(count = n(), 
            nest_col = list(data.frame(qval = quantile(mpg, prob = c(1:3/4))) %>% 
                                rownames_to_column('quantile'))) %>%
  unnest()
```