#' @keywords internal
"_PACKAGE"

#' High-performance file input/output with ribios
#' @description Provides high-performance file input/output for bioinformatics and computational biology tasks
#' @useDynLib ribiosIO, .registration=TRUE, .fixes="C_"
#' @name ribiosIO-package
NULL

#' @importFrom methods is
#' @importFrom utils read.csv read.table write.table
#' @importFrom ribiosUtils matchColumn trim
NULL
