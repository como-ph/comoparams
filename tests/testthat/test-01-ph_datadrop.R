test_that("output is tibble", {
  expect_is(ph_gdrive_files(), "tbl")
  expect_is(ph_get_fields(), "tbl")
  expect_is(ph_get_cases(), "tbl")
  expect_is(ph_get_tests(), "tbl")
  expect_is(ph_get_daily(), "tbl")
})

test_that("warnings show", {
  expect_error(ph_gdrive_files(version = "archive"))
  expect_error(ph_gdrive_files(version = "archive", date = Sys.Date()))
  expect_error(ph_gdrive_files(version = "archive", date = "2020-04-12"))
})

test_that("archive output is tibble", {
  expect_is(ph_gdrive_files(version = "archive", date = "2020-05-10"), "tbl")
})

x <- ph_gdrive_files(version = "archive", date = "2020-05-10")

y <- stringr::str_extract(x$name[stringr::str_detect(string = x$name, pattern = "Data Drop")],
                     pattern = "[0-9]{8}")[1]

test_that("archive output is correct date", {
  expect_equal(y, "20200510")
})
