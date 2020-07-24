library(ribiosIO)

mydf <- data.frame(chrom=c("NM_000014", "NM_000015", "NM_000021"),
  chromStart=c(3316, 50, 1212),
  chromEnd=c(3421, 146, 1320),
  name=c("AMPL1384", "AMPL7195", "AMPL14470"),
  score=".",
  ID=c("GENE_ID=A2M;EntrezGeneID=2",
       "GENE_ID=NAT2;EntrezGeneID=10",
       "GENE_ID=PSEN1;EntrezGeneID=5663"))
myBed <- tempfile()
write_annotated_ampliseq_amplicons(mydf, myBed)
mydfOut <- read_annotated_ampliseq_amplicons(myBed)

test_that("write_annotated_ampliseq_amplicons and read_annotated_ampliseq_amplicons work as expected",
          {
            testthat::expect_equivalent(mydfOut[,1:6], mydf)
            testthat::expect_equal(mydfOut$Amplicon, mydf$name)
            testthat::expect_equal(mydfOut$GeneID, c("2", "10", "5663"))
            testthat::expect_equal(mydfOut$GeneSymbol, c("A2M", "NAT2", "PSEN1"))
            testthat::expect_equal(mydfOut$RefSeq, mydf$chrom)
            testthat::expect_equal(mydfOut$Length, mydf$chromEnd-mydf$chromStart+1)
          })
