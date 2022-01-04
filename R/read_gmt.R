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



#' Read gene-sets in a GMT file into a data.frame
#' 
#' @param gmt.file Character, name of one gmt-format file
#' @param description Logical, whether the result should contain descriptions of
#' gene-sets as a column.
#' @return A \code{data.frame}. If \code{description} is set to \code{FALSE},
#' the \code{data.frame} contains two columns: \code{geneset} and \code{gene};
#' otherwise, it contains three columns: \code{geneset}, \code{description}, and
#' \code{gene}.
#' @examples
#'
#' idir <- system.file("extdata", package="ribiosIO")
#' sample.gmt.file <- file.path(idir, "test.gmt")
#'
#' testGmtDataframe <- read_gmt_dataframe(sample.gmt.file)
#'
#' @export
read_gmt_dataframe <- function(gmt.file, description=FALSE) {
    glist <- read_gmt_list(gmt.file)
    ggenes <- lapply(glist, function(x) x$genes)
    gsets <- rep(names(glist),sapply(ggenes, length))
    genes <- unlist(ggenes)
    if(description) {
       desc <- rep(sapply(glist, function(x) x$description),
                   sapply(ggenes, length))
       df <- data.frame(geneset=gsets, description=desc,
                        gene=genes, row.names=NULL)
    } else {
       df <- data.frame(geneset=gsets, gene=genes, row.names=NULL)
    }
    return(df)
}
