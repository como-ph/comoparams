################################################################################
#
#'
#' Retrieve CoMo parameters template
#'
#' @return A list of 9 elements for each of the worksheets in the CoMo
#'   parameters template
#'
#' @examples
#' get_como_template()
#'
#' @export
#'
#
################################################################################

get_como_template <- function() {
  ##
  template <- tempfile()
  ## Retrieve template XLSX and assign to system file
  utils::download.file(url = "https://github.com/ocelhay/como/raw/master/Template_CoMoCOVID-19App.xlsx",
                       destfile = template)
  ##
  params <- list()
  paramsSet <- openxlsx::getSheetNames(file = template)
  ##
  for(i in paramsSet) {
    params[[i]] <- openxlsx::read.xlsx(xlsxFile = "https://github.com/ocelhay/como/raw/master/Template_CoMoCOVID-19App.xlsx",
                                       sheet = i,
                                       detectDates = TRUE)
  }
  ##
  return(params)
}

como_template <- get_como_template()

usethis::use_data(como_template, internal = TRUE, overwrite = TRUE, compress = "xz")



