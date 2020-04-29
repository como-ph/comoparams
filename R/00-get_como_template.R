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
  download.file(url = "https://github.com/ocelhay/como/raw/master/Template_CoMoCOVID-19App.xlsx",
                destfile = template)
  ##
  params <- list()
  paramsSet <- openxlsx::getSheetNames(file = template)
  ##
  for(i in paramsSet) {
    params[[i]] <- openxlsx::read.xlsx(xlsxFile = template, sheet = i)
  }
  ##
  return(params)
}



