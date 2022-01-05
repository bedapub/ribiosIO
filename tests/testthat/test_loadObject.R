library(ribiosIO)
library(testthat)
library(utils)

utils::data(sleep, cars)
rdata <- tempfile(fileext=".rdata")
save(sleep, cars, file=rdata)

sleepEnv <- carsEnv <- myEnv <- new.env()
assign("sleep", sleep, env=sleepEnv)
assign("cars", cars, env=carsEnv)
assign("sleep", sleep, env=myEnv)
assign("cars", cars, env=myEnv)

context("Test loadObject")

test_that("loadObject works", {
  expect_identical(loadObject(rdata, "cars"), cars)
  expect_identical(loadObject(rdata, "sleep"), sleep)
})

test_that("loadObjectInEnv works", {
  expect_equal(loadObjectInEnv(rdata), myEnv)
  expect_equal(loadObjectInEnv(rdata, c("cars", "sleep")), myEnv)
  expect_equal(loadObjectInEnv(rdata, "sleep"), sleepEnv)
  expect_equal(loadObjectInEnv(rdata, "cars"), carsEnv)
})