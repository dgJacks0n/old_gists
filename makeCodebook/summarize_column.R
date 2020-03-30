summarize_column <- function(thiscol, nvals = 5) {
  # summarize column values
  if(is.factor(thiscol)) { return(paste(levels(thiscol), collapse = ";"))}
  
  if(is.numeric(thiscol) | is(thiscol, "Date") | class(thiscol) == "difftime") {
    summary <- paste(range(na.omit(thiscol)), collapse = " - ")
    
    if(any(is.na(thiscol))) {
      summary <- paste(summary, "with", sum(is.na(thiscol)), "NA values")
    }
    return(summary)
  }
  
  if(is.character(thiscol)) {
    if(length(unique(thiscol)) > nvals) { 
      return("Multiple")
    } else {
      return(paste(unique(thiscol), collapse = ";"))
    }
  } 
  warning("Could not summarize column")
  return(NA)
}
