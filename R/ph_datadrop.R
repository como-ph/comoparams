################################################################################
#
#' Pull Philippines data fields information from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to googledrive and googlesheets4 functions to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Drive
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()}).
#'   Data Drop started on 14 April 2020 so earliest date value that can be used
#'   is 2020-04-14.
#'
#' @return A tibble of metadata for the fields used in the various datasets
#'   distributed via the COVID-19 Data Drop
#'
#' @examples
#' ph_get_fields(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_get_fields <- function(date = Sys.Date()) {
  ## Check whether date is within range
  if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
    stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
         Only provide dates as early as 2020-04-14 or later. Try again.",
         call. = TRUE)
  }
  ## Check curren time to see if current data downloadable
  if(date == Sys.Date()) {
    if(!lubridate::now(tzone = "UTC") %within%
       lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
                           lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
      stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
           Try again later for today's data drop or try yesterday's data drop.",
           call. = TRUE)
    }
  }
  ## Process date
  date <- stringr::str_remove_all(string = date, pattern = "-")
  ##
  googledrive::drive_deauth()
  w <- googledrive::drive_ls(googledrive::drive_get(id = "10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP"))
  x <- w$id[w$name == paste("DOH COVID Data Drop_ ", date, sep = "")]
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Fields.csv")]
  ##
  fields <- read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))
  fields <- tibble::tibble(fields)
  return(fields)
}


################################################################################
#
#' Pull Philippines data on cases information from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to googledrive and googlesheets4 functions to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Drive
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return A tibble of case information on confirmed COVID-19 cases distributed
#'   via the COVID-19 Data Drop
#'
#' @examples
#' ph_get_cases(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_get_cases <- function(date = Sys.Date()) {
  ## Check whether date is within range
  if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
    stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
         Only provide dates as early as 2020-04-14 or later. Try again.",
         call. = TRUE)
  }
  ## Check curren time to see if current data downloadable
  if(date == Sys.Date()) {
    if(!lubridate::now(tzone = "UTC") %within%
       lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
                           lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
      stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
           Try again later for today's data drop or try yesterday's data drop.",
           call. = TRUE)
    }
  }
  ## Process date
  date <- stringr::str_remove_all(string = date, pattern = "-")
  ##
  googledrive::drive_deauth()
  w <- googledrive::drive_ls(googledrive::drive_get(id = "10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP"))
  x <- w$id[w$name == paste("DOH COVID Data Drop_ ", date, sep = "")]
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Case Information.csv")]
  ##
  cases <- read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))
  cases <- tibble::tibble(cases)
  return(cases)
}


################################################################################
#
#' Pull Philippines data on testing aggregates from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to googledrive and googlesheets4 functions to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Drive
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return A tibble of case information on testing aggregates distributed
#'   via the COVID-19 Data Drop
#'
#' @examples
#' ph_get_tests(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_get_tests <- function(date = Sys.Date()) {
  ## Check whether date is within range
  if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
    stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
         Only provide dates as early as 2020-04-14 or later. Try again.",
         call. = TRUE)
  }
  ## Check curren time to see if current data downloadable
  if(date == Sys.Date()) {
    if(!lubridate::now(tzone = "UTC") %within%
       lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
                           lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
      stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
           Try again later for today's data drop or try yesterday's data drop.",
           call. = TRUE)
    }
  }
  ## Process date
  date <- stringr::str_remove_all(string = date, pattern = "-")
  ##
  googledrive::drive_deauth()
  w <- googledrive::drive_ls(googledrive::drive_get(id = "10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP"))
  x <- w$id[w$name == paste("DOH COVID Data Drop_ ", date, sep = "")]
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Testing Aggregates.csv")]
  ##
  tests <- read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))
  tests <- tibble::tibble(tests)
  return(tests)
}


################################################################################
#
#' Pull Philippines data on daily facilities status from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to googledrive and googlesheets4 functions to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Drive
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return A tibble of daily facilities status distributed via the COVID-19
#'   Data Drop
#'
#' @examples
#' ph_get_daily(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_get_daily <- function(date = Sys.Date()) {
  ## Check whether date is within range
  if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
    stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
         Only provide dates as early as 2020-04-14 or later. Try again.",
         call. = TRUE)
  }
  ## Check curren time to see if current data downloadable
  if(date == Sys.Date()) {
    if(!lubridate::now(tzone = "UTC") %within%
       lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
                           lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
      stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
           Try again later for today's data drop or try yesterday's data drop.",
           call. = TRUE)
    }
  }
  ## Process date
  date <- stringr::str_remove_all(string = date, pattern = "-")
  ##
  googledrive::drive_deauth()
  w <- googledrive::drive_ls(googledrive::drive_get(id = "10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP"))
  x <- w$id[w$name == paste("DOH COVID Data Drop_ ", date, sep = "")]
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Daily Report.csv")]
  ##
  daily <- read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))
  daily <- tibble::tibble(daily)
  return(daily)
}

