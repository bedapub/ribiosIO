% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ampliseq.R
\name{read_raw_ampliseq_amplicons}
\alias{read_raw_ampliseq_amplicons}
\title{Read AmpliSeq amplicon informaiton from an raw BED file}
\usage{
read_raw_ampliseq_amplicons(bedFile)
}
\arguments{
\item{bedFile}{Character string, a raw BED file coming from the
AmpliSeq design pipeline (version 7.41+)}
}
\value{
A \code{data.frame}, besides reporting the columns in the BED file, 
contains following additional annotation information: 
\enumerate{
  \item Amplicon
  \item GeneSymbol (which may not be up-to-date)
  \item RefSeq
  \item Length
}
}
\description{
Read AmpliSeq amplicon informaiton from an raw BED file
}
\examples{
lines <- paste0("#track type=bedDetail ionVersion=4.0 name=\"IAD50039-4_IAD87652-4_Design\"",
 "solution_type=4 description=\"TargetRegions_AmpliSeqID_IAD50039 AmpliSeq_Version=3.0.1",
 " Workflow=RNA merged with TargetRegions_AmpliSeqID_IAD87652 AmpliSeq_Version=4.48 Workflow=RNA\"",
 " color=77,175,74 priority=2", "\n",
 "NM_000014\t3316\t3421\tAMPL1384\t.\tA2M", "\n",
 "NM_005502\t2488\t2589\tAMPL28385508\t.\tABCA1","\n",
 "NM_000927\t2520\t2624\tAMPL5599607\t.\tABCB1","\n",
 "NM_000443\t1367\t1470\tAMPL5513474\t.\tABCB4")
 read_raw_ampliseq_amplicons(textConnection(lines))
}
