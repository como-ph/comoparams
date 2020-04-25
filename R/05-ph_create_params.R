################################################################################
#
#'
#' Output cases and severity-mortality input tables compatible with CoMo
#' template
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#' @param path Directory to save output to
#'
#' @return An XLSX workbook with 2 worksheets for cases and severity-mortality
#'   formatted according to the CoMo template
#'
#' @examples
#' \dontrun{
#'   ph_create_params()
#' }
#'
#' @export
#'
#
################################################################################

ph_create_params <- function(date = Sys.Date(),
                             path = "") {
  ## Calculate daily cases
  cases <- ph_calculate_cases(date = date)
  names(cases) <- c("date",
                   "Number of reported cases per day",
                   "Number of deaths per day")
  ## Calculate ifr and ihr
  severity_mortality <- ph_calculate_rates(date = date)[ , c(1, 6:7)]
  ## Create XLSX workbook
  comoparams <- openxlsx::createWorkbook()
  openxlsx::addWorksheet(wb = comoparams,
                         sheetName = "Cases")
  openxlsx::addWorksheet(wb = comoparams,
                         sheetName = "Severity-Mortality")
  ## Save data onto XLSX workbook
  openxlsx::writeData(wb = comoparams,
                      sheet = "Cases",
                      x = cases)
  openxlsx::writeData(wb = comoparams,
                      sheet = "Severity-Mortality",
                      x = severity_mortality)
  ## Output XLSX workbook
  openxlsx::saveWorkbook(wb = comoparams,
                         file = paste(path, "Template_CoMo-PH.xlsx", sep = "/"))
}
