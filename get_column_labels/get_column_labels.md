## Issue
Reading clinical data sets from sas7bdat files (using the `haven`) package imports column descriptions in addition to the (cryptic) column header.  I want to include the description in my codebook and was having trouble figuring out how to access the information.

## Solution
The descriptions are stored in the 'label' attribute of the individual columns in the imported data frame.  This can be read using 'haven::zap_labels()`.  Not a good name - it sounds like it erases the labels, but instead it extracts them!

The following function `get_var_labels` extracts the labels into a named vector of column name - description pairs.

```
get_var_labels <- function(sas_df) {
  labels <- zap_labels(sas_df)
  
  # haven::zap_labels will return null if attributes aren't labelled
  if(is.null(labels)) {
    warning("Input data frame does not have column labels")
    return(NA)
  }
  
  label_vals <- lapply(labels, function(c){attr(c, "label")})
  
  # return results as named vector
  return(do.call("c", label_vals))
}
```