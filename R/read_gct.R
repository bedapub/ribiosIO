read_gct_matrix <- function(gct.file, keep.desc=TRUE) {
  gct.file <- checkfile(gct.file)
  mat <- .Call(C_read_gct, gct.file, NULL, keep.desc)
  class(mat) <- c("GctMatrix", "matrix")
  return(mat)
}

read_gctstr_matrix <- function(string, keep.desc=TRUE) {
  mat <- .Call(C_read_gct, NULL, string, keep.desc)
  class(mat) <- c("GctMatrix", "matrix")
  return(mat)
}

#' Convert a GctMatrix into a long data frame
#' 
#' @param gctMatrix A GctMatrix object
#' @return A \code{data.frame} with four columns: \code{feature}, \code{desc}, \code{sample}, and \code{value}
#' 
#' @examples 
#' idir <- system.file("extdata", package="ribiosIO")
#' sample.gct.file <- file.path(idir, "test.gct")
#' test.mat <- read_gct_matrix(sample.gct.file, keep.desc=TRUE)
#' test.long <- gctMatrix2longdf(test.mat)
gctMatrix2longdf <- function(gctMatrix) {
  res <- data.frame(feature=rep(rownames(gctMatrix), ncol(gctMatrix)),
                    desc=rep(gctDesc(gctMatrix), ncol(gctMatrix)),
                    sample=rep(colnames(gctMatrix), each=nrow(gctMatrix)),
                    value=as.vector(gctMatrix))
  return(res)
}

#' Convert a long data.frame into a GctMatrix
#' 
#' @param longdf A data.frame object
#' @param row.col Integer or character string, index or name of the column in which row names are stored
#' @param desc.col Integer or character string,, index or name of the column in which feature descriptions are stored
#' @param column.col Integer or character string, index or name of the column in which sample names are stored
#' @param value.col Integer or character string, index or name of the column in which values are stored
#' @param missingValue Value used for missing values. If \code{NULL}, missing values are reported as NA and a warning will be raised if any value is missing. If \code{NA}, missing values are reported as NA and no warning is raised.
#' 
#' @return A \code{GctMatrix} object
#' 
#' @examples 
#' idir <- system.file("extdata", package="ribiosIO")
#' sample.gct.file <- file.path(idir, "test.gct")
#' test.mat <- read_gct_matrix(sample.gct.file, keep.desc=TRUE)
#' test.long <- gctMatrix2longdf(test.mat)
#' test.rmat <- longdf2gctMatrix(test.long)
longdf2gctMatrix <- function(longdf, 
                             row.col=1L, desc.col=2, column.col=3, value.col=4, missingValue=NULL) {
  mat <- ribiosUtils::longdf2matrix(longdf, row.col=row.col, column.col=column.col, value.col=value.col)
  if(!is.null(desc.col) && !is.na(desc.col)) {
    matchDesc <- as.character(longdf[match(rownames(mat), longdf[, row.col]), desc.col])
  } else {
    matchDesc <- NULL
  }
  return(GctMatrix(mat, matchDesc))
}
