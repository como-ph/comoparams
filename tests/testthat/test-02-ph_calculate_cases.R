x <- ph_get_cases()

y <- x %>% ph_calculate_cases()


test_that("output is tibble", {
  expect_is(y, "tbl")
})

test_that("output names are correct", {
  expect_equal(names(y)[1], "repDate")
  expect_equal(names(y)[2], "cases")
  expect_equal(names(y)[3], "deaths")
  expect_equal(names(y)[4], "recovered")
})
