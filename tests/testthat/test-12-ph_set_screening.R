
##
x <- ph_set_screening()

test_that("screening is set", {
  expect_is(x, "list")
  expect_false(x[[1]])
  expect_true(is.na(x[[2]]))
  expect_true(is.na(x[[3]]))
  expect_true(is.na(x[[4]]))
})
