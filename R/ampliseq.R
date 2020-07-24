#' Find and read-in AmpliSeq files
#' 
#' Find and read-in AmpliSeq files into an expression matrix
#' 
#' Directory is recursively checked for files that match the name pattern
#' \sQuote{*.cov.xls} (cov means coverage). Invalid links (judged by file size)
#' are excluded.
#' 
#' Only data of total read counts are read-in.
#' 
#' @aliases find_ampliseq read_ampliseq find_and_read_ampliseq
#' @param dir The top-level directory where a AmpliSeq run is saved. An
#' example:
#' \sQuote{/data64/sequencing/iontorrent_data/Auto_user_PR1-139-AmpliSeqRNA_pathway_FD14_277_360/}
#' @param files AmpliSeq files, potentially found by \code{find_ampliseq}
#' @return \code{find_ampliseq} returns a character vector of full names of
#' valid files.
#' 
#' \code{read_ampliseq} returns a numeric matrix of gene expression in counts.
#' Row names are unique gene names.
#' 
#' \code{find_and_read_ampliseq} combines the two functions and returns the
#' expression matrix as \code{read_ampliseq} does.
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @examples
#' 
#' ampdir <- system.file("extdata/ampliseq-data", package="ribiosIO")
#' ampfiles <- find_ampliseq(ampdir)
#' ampmat <- read_ampliseq(ampfiles)
#' 
#' ampmat.onestep <- find_and_read_ampliseq(ampdir)
#' 
#' @export find_ampliseq
find_ampliseq <- function(dir) {
  files <- dir(dir, pattern="*.cov.xls", full.names=TRUE, recursive=TRUE)
  finfo <- file.info(files)
  isValid <- !is.na(finfo$size) & finfo$size>0
  files[isValid]
}

#' @rdname find_ampliseq
#' @export
read_ampliseq <- function(files) {
  tbls <- lapply(files, function(x) {
    tbl <- read.table(x, sep="\t", header=TRUE)
    return(tbl[,c("attributes", "total_reads")])
  })
  uniqGenes <- unique(as.vector(sapply(tbls, function(x) x$attributes)))
  ntbls <- do.call(cbind, lapply(tbls, function(x) {
    x$total_reads[match(uniqGenes, x$attributes)]
    ## matchColumn(uniqGenes, x, "attributes")$total_reads))
  }))
  rownames(ntbls) <- gsub("GENE_ID=", "", uniqGenes)
  colnames(ntbls) <- basename(dirname(files))
  return(ntbls)
}

#' @rdname find_ampliseq
#' @export
find_and_read_ampliseq <- function(dir) {
  files <- find_ampliseq(dir)
  read_ampliseq(files)
}

#' Read AmpliSeq amplicon informaiton from an annotated BED file
#' 
#' @param bedFile Character string, an annotated BED file with \code{Gene_ID} (gene symbols) and \code{EntrezGeneID} (Entrez Gene IDs) in the eighth column.
#' 
#' @return A \code{data.frame}, besides reporting the columns in the BED file, 
#' contains following additional annotation information: 
#' \enumerate{
#'   \item Amplicon
#'   \item GeneID
#'   \item GeneSymbol
#'   \item RefSeq
#'   \item Length
#' }
#' 
#' @note There are several versions of BED file used. This function works only with
#' the latest version.
#' @seealso \code{\link{read_bed}}
#' @examples 
#' lines <- paste0("#track type=bedDetail ionVersion=4.0 name=\"IAD50039-4_IAD87652-4_Design\"",
#'  "solution_type=4 description=\"TargetRegions_AmpliSeqID_IAD50039 AmpliSeq_Version=3.0.1",
#'  " Workflow=RNA merged with TargetRegions_AmpliSeqID_IAD87652 AmpliSeq_Version=4.48 Workflow=RNA\"",
#'  " color=77,175,74 priority=2", "\n",
#'  "NM_000014\t3316\t3421\tAMPL1384\t.\tGENE_ID=A2M;EntrezGeneID=2", "\n",
#'  "NM_005502\t2488\t2589\tAMPL28385508\t.\tGENE_ID=ABCA1;EntrezGeneID=19","\n",
#'  "NM_000927\t2520\t2624\tAMPL5599607\t.\tGENE_ID=ABCB1;EntrezGeneID=5243","\n",
#'  "NM_000443\t1367\t1470\tAMPL5513474\t.\tGENE_ID=ABCB4;EntrezGeneID=5244")
#'  read_annotated_ampliseq_amplicons(textConnection(lines))
#' @export
read_annotated_ampliseq_amplicons <- function(bedFile) {
  ampliconsRaw <- read_bed(bedFile)
  v6 <- as.character(ampliconsRaw[,6])
  gs <- sub("GENE_ID=", "", sapply(strsplit(v6, ";"), "[[", 1L))
  egids <- sub("EntrezGeneID=", "", sapply(strsplit(v6, ";"), "[[", 2L))
  anno <- data.frame(Amplicon=ampliconsRaw[,4L],
                     GeneID=egids,
                     GeneSymbol=gs,
                     RefSeq=ampliconsRaw[,1L],
                     Length=abs(ampliconsRaw[,3]-ampliconsRaw[,2])+1,
                     stringsAsFactors = FALSE)
  amplicons <- cbind(ampliconsRaw,
                     anno)
  return(amplicons)
}

#' Write AmpliSeq amplicon informaiton into an annotated BED file
#' 
#' @param df A \code{data.frame} containing following columns (names do not matter):
#' \enumerate{
#'   \item chrom (RefSeq IDs)
#'   \item chromStart (integer)
#'   \item chromEnd (integer)
#'   \item name (Amplicon IDs)
#'   \item score (A single value, \code{.})
#'   \item ID (in the format of \code{GENE_ID=$GENESYMBOL;EntrezGeneID=$EG_ID})
#' }
#' @param bedFile Character string, the output file
#' @param version Character string, a version number. By default, the current date is used.
#' 
#' @importFrom utils write.table
#' @seealso \code{\link{read_annotated_ampliseq_amplicons}}
#' @examples 
#' mydf <- data.frame(chrom=c("NM_000014", "NM_000015", "NM_000021"),
#'   chromStart=c(3316, 50, 1212),
#'   chromEnd=c(3421, 146, 1320),
#'   name=c("AMPL1384", "AMPL7195", "AMPL14470"),
#'   score=".",
#'   ID=c("GENE_ID=A2M;EntrezGeneID=2",
#'        "GENE_ID=NAT2;EntrezGeneID=10",
#'        "GENE_ID=PSEN1;EntrezGeneID=5663"))
#' myBed <- tempfile()  
#' write_annotated_ampliseq_amplicons(mydf, myBed)
#' mydfOut <- read_annotated_ampliseq_amplicons(myBed)
#' @export
write_annotated_ampliseq_amplicons <- function(df, 
                                               bedFile, 
                                               version=format(Sys.time(), "%Y%m%d")) {
  header <- paste(sprintf("#track name=\"%s\"", "Merged_Molecular_Phenotyping_Amplicons"),
                  "solution_type=4",
                  sprintf("description=\"TargetRegions AmpliSeq_Version=7.41 Workflow=RNA MolPhenVersion=%s\"",
                          version),
                  "type=bedDetail color=77,175,74 priority=2")
  writeLines(header, bedFile)
  write.table(df, bedFile, append=TRUE, quote=FALSE, sep="\t",
              row.names=FALSE, col.names=FALSE)
}

#' Read AmpliSeq amplicon informaiton from an raw BED file
#' @param bedFile Character string, a raw BED file coming from the
#'  AmpliSeq design pipeline (version 7.41+)
#' 
#' @return A \code{data.frame}, besides reporting the columns in the BED file, 
#' contains following additional annotation information: 
#' \enumerate{
#'   \item Amplicon
#'   \item GeneSymbol (which may not be up-to-date)
#'   \item RefSeq
#'   \item Length
#' }
#' 
#' @examples 
#' lines <- paste0("#track type=bedDetail ionVersion=4.0 name=\"IAD50039-4_IAD87652-4_Design\"",
#'  "solution_type=4 description=\"TargetRegions_AmpliSeqID_IAD50039 AmpliSeq_Version=3.0.1",
#'  " Workflow=RNA merged with TargetRegions_AmpliSeqID_IAD87652 AmpliSeq_Version=4.48 Workflow=RNA\"",
#'  " color=77,175,74 priority=2", "\n",
#'  "NM_000014\t3316\t3421\tAMPL1384\t.\tA2M", "\n",
#'  "NM_005502\t2488\t2589\tAMPL28385508\t.\tABCA1","\n",
#'  "NM_000927\t2520\t2624\tAMPL5599607\t.\tABCB1","\n",
#'  "NM_000443\t1367\t1470\tAMPL5513474\t.\tABCB4")
#'  read_raw_ampliseq_amplicons(textConnection(lines))
#' @export
read_raw_ampliseq_amplicons <- function(bedFile) {
  ampliconsRaw <- read_bed(bedFile, skip=1)
  anno <- data.frame(Amplicon=ampliconsRaw[,4L],
                     GeneSymbol=ampliconsRaw[,6],
                     RefSeq=ampliconsRaw[,1L],
                     Length=abs(ampliconsRaw[,3]-ampliconsRaw[,2])+1,
                     stringsAsFactors = FALSE)
  amplicons <- cbind(ampliconsRaw,
                     anno)
  return(amplicons)
}

#' Read bedcov output of AmpliSeq amplicons and convert them to read counts
#' @param file Character string, a GCT file containing bedcov output of amplicons
#' @param bedFile Character string, an annotated BED file encoding amplicons
#' @return A \code{GctMatrix} object containing read counts
#' 
#' The function is used to convert read base counts returned by \code{samtools bedcov} to read counts using Amplicon information encoded in the bed file
#' 
#' @seealso \code{\link{read_annotated_ampliseq_amplicons}}
#' @examples
#' bedlines <- paste0("#track type=bedDetail ionVersion=4.0 name=\"IAD50039-4_IAD87652-4_Design\"",
#'  "solution_type=4 description=\"TargetRegions_AmpliSeqID_IAD50039 AmpliSeq_Version=3.0.1",
#'  " Workflow=RNA merged with TargetRegions_AmpliSeqID_IAD87652 AmpliSeq_Version=4.48 Workflow=RNA\"",
#'  " color=77,175,74 priority=2", "\n",
#'  "NM_000014\t3316\t3421\tAMPL1384\t.\tGENE_ID=A2M;EntrezGeneID=2", "\n",
#'  "NM_005502\t2488\t2589\tAMPL28385508\t.\tGENE_ID=ABCA1;EntrezGeneID=19","\n",
#'  "NM_000927\t2520\t2624\tAMPL5599607\t.\tGENE_ID=ABCB1;EntrezGeneID=5243","\n",
#'  "NM_000443\t1367\t1470\tAMPL5513474\t.\tGENE_ID=ABCB4;EntrezGeneID=5244")
#'  gctLines <- paste0("#1.2", "\n",
#'  "3\t3","\n",
#'  "NAME\tDescription\tS1\tS2\tS3","\n",
#'  "A2M\tNM_000014\t105\t210\t315", "\n",
#'  "ABCA1\tNM_005502\t202\t303\t404", "\n",
#'  "ABCB1\tNM_000927\t312\t416\t520")
#'  bedcovGct <- read_ampliseq_bedcovgct(textConnection(gctLines), 
#'    textConnection(bedlines))
#'  bedcovGct
#' @export
read_ampliseq_bedcovgct <- function(file,
                                     bedFile) {
  amplicons <- read_annotated_ampliseq_amplicons(bedFile)
  
  if(is(file, "textConnection")) {
    baseCount <- read_gctstr_matrix(paste0(readLines(file), collapse="\n"))
  } else {
    baseCount <- read_gct_matrix(file)
  }
  baseCountNormDf <- matchColumn(gctDesc(baseCount),
                                 amplicons, "RefSeq")
  stopifnot(identical(baseCountNormDf$GeneSymbol,
                      rownames(baseCount)))
  baseCountNormFactor <- baseCountNormDf$Length
  stopifnot(!any(is.na(baseCountNormFactor)))
  count <- round(baseCount/baseCountNormFactor)
  return(count)
}
