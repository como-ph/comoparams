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

  ## Get current data link folder information and contents
  dropCurrent <- googledrive::drive_ls(googledrive::drive_get(id = "1ZPPcVU4M7T-dtRyUceb0pMAd8ickYf8o"))

  ## Get dropDate
  dropDate <- stringr::str_extract(string = dropCurrent$name,
                                   pattern = "[0-9]{2}/[0-9]{2}") %>%
    paste("2020", sep = "/") %>%
    lubridate::mdy()

  ## Provide message to user
  message(
    paste("Getting information on Google Drive directory structure for latest available data up to ",
          dropDate, ".", sep = "")
  )

  ## Create temporary file
  destFile <- tempfile()

  ## Create link for download of README
  link <- sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download",
                  dropCurrent$id)

  ## Download README to temp directory
  curl::curl_download(url = link, destfile = destFile)

  ## Extract information from PDF on link to folder of current data
  readme <- pdftools::pdf_text(pdf = destFile) %>%
    stringr::str_split(pattern = "\n|\r\n") %>%
    unlist()

  ## Ged id for current data google drive folder
  x <- stringr::word(readme[stringr::str_detect(string = readme,
                                                pattern = "bit.ly/*")][1], -1)

  x <- x %>%
    #decode_short_url() %>%
    RCurl::getURL() %>%
    stringr::str_extract_all(pattern = "[A-Za-z0-9@%#&()+*$,._\\-]{33}") %>%
    unlist()

  ## Get google drive directory sturcture and information
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))

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
         Only provide dates as early as 2020-04-14 or later. Please try again.",
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

