#' Read CHIP file
#' 
#' The CHIP file format is commonly used to annotate probesets or other
#' identifiers to gene symbols and gene names.  This function imports CHIP
#' files, using a C procedure to accelerate the speed.
#' 
#' The current implementation only parses the first three columns and ignores
#' the rest of columns. This behavior may change in future versions to provide
#' larger flexibility of parsing CHIP-like files.
#' 
#' @param x File name
#' @return A data.frame is returned with three columns: \code{ProbeSetID},
#' \code{GeneSymbol} and \code{GeneTitle}. The column names are concordant with
#' the GSEA convention, except that the empty spaces are omitted.
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @references BROAD institute GSEA manual, available at
#' \url{http://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/Data_formats#CHIP:_Chip_file_format_.28.2A.chip.29}.
#' @examples
#' 
#'   testFile <- system.file("extdata/test.chip", package="ribiosIO")
#'   testChip <- read_chip(testFile)
#'   head(testChip)
#'   stopifnot(identical(colnames(testChip), c("ProbeSetID", "GeneSymbol", "GeneTitle")))
#' 
#' @export read_chip
read_chip <- function(x) {
  x <- path.expand(x)
  as.data.frame(.Call(C_c_read_chip, as.character(x)))
}
