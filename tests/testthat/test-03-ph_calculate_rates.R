test_that("output is tibble", {
  expect_is(ph_get_cases() %>% ph_calculate_rates(), "tbl")
})

test_that("output tibble has 8 columns", {
  expect_equal(ncol(ph_get_cases() %>% ph_calculate_rates()), 8)
})

test_that("output tibble has 21 rows", {
  expect_equal(nrow(ph_get_cases() %>% ph_calculate_rates()), 21)
})

test_that("sequence of age_category is correct", {
  expect_true((ph_get_cases() %>% ph_calculate_rates())[1, "age_category"] == "0-5 y.o.")
  expect_true((ph_get_cases() %>% ph_calculate_rates())[7, "age_category"] == "30-35 y.o.")
  expect_true((ph_get_cases() %>% ph_calculate_rates())[15, "age_category"] == "70-75 y.o.")
  expect_true((ph_get_cases() %>% ph_calculate_rates())[21, "age_category"] == "100+ y.o.")
})
