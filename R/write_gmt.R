#' Write a list of gene sets into a GMT file
#' 
#' Write gene-sets in a GMT-list form into GMT files.
#' 
#' This function can be used, for instance, to combine multiple GMT files into
#' a new one.
#' 
#' @param gmt A list of gene sets. It can be either (1) a list with each item
#' is a list of three components, named \sQuote{name}, \sQuote{description} and
#' \sQuote{genes}, or (2) a list of gene identifiers.
#' @param file The GMT file to create
#' @param description Description, used in case \code{gmt} is a list of gene
#' identifiers (e.g. without description).
#' @return Invisible NULL when the file is successfully created. Otherwise an
#' error message will be printed.
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @examples
#' 
#' idir <- system.file("extdata", package="ribiosIO")
#' sample.gmt.file <- file.path(idir, "test.gmt")
#' 
#' test.gmt <- read_gmt_list(sample.gmt.file)
#' 
#' outgmt.file <- paste(tempfile(), ".gmt", sep="")
#' 
#' write_gmt(test.gmt[1:2], file=outgmt.file)
#' 
#' ## a list of identifiers
#' testList <- list(A=LETTERS[3:5], B=LETTERS[4:7], C=12:9)
#' write_gmt(testList, file=outgmt.file)
#' 
#' @export write_gmt
write_gmt <- function(gmt, file, description=NULL) {
  isGeneList <- all(sapply(gmt, function(x) class(x)!="list"))
  isGmtList <- all(sapply(gmt, function(x) is.list(x) & length(x)>=3))
  if(isGeneList) {
    gsets <- names(gmt)
    if(length(description)!=length(gmt))
      description <- rep(description, length(gmt)/length(description))
    gout <- lapply(seq(along=gmt),function(i)
                   list(name=gsets[i], description=description[i], genes=as.character(gmt[[i]])))
  } else if (isGmtList) {
    gout <- gmt
  } else {
    stop("Unrecognized GMT list: it is either a list of gene symbols, or a list of a three-element list with name, description, and genes")
  }

  if(!is.character(file)) {
      stop("'file' must be a string of file name")
  }
  file <- path.expand(file)
  invisible(.Call(C_c_write_gmt, gout, file))
}
