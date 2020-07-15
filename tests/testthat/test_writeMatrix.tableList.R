library(ribiosIO)
library(testthat)

## setup directory
td <- tempdir()
cwd <- getwd()
setwd(td)

df1 <- data.frame(name=c("A", "B", "C"), value=1:3, row.names=c("A", "B", "C"))
df2 <- data.frame(name=c("C", "D", "E"), value=seq(9,3,-3), row.names=NULL)
dflist <- list(file1=df1, file2=df2)
writeMatrix.tableList(dflist, row.names=FALSE)

test_that("writeMatrix.tableList works with row.names=FALSE", {
  expect_true(all(c("file1", "file2") %in% dir()))
  df1In <- readMatrix("file1", row.names=FALSE, as.matrix=FALSE)
  df2In <- readMatrix("file2", row.names=FALSE, as.matrix=FALSE)
  df1NoRownames <- df1; rownames(df1NoRownames) <- NULL
  expect_equal(df1NoRownames, df1In)
  expect_equal(df2, df2In)
})

writeMatrix.tableList(dflist, row.names=TRUE) ## two files, file1 and file2, are written

test_that("writeMatrix.tableList works with row.names=TRUE", {
  expect_true(all(c("file1", "file2") %in% dir()))
  df1In <- readMatrix("file1", row.names=TRUE, as.matrix=FALSE)
  df2In <- readMatrix("file2", row.names=TRUE, as.matrix=FALSE)
  df2WithRownames <- df2; rownames(df2WithRownames) <- 1:nrow(df2)
  expect_equal(df1, df1In)
  expect_equal(df2WithRownames, df2In)
})

writeMatrix.tableList(dflist, file.names=c("file1.txt", "file2.txt"), row.names=FALSE)

test_that("writeMatrix.tableList works with given file names", {
  expect_true(all(c("file1.txt", "file2.txt") %in% dir()))
  df1In <- readMatrix("file1.txt", row.names=FALSE, as.matrix=FALSE)
  df2In <- readMatrix("file2.txt", row.names=FALSE, as.matrix=FALSE)
  df1NoRownames <- df1; rownames(df1NoRownames) <- NULL
  expect_equal(df1NoRownames, df1In)
  expect_equal(df2, df2In)
})

## return to the original directory
setwd(cwd)
