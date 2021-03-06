################################################################################
#
#'
#' R Utility Tool to Extract, Process and Structure Philippines-specific Datasets
#' for Use in CoMo Consortium Model
#'
#' The Oxford Modelling Group for Global Health (OMGH) is developing model
#' structures to estimate the impact of potential mitigation strategies. By
#' changing the input data and parameter values, the models can be adjusted to
#' represent a national or subnational setting. In addition, a user friendly
#' application and interface is being developed to enable widespread utility.
#' This package supports in the processing of respective national and/or
#' subnational input data and parameter values into data structures appropriate
#' for use with the modelling application and/or other packages developed for
#' this purpose.
#'
#' @docType package
#' @name comoparams
#' @keywords internal
#' @importFrom googledrive drive_deauth drive_get drive_ls drive_download as_id
#' @importFrom stringr str_remove_all str_replace_all str_to_title
#' @importFrom stats aggregate prop.test t.test
#' @importFrom magrittr %>%
#' @importFrom tibble tibble
#' @importFrom dplyr select
#' @importFrom utils read.csv tail download.file menu
#' @importFrom lubridate %within% interval ymd ymd_hms year dmy days mdy
#'   is.Date parse_date_time month
#' @importFrom openxlsx read.xlsx createWorkbook addWorksheet writeData
#'   saveWorkbook getSheetNames
#' @importFrom tidyr pivot_longer
#' @importFrom RCurl getURL
#' @importFrom pdftools pdf_text
#' @importFrom cli cli_h1 col_red col_blue symbol cli_text cli_alert_warning
#'   col_yellow cli_alert_danger cli_alert_success cli_h2 cli_h3
#'
#'
#
################################################################################
"_PACKAGE"

if(getRversion() >= "2.15.1")  utils::globalVariables(c("births_wpp_2019",
                                                        "deaths_wpp_2019",
                                                        "population_wpp_2019"))
