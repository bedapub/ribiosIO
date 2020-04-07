#' Read pheno data from CLS or tab-delimited file
#' 
#' Read pheno (sample annotation) data from CLS file or tab-delimited file
#' (sample information file).
#' 
#' \code{read_pheno} returns a data.frame.
#' 
#' \code{read_pheno_factor} returns a factor, indicating sample groups. If the
#' input file is a tab-delimited file, it filters out columns which are
#' identical for all samples and columns which are unique for each sample.
#' Consequently the remaining covariates are concatenated by the underscore
#' character to form a factor. See examples below
#' 
#' @aliases read_pheno read_pheno_factor
#' @param file A CLS file or tab-delimited file
#' @return \code{read_pheno} returns a \code{data.frame} containing sample
#' annotations. In case of \code{CLS} input file, the \code{data.frame}
#' contains two columns: \code{Array} (indices of arrays) and \code{Class}
#' (classes indexed in the GCT file). In case of tab-delimited file, the file
#' will be parsed into the \code{data.frame}, assuming the file having column
#' names but no row names.
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @seealso \code{\link{read_cls}} and \code{\link{read.csv}}.
#' @references For tab-delimited file (sample information file), see
#' \url{http://www.broadinstitute.org/cancer/software/genepattern/gp_guides/file-formats/sections/sample-information-file}.
#' 
#' For CLS file, see
#' \url{http://www.broadinstitute.org/cancer/software/genepattern/gp_guides/file-formats/sections/cls}.
#' @examples
#' 
#' testClsFile <- system.file("extdata/test.cls", package="ribiosIO")
#' testPhenoFile <- system.file("extdata/testSampleInfo.txt",
#' package="ribiosIO")
#' 
#' (clsPheno <- read_pheno(testClsFile))
#' (txtPheno <- read_pheno(testPhenoFile))
#' 
#' stopifnot(identical(clsPheno, txtPheno))
#' 
#' ## read_pheno_factor
#' (clsPhenoClass <- read_pheno_factor(testClsFile))
#' (txtPhenoClass <- read_pheno_factor(testPhenoFile))
#' 
#' testPhenoFileCov <- system.file("extdata/testSampleInfo-cov.txt",package="ribiosIO")
#' read_pheno_factor(testPhenoFileCov)
#' 
#' @export read_pheno
read_pheno <- function(file) {
  lns <- readLines(file)
  txt <- textConnection(paste(lns, collapse="\n"))
  if(length(lns)==3 && grepl("^#", lns[2])) {
    sclass <- read_cls(txt)
    tbl <- data.frame(Array=seq(along=sclass),
                      Class=sclass)
  } else {
    tbl <- read.csv(txt, sep="\t", header=TRUE, comment.char="#")
  }
  close(txt)
  return(tbl)
}

#' @rdname read_pheno
#' @export
read_pheno_factor <- function(file) {
  lns <- readLines(file)
  txt <- textConnection(paste(lns, collapse="\n"))
  if(length(lns)==3 && grepl("^#", lns[2])) {
    sclass <- read_cls(txt)
  } else {
    tbl <- read.csv(txt, sep="\t", header=TRUE, comment.char="#")
    if(ncol(tbl)==1) {
      sclass <- factor(tbl[,1L], levels=unique(tbl[,1L]))
    } else {
      isCov <- apply(tbl, 2L, function(x) length(unique(x)) != 1 && length(unique(x)) != nrow(tbl))
      subtbl <- tbl[,isCov,drop=FALSE]
      classes <- apply(subtbl, 1L, paste, collapse="_")
      sclass <- factor(classes, levels=unique(classes))
    }
  }
  close(txt)
  return(sclass)
}
