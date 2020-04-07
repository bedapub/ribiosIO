#' Read (write) FASTA sequences into (from) named character vectors
#' 
#' \code{read_fasta} reads sequences in FASTA format in named character
#' vectors. \code{write_fasta} writes sequences stored as named character
#' vectors into FASTA file.
#' 
#' Names of sequences to be written do not have to begin with the greater-than
#' sign, as they are appended by the function when writing. Similarly, the
#' \code{read_fasta} removes the leading greater-than sign of sequence names.
#' 
#' @aliases read_fasta write_fasta
#' @param file FASTA format file
#' @param x Named characters
#' @return For \code{read_fasta}, a named character vector of FASTA sequences.
#' 
#' For \code{write_fasta}, the side effect is used and no value is returned.
#' @author Jitao David Zhang <jitao_david.zhang@@roche.com>
#' @examples
#' 
#' tmpfile <- tempfile()
#' test.seq <- c("mySeq1"="ATGCG", "mySeq2 correct"="TTGTTCGACGT")
#' write_fasta(test.seq, tmpfile)
#' read_fasta(tmpfile)
#' 
#' @export read_fasta
read_fasta <- function(file) {
  lines <- readLines(file)
  ll <- length(lines)
  iname <- grep("^>", lines)
  seqnames <- lines[iname]

  seqstarts <- iname + 1L
  seqends <- c(iname[-1]-1L, ll)
  seqs <- sapply(1:length(iname), function(x) {
    paste(lines[seq(seqstarts[x], seqends[x], 1L)], collapse="")
  })
  names(seqs) <- gsub("^>", "", seqnames)
  return(seqs)
}

#' @rdname read_fasta
#' @export
write_fasta <- function(x, file) {
  out <- paste(paste(">",names(x), sep=""),
               x, sep="\n")
  writeLines(out, con=file)
}
