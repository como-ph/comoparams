## Tests for set_population functions

## Test that population parameter is set
test_that("population is set", {
  expect_is(ph_set_population(), "data.frame")
})
