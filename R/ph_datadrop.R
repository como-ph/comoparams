################################################################################
#
#' Pull Philippines data fields information from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to the googlesheets4 read_sheet() function to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Sheets
#'
#' @return A tibble
#'
#' @examples
#' ph_get_fields()
#'
#' @export
#'
#
################################################################################

ph_get_fields <- function() {
  googlesheets4::sheets_deauth()
  fields <- googlesheets4::sheets_read(ss = "1BLbrvgjkBWxr9g73xX9DLOqmbmuYyKc-_b8jIxCX1uo",
                                       sheet = "Metadata - Fields")
  return(fields)
}


################################################################################
#
#' Pull Philippines data on cases information from the publicly available
#' Department of Health COVID-19 Data Drop
#'
#' A wrapper to the googlesheets4 read_sheet() function to pull data from the
#' Philppines' COVID-19 Data Drop resource that is publicly distributed via
#' Google Sheets
#'
#' @return A tibble
#'
#' @examples
#' ph_get_cases()
#'
#' @export
#'
#
################################################################################

ph_get_cases <- function() {
  googlesheets4::sheets_deauth()
  cases <- googlesheets4::sheets_read(ss = "1BLbrvgjkBWxr9g73xX9DLOqmbmuYyKc-_b8jIxCX1uo",
                                      sheet = "Case Information")
  return(cases)
}


