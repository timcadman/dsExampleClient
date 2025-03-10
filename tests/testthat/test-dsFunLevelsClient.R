library(testthat)
conns <- setupDSLite()

test_that("Valid inputs do not throw an error", {
  expect_silent(.check_args("example", "This is a message"))
  expect_silent(.check_args(c("a", "b"), "Message"))
})

test_that("NULL x throws an error", {
  expect_error(.check_args(NULL, "This is a message"), "`x` must not be NULL")
})

test_that("NULL fun_message throws an error", {
  expect_error(.check_args("example", NULL), "`fun_message` must not be NULL")
})

test_that("Non-character x throws an error", {
  expect_error(.check_args(123, "This is a message"), "`x` must be a character vector")
  expect_error(.check_args(TRUE, "This is a message"), "`x` must be a character vector")
  expect_error(.check_args(list("a", "b"), "This is a message"), "`x` must be a character vector")
})

test_that("Non-character fun_message throws an error", {
  expect_error(.check_args("example", 123), "`fun_message` must be a character vector")
  expect_error(.check_args("example", FALSE), "`fun_message` must be a character vector")
  expect_error(.check_args("example", list("a")), "`fun_message` must be a character vector")
})

test_that("ds.funLevels returns the correct message", {
  expect_equal(
    ds.funLevels(
      x = "iris$Species",
      fun_message = "This Is A Fun Message",
      datasources = conns),
    list(server_1 = "ThisIsAFunMessage: setosa, versicolor, virginica")
  )
})

test_that("ds.funLevels returns an error if factor has too many levels", {
  expect_error(
    ds.funLevels(
      x = "mtcars$disp",
      fun_message = "ThisIsAFunMessage",
      datasources = conns)
  )
})
