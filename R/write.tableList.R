#' Write a list of data.frames (tables) into files
#' 
#' @param list A list of data frames
#' @param file.names File names. If missing, the names of the list will be
#' used. Must be of the same length as the list
#' @param \dots Other parameters that are passed to \code{\link{write.table}}
#' @return Side-effects are used
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @seealso \code{\link{write.table}}
#' @examples
#' 
#' \dontrun{
#' df1 <- data.frame(name=c("A", "B", "C"), value=1:3)
#' df2 <- data.frame(name=c("C", "D", "E"), value=seq(9,3,-3))
#' dflist <- list(file1=df1, file2=df2)
#' write.tableList(dflist) ## two files, file1 and file2, are written
#' write.tableList(dflist, file.names=c("file1.txt", "file2.txt")) ## two
#' files, file1.txt and file2.txt, are written
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
