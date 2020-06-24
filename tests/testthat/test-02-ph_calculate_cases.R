test_that("output is tibble", {
  expect_is(ph_get_cases() %>% ph_calculate_cases(), "tbl")
})

test_that("output names are correct", {
  expect_equal(names(ph_get_cases() %>% ph_calculate_cases())[1], "repDate")
  expect_equal(names(ph_get_cases() %>% ph_calculate_cases())[2], "cases")
  expect_equal(names(ph_get_cases() %>% ph_calculate_cases())[3], "deaths")
  expect_equal(names(ph_get_cases() %>% ph_calculate_cases())[4], "recovered")
})
