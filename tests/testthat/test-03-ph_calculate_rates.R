x <- ph_get_cases()

y <- x %>% ph_calculate_rates()

test_that("output is tibble", {
  expect_is(y, "tbl")
})

test_that("output tibble has 8 columns", {
  expect_equal(ncol(y), 8)
})

test_that("output tibble has 21 rows", {
  expect_equal(nrow(y), 21)
})

test_that("sequence of age_category is correct", {
  expect_true(y[1, "age_category"] == "0-5 y.o.")
  expect_true(y[7, "age_category"] == "30-35 y.o.")
  expect_true(y[15, "age_category"] == "70-75 y.o.")
  expect_true(y[21, "age_category"] == "100+ y.o.")
})

test_that("that pdeath is class htest", {
  expect_is(x %>% ph_calculate_pdeath(), "htest")
  expect_is(x %>% ph_calculate_nus(), "htest")
})
