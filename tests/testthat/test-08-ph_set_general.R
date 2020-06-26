x <- ph_set_general()

##
test_that("general parameters set", {
  expect_is(x, "list")
  expect_true(all(is.na(x)))
})
