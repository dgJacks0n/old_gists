# create codebook for a data frame stored in a .Rds file
# output format conforms to specifications for a 
# Bioconductor AnnotatedDataFrame object.

# invoke from command line (unix or windows CMD): 
# Rscript makeCodebook.R -h

library(optparse)
library(stringr)

option_list <- list(
  make_option(c("-i", "--infile"),
              action = "store",
              type = "character",
              help = "Input file: .Rds file in a data frame"),
  make_option(c("-o", "--outfile"),
              action = "store",
              type = "character",
              help = "Output file path"),
  make_option(c("-u", "--update"),
              action = "store_true",
              default = TRUE,
              help = "Include earlier version of outfile"),
  make_option(c("-r", "--replace"),
              action = "store_false",
              dest = "update",
              help = "Do not include earlier version of outfile")
)

opts <- parse_args(OptionParser(option_list=option_list))

# were file options provided?
if(is.null(opts$infile)) {
  stop("Option infile must be provided")
}

if(is.null(opts$outfile)) {
  stop("Option outfile must be provided")
}

#  start from data frame in infile, saved as RDS
stopifnot(file.exists(opts$infile))

phenos <- readRDS(opts$infile)

# make sure we have a data frame
stopifnot(is.data.frame(phenos))


# can we write output?
outdir <- dirname(opts$outfile)
stopifnot(dir.exists(outdir))

# if outfile exists should we merge it?
if(file.exists(opts$outfile) & opts$update) {
  previous <- read.delim(opts$outfile, header = TRUE, sep = "\t",
                         stringsAsFactors = FALSE, row.names = 1)
  
  message("Loading previous codebook from ", opts$outfile)
}

# get column names, types & values for code book
p_meta <- data.frame( Class = unlist( sapply(phenos, 
                                            function(col) { class(col)[[1]]}) ),
                     Values = sapply(phenos, function(col) { 
                       ifelse(length(unique(col)) <= 5, 
                              paste(unique(col), collapse = ";"), "Multiple")}),
                     stringsAsFactors = FALSE )

# if data frame has other column-length attributes, include them
col_attributes <- unlist(lapply(attributes(phenos), 
                                function(x) { length(x) == ncol(phenos)}))
# don't include column names
col_attributes["names"] <- FALSE

additional <- as.data.frame(attributes(phenos)[col_attributes], 
                            stringsAsFactors = FALSE)

# title case column names
colnames(additional) <- str_to_title(colnames(additional))

p_meta <- cbind(p_meta, additional)

# include information from previous codebook (if available and opts$update is true)
if(exists("previous") & opts$update) {
  merged <- merge(p_meta, previous["labelDescription"], all.x = TRUE, all.y = FALSE, 
                  by = "row.names")
  rownames(merged) <- merged$Row.names
  merged$Row.names <- NULL
} else {
  merged <- p_meta
  merged$labelDescription <- ""
}

# reorder columns for Bioconductor annotatedDataFrame
merged <- merged[c("labelDescription", colnames(merged)[colnames(merged) != "labelDescription"])]

# Interactively edit labelDescription to contain info about the column.
# can aslo revise factor status and levels if needed
message("Use the editor to add notes or comments to the labelDescription column")
merged <- edit(merged, title = paste("Codebook for", opts$infile))

# re-order to match inputs
merged <- merged[rownames(p_meta),]

# save finished codebook
write.table( merged, file = opts$outfile, sep = "\t", col.names = NA,
            row.names = TRUE, quote = FALSE)

message("Wrote codebook to ", opts$outfile)