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
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return A tibble
#'
#' @examples
#' ph_get_fields(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_get_fields <- function(date = Sys.Date()) {
  ## Process date
  date <- stringr::str_remove_all(string = date, pattern = "-")
  ##
  googledrive::drive_deauth()
  w <- googledrive::drive_ls(googledrive::drive_get(id = "10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP"))
  x <- w$id[w$name == paste("DOH COVID Data Drop_ ", date, sep = "")]
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  #if(date == "20200416") {
  #  z <- y$id[y$name == paste("DOH COVID Data Drop_", date, " - 03 Metadata - Fields.csv", sep = "")]
  #} else {
  #  z <- y$id[y$name == paste("DOH COVID Data Drop_ ", date, " - 03 Metadata - Fields.csv", sep = "")]
  #}
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Fields.csv")]
  #googlesheets4::sheets_deauth()
  #fields <- googlesheets4::sheets_read(ss = z)
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
#' @return A tibble
#'
#' @examples
#' ph_get_cases(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_get_cases <- function(date = Sys.Date()) {
  ## Process date
  date <- stringr::str_remove_all(string = date, pattern = "-")
  ##
  googledrive::drive_deauth()
  w <- googledrive::drive_ls(googledrive::drive_get(id = "10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP"))
  x <- w$id[w$name == paste("DOH COVID Data Drop_ ", date, sep = "")]
  y <- googledrive::drive_ls(googledrive::drive_get(id = x))
  #if(date == "20200416") {
  #  z <- y$id[y$name == paste("DOH COVID Data Drop_", date, " - 04 Case Information.csv", sep = "")]
  #} else {
  #  z <- y$id[y$name == paste("DOH COVID Data Drop_ ", date, " - 04 Case Information.csv", sep = "")]
  #}
  z <- y$id[stringr::str_detect(string = y$name, pattern = "Case Information.csv")]
  #googlesheets4::sheets_deauth()
  #cases <- googlesheets4::sheets_read(ss = z)
  cases <- read.csv(sprintf(fmt = "https://docs.google.com/uc?id=%s&export=download", z))
  cases <- tibble::tibble(cases)
  return(cases)
}



