## Issue
I got a clinical data set that was supposed to have 1 row/subject but contained some duplicates because one or more of the columns had different values.  I wanted a quick, reliable way to find out which columns were duplicated.

## Solution
I used `dplyr` to pull out the duplicates and get the number of values for each column, then used `Filter()` to pull out the columns.  This makes it easy to see what  is duplicated and decide how to resolve the duplications.

```
# data frame 'treated' contains treatment info, should have 1 row/subject but contains duplicates

# List the duplicated USUBJIDs
tx_dups <- treated$USUBJID[duplicated(treated$USUBJID)]

# Note - just doing treated[duplicated(treated$USUBJID)] only gives the duplicate row, not all rows.

# Find out which columns have multiple values/subject
multivals <- filter(treated, USUBJID %in% tx_dups) %>% # all rows for duplicated subjects
  group_by(USUBJID) %>% summarise_all(n_distinct) %>% # count number of values/column
  select(-one_of("USUBJID")) %>% ungroup() %>%  # remove non-numeric column
  summarise_all(max) %>% Filter(function(x){x > 1}, .) %>% colnames(.) # get columns with >1 value/subject in any subject
  
 # Show me the columns with multiple values/subject
filter(treated, USUBJID %in% tx_dups) %>% select(one_of(c("USUBJID", multivals)))

```