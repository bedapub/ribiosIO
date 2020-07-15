#' @include writeMatrix.R
NULL

#' Write a list of data.frames (tables) into file with writeMatrix
#' 
#' @param list A list of data frames
#' @param file.names File names. If missing, the names of the list will be
#'   used. Must be of the same length as the list
#' @param row.names Logical, whether row.names should be in the first, 
#'   unnamed column of the output files
#' @param \dots Other parameters that are passed to \code{\link{writeMatrix}}
#' @return Side-effects are used
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @seealso \code{\link{writeMatrix}}
#' @examples
#' 
#' td <- tempdir()
#' cwd <- getwd()
#' setwd(td)
#' df1 <- data.frame(name=c("A", "B", "C"), value=1:3)
#' df2 <- data.frame(name=c("C", "D", "E"), value=seq(9,3,-3))
#' dflist <- list(file1=df1, file2=df2)
#' writeMatrix.tableList(dflist) ## two files, file1 and file2, are written
#' dir()
#' writeMatrix.tableList(dflist, file.names=c("file1.txt", "file2.txt"))
#' dir()
#' setwd(cwd)
#' 
#' @export writeMatrix.tableList
writeMatrix.tableList <- function(list, file.names, row.names=TRUE, ...) {
  if(missing(file.names))
    file.names <- names(list)
  if(is.null(file.names) || length(list)!=length(file.names))
    stop("file.names must be of the same length as list")
  for(i in seq(along=list))
    writeMatrix(list[[i]], file.names[[i]], row.names=row.names, ...)
}
