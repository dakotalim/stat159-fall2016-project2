# lasso tests
# setwd("Desktop/Dakota/stat159-fall2016-project2")
library(testthat)
source("code/functions/lasso-model.R")

context("Check data dimensions")
test_that("data is 400x12",{
  expect_equal(ncol(data), 12)
  expect_equal(nrow(data), 400)
})
test_that("x.test is 100x11",{
  expect_equal(ncol(x.test), 11)
  expect_equal(nrow(x.test), 100)
})
test_that("y.test is 100x1",{
  expect_equal(ncol(y.test), 1)
  expect_equal(nrow(y.test), 100)
})
test_that("x.train is 300x11",{
  expect_equal(ncol(x.train), 11)
  expect_equal(nrow(x.train), 300)
})
test_that("y.train is 300x1",{
  expect_equal(ncol(y.train), 1)
  expect_equal(nrow(y.train), 300)
})

context("ensure models are built correctly")

test_that("cvLassoMSE is a real number",{
  expect_is(cvLassoMSE, "numeric")
})
test_that("bestLassoLambda is a real number",{
  expect_is(bestLassoLambda, "numeric")
})


