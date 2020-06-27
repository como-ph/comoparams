
##
x <- ph_set_screening()

test_that("screening is set", {
  expect_is(x, "list")
  expect_true(all(is.na(x)))
})
