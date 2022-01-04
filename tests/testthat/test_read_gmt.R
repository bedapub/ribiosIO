library(ribiosIO)
library(testthat)

context("Test read_gmt_list and read_gmt_dataframe")

gmtFile <- file.path(system.file("extdata", package="ribiosIO"),
		     "test.gmt")
gmtList <- read_gmt_list(gmtFile)
gmtDf <- read_gmt_dataframe(gmtFile, description=FALSE)
gmtDescDf <- read_gmt_dataframe(gmtFile, description=TRUE)

gmtExpList <- list("HSA-LET-7A"=list(name="HSA-LET-7A", description="Roche1", genes=c("AAK1", "ABCB9")),
		   "HSA-LET-7A-S"=list(name="HSA-LET-7A-S", description="Roche2", genes=c("ABCB9", "ABI3BP", "ACAP2", "ACBD5")),
		   "HSA-LET-7B"=list(name="HSA-LET-7B", description="Roche3", genes=c("AAK1", "ABCB9", "ABCC10", "ABCC13", "ABCC5", "ABL2")),
		   "HSA-LET-7B-S"=list(name="HSA-LET-7B-S", description="Roche4", genes=c("ACAP2", "ACBD5")))
glen <- c(2, 4, 6, 2)
gmtExpDescDf <- data.frame(geneset=rep(c("HSA-LET-7A", "HSA-LET-7A-S", "HSA-LET-7B", "HSA-LET-7B-S"), glen),
			   description=rep(paste0("Roche", 1:4), glen),
			   gene=c("AAK1", "ABCB9",
				   "ABCB9", "ABI3BP", "ACAP2", "ACBD5", 
				   "AAK1", "ABCB9", "ABCC10", "ABCC13", "ABCC5",
				   "ABL2", "ACAP2", "ACBD5"), row.names=NULL)
gmtExpDf <- gmtExpDescDf[, c("geneset", "gene")]

test_that("read_gmt_list works as expected", {
    expect_identical(gmtList, gmtExpList)
})

test_that("read_gmt_dataframe works as expected", {
    expect_identical(gmtDf, gmtExpDf)
    expect_identical(gmtDescDf, gmtExpDescDf)
})
