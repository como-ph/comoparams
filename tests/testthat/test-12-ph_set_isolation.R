
##
x <- ph_set_isolation()

##
test_that("isolation is set", {
  expect_is(x, "list")
  expect_true(x[[1]] == FALSE)
  expect_true(is.na(x[[2]]))
  expect_true(is.na(x[[3]]))
})
