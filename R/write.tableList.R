#' Write a list of data.frames (tables) into files
#' 
#' @param list A list of data frames
#' @param file.names File names. If missing, the names of the list will be
#' used. Must be of the same length as the list
#' @param \dots Other parameters that are passed to \code{\link{write.table}}
#' @return No return value, called for side effects (writes files).
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @seealso \code{\link{write.table}}
#' @examples
#' df1 <- data.frame(name=c("A", "B", "C"), value=1:3)
#' df2 <- data.frame(name=c("C", "D", "E"), value=seq(9,3,-3))
#' dflist <- list(file1=df1, file2=df2)
#' \donttest{
#' tmpdir <- tempdir()
#' write.tableList(dflist,
#'   file.names=file.path(tmpdir, c("file1.txt", "file2.txt")))
#' }
#' 
#' @export write.tableList
write.tableList <- function(list, file.names, ...) {
  if(missing(file.names))
    file.names <- names(list)
  if(is.null(file.names) || length(list)!=length(file.names))
    stop("file.names must be of the same length as list")
  for(i in seq(along=list))
    write.table(list[[i]], file.names[[i]], ...)
}
