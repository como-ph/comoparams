
##
x <- ph_set_isolation()

##
test_that("isolation is set", {
  expect_is(x, "list")
  expect_true(all(is.na(x)))
})
