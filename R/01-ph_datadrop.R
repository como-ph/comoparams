################################################################################
#
#' Get Department of Health COVID-19 Data Drop Google Drive specific directory
#' information
#'
#' A wrapper to googledrive functions to extract information on contents of
#' a specific COVID-19 Data Drop Google Drive directory
#'
#' @param version A character value specifying whether to get the most
#'   currently available dataset (\code{"current"}) or to get archive data
#'   (\code{"archive"}). Default to \code{"current"}
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Only used when \code{version} is set to
#'   \code{"archive"} otherwise ignored.
#'
#' @return A tibble containing information on the various files in a specified
#'   COVID-19 Data Drop Google Drive directory
#'
#' @examples
#' ph_gdrive_files()
#'
#' @export
#'
#'
#
################################################################################

ph_gdrive_files <- function(version = "current", date = NULL) {
  ## Google Drive deauthorisation
  googledrive::drive_deauth()

  dropCurrent <- googledrive::drive_ls(googledrive::drive_get(id = "1ZPPcVU4M7T-dtRyUceb0pMAd8ickYf8o"))$id

  destFile <- tempfile()

  link <- sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", dropCurrent)

  curl::curl_download(url = link, destfile = destFile)

  readme <- pdftools::pdf_text(pdf = destFile) %>%
    stringr::str_split(pattern = "\n|\r\n") %>%
    unlist()

  x <- stringr::word(readme[stringr::str_detect(string = readme, pattern = "bit.ly/*")][1], -1) %>%
    decode_short_url() %>%
    stringr::str_split(pattern = "/|\\?") %>%
    unlist()

  y <- googledrive::drive_ls(googledrive::drive_get(id = x[6]))

  if(version == "archive") {
    if(is.null(date)) {
      stop("Date needs to be specified if version is set to archive. Please try again.",
           call. = TRUE)
    }

    if(lubridate::ymd(date) == Sys.Date()) {
      stop("Date should be earlier than current date to access data archive. Please try again.",
           call. = TRUE)
    }

    ## Check whether date is within range
    if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
      stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
         Only provide dates as early as 2020-04-14 or later. Try again.",
           call. = TRUE)
    }

    ## List contents of Data Drop Archive Google Drive Folder
    dropArchive <- googledrive::drive_ls(googledrive::drive_get(id = "1w_O-vweBFbqCgzgmCpux2F0HVB4P6ni2"))

    ## Get gdriveID based on date
    dropArchiveMonth <- stringr::str_remove_all(string = dropArchive$name,
                                                pattern = "DOH COVID-19 Data Drop \\(|\\)") %>%
      lubridate::parse_date_time(orders = "my") %>%
      lubridate::month()

    gdriveID <- dropArchive$id[dropArchiveMonth == lubridate::month(lubridate::ymd(date))]

    ## Process date
    date <- stringr::str_remove_all(string = date, pattern = "-")

    ## Get list of contents directory specified by gdriveID
    w <- googledrive::drive_ls(googledrive::drive_get(id = gdriveID))

    ## Get the unique identifier for directory for specified date
    x <- w$id[stringr::str_extract(string = w$name, pattern = "[0-9]{8}") == date]

    ## Get listing of contents of specified directory
    y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  }

  ## Return list of contents
  return(y)
}


################################################################################
#
#' Pull Philippines data fields information from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to googledrive and googlesheets4 functions to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Drive
#'
#' @param version A character value specifying whether to get the most
#'   currently available dataset (\code{"current"}) or to get archive data
#'   (\code{"archive"}). Default to \code{"current"}
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Only used when \code{version} is set to
#'   \code{"archive"} otherwise ignored.
#'
#' @return A tibble of metadata for the fields used in the various datasets
#'   distributed via the COVID-19 Data Drop
#'
#' @examples
#' ph_get_fields()
#'
#' @export
#'
#
################################################################################

ph_get_fields <- function(version = "current", date = NULL) {
  ## Check whether date is within range
  #if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
  #  stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
  #       Only provide dates as early as 2020-04-14 or later. Try again.",
  #       call. = TRUE)
  #}

  ## Check curren time to see if current data downloadable
  #if(date == Sys.Date()) {
  #  if(!lubridate::now(tzone = "UTC") %within%
  #     lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
  #                         lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
  #    stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
  #         Try again later for today's data drop or try yesterday's data drop.",
  #         call. = TRUE)
  #  }
  #}

  ## Get list of contents of specified Google drive directory
  y <- ph_gdrive_files(version = version, date = date)

  ## Get identifier of Fields data
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Fields.csv")]

  ## Read fields data CSV
  fields <- utils::read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))

  ## Convert to tibble
  fields <- tibble::tibble(fields)

  ## Return dataset
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
#' @param version A character value specifying whether to get the most
#'   currently available dataset (\code{"current"}) or to get archive data
#'   (\code{"archive"}). Default to \code{"current"}
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Only used when \code{version} is set to
#'   \code{"archive"} otherwise ignored.
#'
#' @return A tibble of case information on confirmed COVID-19 cases distributed
#'   via the COVID-19 Data Drop
#'
#' @examples
#' ph_get_cases()
#'
#' @export
#'
#
################################################################################

ph_get_cases <- function(version = "current", date = NULL) {
  ## Check whether date is within range
  #if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
  #  stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
  #       Only provide dates as early as 2020-04-14 or later. Try again.",
  #       call. = TRUE)
  #}

  ## Check current time to see if current data downloadable
  #if(date == Sys.Date()) {
  #  if(!lubridate::now(tzone = "UTC") %within%
  #     lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
  #                         lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
  #    stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
  #         Try again later for today's data drop or try yesterday's data drop.",
  #         call. = TRUE)
  #  }
  #}

  ## Get list of contents of specified Google Drive directory
  y <- ph_gdrive_files(version = version, date = date)

  ## Check if file named Case Information is available
  if(!any(stringr::str_detect(string = y$name, pattern = "Case Information.csv"))) {
    stop(paste("No cases information on ", date,
               ". Try a date earlier or later than date specified.",
               sep = ""),
         call. = TRUE)
  }

  ## Get unique identifier for Cases data
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Case Information.csv")]

  ## Read Case Information CSV
  cases <- utils::read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z),
                           stringsAsFactors = FALSE)

  ## Convert to tibble
  cases <- tibble::tibble(cases)

  ## Return dataset
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
#' @param version A character value specifying whether to get the most
#'   currently available dataset (\code{"current"}) or to get archive data
#'   (\code{"archive"}). Default to \code{"current"}
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Only used when \code{version} is set to
#'   \code{"archive"} otherwise ignored.
#'
#' @return A tibble of case information on testing aggregates distributed
#'   via the COVID-19 Data Drop
#'
#' @examples
#' ph_get_tests()
#'
#' @export
#'
#
################################################################################

ph_get_tests <- function(version = "current", date = NULL) {
  ## Check whether date is within range
  #if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
  #  stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
  #       Only provide dates as early as 2020-04-14 or later. Try again.",
  #       call. = TRUE)
  #}

  ## Check curren time to see if current data downloadable
  #if(date == Sys.Date()) {
  #  if(!lubridate::now(tzone = "UTC") %within%
  #     lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
  #                         lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
  #    stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
  #         Try again later for today's data drop or try yesterday's data drop.",
  #         call. = TRUE)
  #  }
  #}

  ## Get list of contents of specified Google Drive directory
  y <- ph_gdrive_files(version = version, date = date)

  ## Get unique identifier for testing aggregates dataset
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Testing Aggregates.csv")]

  ## Read testing aggregates CSV
  tests <- utils::read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))

  ## Convert to tibble
  tests <- tibble::tibble(tests)

  ## Return dataset
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
#' @param version A character value specifying whether to get the most
#'   currently available dataset (\code{"current"}) or to get archive data
#'   (\code{"archive"}). Default to \code{"current"}
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Only used when \code{version} is set to
#'   \code{"archive"} otherwise ignored.
#'
#' @return A tibble of daily facilities status distributed via the COVID-19
#'   Data Drop
#'
#' @examples
#' ph_get_daily()
#'
#' @export
#'
#
################################################################################

ph_get_daily <- function(version = "current", date = NULL) {
  ## Check whether date is within range
  #if(!lubridate::ymd(date) %within% lubridate::interval(lubridate::ymd("2020-04-14"), Sys.Date())) {
  #  stop("Earliest COVID-19 Data Drop record is for 2020-04-14.
  #       Only provide dates as early as 2020-04-14 or later. Try again.",
  #       call. = TRUE)
  #}
  ## Check curren time to see if current data downloadable
  #if(date == Sys.Date()) {
  #  if(!lubridate::now(tzone = "UTC") %within%
  #     lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(), "12:00:00 UTC")),
  #                         lubridate::ymd_hms(paste(Sys.Date(), "23:59:59 UTC")))) {
  #    stop("COVID-19 Data Drop is updated everyday at 16:00 Philippines Standard Time.
  #         Try again later for today's data drop or try yesterday's data drop.",
  #         call. = TRUE)
  #  }
  #}

  ## Get list of contents of specified Google Drive directory
  y <- ph_gdrive_files(version = version, date = date)

  ## Get unique identifier for Daily Report CSV
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Daily Report.csv")]

  ## Read daily report CSV
  daily <- utils::read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))

  ## Convert to tibble
  daily <- tibble::tibble(daily)

  ## Return dataset
  return(daily)
}

