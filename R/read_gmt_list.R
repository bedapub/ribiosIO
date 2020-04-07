#' Calling C routine to read GMT file into a list
#' 
#' The function \code{read_gmt_list} calls the C routine \code{read_gmt} to
#' read GMT file into a list.
#' 
#' Empty lines or lines without genes are omitted.Empty fields in
#' \dQuote{genes} are omitted as well.
#' 
#' @aliases read_gmt_list read_gmt
#' @param gmt.file Character, name of one gmt-format file
#' @return A list, the length of which equals the number of genesets. Each list
#' contains three items: \item{name}{Character, gene set name}
#' \item{description}{Character, gene set description} \item{genes}{Character
#' vector, genes in the set}
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @examples
#' 
#' idir <- system.file("extdata", package="ribiosIO")
#' sample.gmt.file <- file.path(idir, "test.gmt")
#' 
#' test.gmt <- read_gmt_list(sample.gmt.file)
#' 
#' @export read_gmt_list
read_gmt_list <- function(gmt.file) {
  gmt.file <- checkfile(gmt.file)
  ll <- .Call(C_c_read_gmt, gmt.file)
  return(ll)
}
