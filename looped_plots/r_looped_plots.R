library(ggplot2)

source("https://biogit.pri.bms.com/raw/jacksod/ggToys/v0.1/R/theme_dj.R")

# standardize categorical and continuous TMB vs X plots
# mydata: dataset with clinical/process variables and TMB columns
# xcol: column for x axis;  (continuous or char/factor)
# tmbcol: column with TMB (defaults to 'TMB')
# facet: single variable or formula to facet by (optional)
# color: column to color points by (optional)

plot_tmb_vs_var <- function(mydata, xcol, tmbcol = "TMB", facet = NULL, ggtheme = theme_dj(10),
                            color = NULL) {
  
  stopifnot(xcol %in% colnames(mydata))
  stopifnot(tmbcol %in% colnames(mydata))
  
  thisplot <- ggplot(mydata, aes_q(x = as.name(xcol), y = as.name(tmbcol))) 
  
  # use boxplot if x is not continuous 
  if(!(is.numeric(mydata[[xcol]]) | 
       is(mydata[[xcol]], "Date") |
       is(mydata[[xcol]], "POSIXt")) ) {
    thisplot <- thisplot + geom_boxplot(outlier.shape = NA, color = "grey50", fill = "grey80")
  }
  

  thisplot <- thisplot +
    geom_point(position = position_jitter(height = 0, width = 0.1)) + 
    scale_y_log10() +
    labs(x = xcol, y = "TMB (log10 scale)") +
    ggtheme
  
  # add facet if supplied
  if(!is.null(facet)){
    switch(class(facet),
           formula = thisplot <- thisplot + facet_grid(facet),
           character = thisplot <- thisplot + facet_wrap(facet[1]),
           warning("Unable to facet on ", class(facet), " variable ", xcol)
    )
  }
  
  # add color 
  if(!is.null(color)) {
    thisplot <- thisplot + aes_q(color = color)
  }
  
  return(thisplot)
}


# usage

# define a list of columns for X axis. these can be character, factor, numeric or date
clin_vars <- c("TRTGRP", "CTLA4FL", "DRV_BRAFFL", "DRV_SEX",
               "DRV_LDCAT02C", "BOR", "PDL1PSCR", "LAG3PSCR")

for(thiscol in clin_vars) {
  # build plot title
  thistitle <- paste("TMB vs", thiscol)
    
  # generate plot
  thisplot <- plot_tmb_vs_var(tmb, thiscol, facet = "Paired")
  
  # add title to plot
  thisplot <- thisplot + 
    labs(title = thistitle)
  
  print(thisplot)
}
