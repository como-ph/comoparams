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
  ## Retrieve template XLSX and assign to system file
  utils::download.file(url = "https://github.com/ocelhay/como/raw/master/Template_CoMoCOVID-19App.xlsx",
                       destfile = paste(tempdir(), "/template.xlsx", sep = ""))
  ##
  params <- list()
  paramsSet <- openxlsx::getSheetNames(file = paste(tempdir(),
                                                    "/template.xlsx",
                                                    sep = ""))
  ##
  for(i in paramsSet) {
    params[[i]] <- openxlsx::read.xlsx(xlsxFile = paste(tempdir(),
                                                        "/template.xlsx",
                                                        sep = ""),
                                       sheet = i)
  }
  ##
  return(params)
}



