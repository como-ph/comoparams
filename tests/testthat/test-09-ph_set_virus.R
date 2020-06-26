

x <- ph_set_virus()

##
test_that("virus parameters set", {
  expect_is(x, "list")
  expect_true(all(is.na(x)))
})
