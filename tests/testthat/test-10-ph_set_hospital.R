
##
x <- ph_set_hospital()

##
test_that("hospital parameters set", {
  expect_is(x, "list")
  expect_true(all(is.na(x)))
})
