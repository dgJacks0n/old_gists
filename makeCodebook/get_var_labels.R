# get_var_labels: access column labels for a data frame
# df must be read from a SAS b7dat file using haven
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
