## Issue
The `dplyr` package provides flexible tools for creating cross-tabulations by multiple subgroups using `summarise` and `spread` but it doesn't offer tools for marginal summaries (column/row sums/means/etc).

## Solution

This exampple shows how to create column and row sums from a `dplyr` cross-table by summing all numeric columns.

```
# report log-transformed valeus for cutoffs
tmb %>% group_by(TMB.gt200, ACTARM) %>%
  tally() %>%
  ungroup() %>%
  spread(key = TMB.gt200, value = n) %>%
  bind_rows(., summarise_if(., is.numeric, sum) %>% mutate(ACTARM = "Total")) %>% # sums for columns
  bind_cols(., Total = rowSums(select_if(., is.numeric))) %>% # sum for individual rows
  kable(., caption = "Subject Counts by Arm and TMB Status")
 ```