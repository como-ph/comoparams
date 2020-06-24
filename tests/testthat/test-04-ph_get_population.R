#link <- with(dataSources, link[scode == "PSA" & parameter == "population"])
#x <- ph_get_psa2015_pop(file = link)
x <- population_psa_2015

test_that("output is tibble", {
  expect_is(x, "tbl")
})

test_that("output tibble has 6 columns", {
  expect_equal(ncol(x), 6)
})

test_that("output tibble has 87567 rows", {
  expect_equal(nrow(x), 87567)
})

#link <- with(dataSources, link[scode == "WPP" & parameter == "population"])
#x <- ph_get_wpp2019_pop(file = link, period = 2019)

x <- population_wpp_2019

test_that("output is tibble", {
  expect_is(x, "tbl")
})

test_that("output tibble has 6 columns", {
  expect_equal(ncol(x), 6)
})

test_that("output tibble has 21 rows", {
  expect_equal(nrow(x), 21)
})

test_that("sequence of age_category is correct", {
  expect_true(x[1, "age_category"] == "0-4 y.o.")
  expect_true(x[7, "age_category"] == "30-34 y.o.")
  expect_true(x[15, "age_category"] == "70-74 y.o.")
  expect_true(x[21, "age_category"] == "100+ y.o.")
})


#link <- with(dataSources, link[scode == "WPP" & parameter == "births"])
#x <- ph_get_wpp2019_births(file = link, period = 2019)

x <- births_wpp_2019

test_that("output is tibble", {
  expect_is(x, "tbl")
})

test_that("output tibble has 4 columns", {
  expect_equal(ncol(x), 4)
})

test_that("output tibble has 21 rows", {
  expect_equal(nrow(x), 21)
})

test_that("sequence of age_category is correct", {
  expect_true(x[1, "age_category"] == "0-4 y.o.")
  expect_true(x[7, "age_category"] == "30-34 y.o.")
  expect_true(x[15, "age_category"] == "70-74 y.o.")
  expect_true(x[21, "age_category"] == "100+ y.o.")
})

#link <- with(dataSources, link[scode == "WPP" & parameter == "deaths"])
#x <- ph_get_wpp2019_deaths(file = link, period = 2019)

x <- deaths_wpp_2019

test_that("output is tibble", {
  expect_is(x, "tbl")
})

test_that("output tibble has 4 columns", {
  expect_equal(ncol(x), 4)
})

test_that("output tibble has 21 rows", {
  expect_equal(nrow(x), 21)
})

test_that("sequence of age_category is correct", {
  expect_true(x[1, "age_category"] == "0-4 y.o.")
  expect_true(x[7, "age_category"] == "30-34 y.o.")
  expect_true(x[15, "age_category"] == "70-74 y.o.")
  expect_true(x[21, "age_category"] == "100+ y.o.")
})
