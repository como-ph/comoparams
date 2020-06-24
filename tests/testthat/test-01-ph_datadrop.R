test_that("output is tibble", {
  expect_is(ph_gdrive_files(), "tbl")
})

test_that("warnings show", {
  expect_error(ph_gdrive_files(version = "archive"))
  expect_error(ph_gdrive_files(version = "archive", date = Sys.Date()))
  expect_error(ph_gdrive_files(version = "archive", date = "2020-04-12"))
})
