#' Read a BED file
#' 
#' @param file Character string, name of a BED file.
#' @param ... Other parameters passed to \code{\link{read.table}}. If not 
#'   specified, default settings are used.
#' 
#' @return A \code{data.frame} containing all information in the BED file.
#'  
#' @references Definition of BED files can be found at 
#'   \url{https://www.ensembl.org/info/website/upload/bed.html}.
#' @seealso \code{\link{read.table}}
#' @examples 
#' lines <- paste0("#track type=bedDetail ionVersion=4.0 name=\"IAD50039-4_IAD87652-4_Design\"",
#'  "solution_type=4 description=\"TargetRegions_AmpliSeqID_IAD50039 AmpliSeq_Version=3.0.1",
#'  " Workflow=RNA merged with TargetRegions_AmpliSeqID_IAD87652 AmpliSeq_Version=4.48 Workflow=RNA\"",
#'  " color=77,175,74 priority=2", "\n",
#'  "NM_000014\t3316\t3421\tAMPL1384\t0\t+\t.\tGENE_ID=A2M;EntrezGeneID=2", "\n",
#'  "NM_005502\t2488\t2589\tAMPL28385508\t0\t+\t.\tGENE_ID=ABCA1;EntrezGeneID=19","\n",
#'  "NM_000927\t2520\t2624\tAMPL5599607\t0\t+\t.\tGENE_ID=ABCB1;EntrezGeneID=5243","\n",
#'  "NM_000443\t1367\t1470\tAMPL5513474\t0\t+\t.\tGENE_ID=ABCB4;EntrezGeneID=5244")
#'  read_bed(textConnection(lines))
#' @importFrom ribiosUtils haltifnot
#' @export
read_bed <- function(file, ...) {
  res <- read.table(file,...)
  ribiosUtils::haltifnot(ncol(res)>=3,
                         msg="BED file must contain at least three columns")
  bedcols <- c("chrom", "chromStart", "chromEnd",
               "name", "score", "strand", "thickStart", "thickEnd", "itemRgb",
               "blockCount", "blockSizes", "blockStarts")
  valInd <- 1:pmin(length(bedcols), ncol(res))
  colnames(res)[valInd] <- bedcols[valInd]
  return(res)
}
