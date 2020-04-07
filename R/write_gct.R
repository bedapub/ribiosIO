## TODO: if attr(matrix, "desc") is not NULL, feat.desc is silently ignored - needs to be fixed
## 09.11.2014 zhangj83


#' Write matrix in GCT file format
#' 
#' Write matrix in GCT file format
#' 
#' Input matrix will be transformed into the GCT format. The transformed texts
#' are printed on the standard output or in specified files.
#' 
#' If the input matrix has \code{NULL} as row names, and the \code{feat.name}
#' option is left missing, a warning message will be print and the \code{NAME}
#' column of the gct file will use integer indices starting from \code{1}.
#' 
#' \code{feat.desc} specifies feature descriptions. Leaving is missing, or
#' assigning it to \code{NA} or \code{NULL} will output a description column
#' filled with empty strings.
#' 
#' @param matrix A numeric matrix
#' @param file Output file name. By default the file is written to standard
#' output
#' @param feat.name Character vector, optional. Feature names; if missing the
#' row names are used as feature names. If given, \code{feat.name} must be of
#' the same length as the row number of the input matrix.
#' @param feat.desc Character vector, optional. Feature descriptions; if
#' missing, empty strings will be used as descriptions.
#' @param na Character string, how 'NA' values will be printed?
#' @return Texts printed in \code{stdout()} or in output file.
#' @note From version 1.0-22, write_gct is able to handle zero-row matrix (see
#' examples below)
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @seealso \code{\link{read_gct_matrix}} to read matrix from GCT files.
#' @examples
#' 
#' tmpMatrix <- matrix(rnorm(15), nrow=3L, ncol=5L,
#' dimnames=list(LETTERS[1:3L], letters[1:5L]))
#' 
#' write_gct(tmpMatrix)
#' write_gct(tmpMatrix, file=tempfile())
#' 
#' ## specify feature names
#' write_gct(tmpMatrix, feat.name=c("F1", "F2", "F3"))
#' write_gct(tmpMatrix, feat.name=c("F1", "F2", "F3"), feat.desc=NULL)
#' write_gct(tmpMatrix, feat.name=c("F1", "F2", "F3"), feat.desc=NA)
#' 
#' ## specify feature names and descriptions
#' write_gct(tmpMatrix, feat.name=c("F1", "F2", "F3"), feat.desc=
#' c("Feature 1", "Feature 2", "Feature 3"))
#' 
#' ## special case: 0-row matrix
#' write_gct(tmpMatrix[c(FALSE,FALSE,FALSE),,drop=FALSE])
#' 
#' @export write_gct
write_gct <- function(matrix, file=stdout(), feat.name, feat.desc, na="") {
  if(missing(feat.name)) {
    feat.name <- rownames(matrix)
    if(is.null(feat.name)) {
      warning("'matrix' has NULL as row names, therefore integer indices are used.\n  Consider specifying 'feat.name' instead\n")
      feat.name <- 1:nrow(matrix)
    }
  } else {
    stopifnot(length(feat.name)==nrow(matrix))
  }
  if(!is.null(mdesc <- attr(matrix, "desc"))) {
    feat.desc <- mdesc
  } else if(missing(feat.desc) || is.null(feat.desc)) {
    feat.desc <- ""
  }
  if(identical(file, "")) file <- stdout()
  prefix <- paste("#1.2", "\n", nrow(matrix), "\t", ncol(matrix), 
                  sep = "")
  if(nrow(matrix)>0) {
    writeLines(prefix, file)
    df <- data.frame(NAME=feat.name, Description=feat.desc)
    df <- cbind(df, matrix)
    suppressWarnings(write.table(df, file=file, append=TRUE,
                                 quote=FALSE, sep="\t",
                                 row.names=FALSE, col.names=TRUE, na=na))
  } else {
    if(is.null(colnames(matrix))) {
      warning("'matrix' is empty and has NULL as col names. Integer indices are used.\n")
      colnames(matrix) <- 1:ncol(matrix)
    }
    df <- paste(c("NAME", "Description", colnames(matrix)),
                collapse="\t")
    prefix <- paste(prefix, df, sep="\n")
    writeLines(prefix, file)
  }
}
