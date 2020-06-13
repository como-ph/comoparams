################################################################################
#
#'
#' Output cases and severity-mortality input tables compatible with CoMo
#' template
#'
#' @param params A list of parameters produced using the \code{ph_set_params()}
#'   function
#' @param path Directory to save output to. Defaults to current working
#'   directory
#'
#' @return An XLSX workbook with 10 worksheets for various sets of parameters
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

ph_create_params <- function(params, path = ".") {
  ##
  xxx <- como_template
  ## Template
  template <- openxlsx::createWorkbook()

  ## Add Instructions worksheet
  openxlsx::addWorksheet(wb = template, sheetName = "Instructions")
  openxlsx::writeData(wb = template, sheet = "Instructions", x = como_template[[1]])

  ## Add Cases worksheet
  openxlsx::addWorksheet(wb = template, sheetName = "Cases")
  openxlsx::writeData(wb = template, sheet = "Cases", x = params[[1]])

  ## Add Severity-Mortality worksheet
  openxlsx::addWorksheet(wb = template, sheetName = "Severity-Mortality")
  openxlsx::writeData(wb = template, sheet = "Severity-Mortality", x = params[[2]][ , c(1, 6:7)])

  ## Add Population worksheet
  openxlsx::addWorksheet(wb = template, sheetName = "Population")
  openxlsx::writeData(wb = template, sheet = "Population", x = params[[3]])

  ## Enter values for Parameters worksheet
  xxx[[5]][1, 2]   <- params[[4]]$date_range_simul_start
  xxx[[5]][2, 2]   <- params[[4]]$date_range_simul_end
  xxx[[5]][4:7, 3] <- c(params[[4]]$p,
                        params[[4]]$report,
                        params[[4]]$reportc,
                        params[[4]]$reporth)

  openxlsx::addWorksheet(wb = template, sheetName = "Parameters")
  openxlsx::writeData(wb = template, sheet = "Parameters", x = xxx[[5]])

  ## Enter values for Country Area Parameters worksheet
  xxx[[6]][2 ,2]   <- params[[4]]$country
  xxx[[6]][3:4, 3] <- c(params[[4]]$household_size,
                        params[[4]]$mean_imports)

  openxlsx::addWorksheet(wb = template, sheetName = "Country Area Parameters")
  openxlsx::writeData(wb = template, sheet = "Country Area Parameters", x = xxx[[6]])

  ## Enter values for Virus Parameters worksheet
  xxx[[7]][2:10, 2] <- unlist(params[[5]])

  openxlsx::addWorksheet(wb = template, sheetName = "Virus Parameters")
  openxlsx::writeData(wb = template, sheet = "Virus Parameters", x = xxx[[7]])

  ## Enter values for Hospitalisation Parameters worksheet
  xxx[[8]][2:18, 2] <- unlist(params[[6]])

  openxlsx::addWorksheet(wb = template, sheetName = "Hospitalisation Parameters")
  openxlsx::writeData(wb = template, sheet = "Hospitalisation Parameters", x = xxx[[8]])

  ## Enter values for Interventions worksheet
  xxx[[9]][c(2, 5, 8), 3]  <- unlist(params[[7]][[1]][c(1, 4, 7)])
  xxx[[9]][c(11, 16), 3]   <- unlist(params[[7]][[2]][c(1, 6)])
  xxx[[9]][22, 3]          <- unlist(params[[7]][[3]][1])
  xxx[[9]][27, 3]          <- unlist(params[[7]][[4]][1])
  xxx[[9]][31, 3]          <- unlist(params[[7]][[5]][1])
  xxx[[9]][37, 3]          <- unlist(params[[7]][[6]][1])
  xxx[[9]][42, 3]          <- unlist(params[[7]][[7]][1])
  xxx[[9]][48, 3]          <- unlist(params[[7]][[8]][1])
  xxx[[9]][52, 3]          <- unlist(params[[7]][[9]][1])
  xxx[[9]][60, 3]          <- unlist(params[[7]][[10]][1])

  xxx[[9]][c(3, 6, 9), 4]  <- unlist(params[[7]][[1]][c(2, 5, 8)])
  xxx[[9]][c(12, 17), 4]   <- unlist(params[[7]][[2]][c(2, 7)])
  xxx[[9]][23, 4]          <- unlist(params[[7]][[3]][2])
  xxx[[9]][28, 4]          <- unlist(params[[7]][[4]][2])
  xxx[[9]][32, 4]          <- unlist(params[[7]][[5]][2])
  xxx[[9]][38, 4]          <- unlist(params[[7]][[6]][2])
  xxx[[9]][43, 4]          <- unlist(params[[7]][[7]][2])
  xxx[[9]][49, 4]          <- unlist(params[[7]][[8]][2])
  xxx[[9]][53, 4]          <- unlist(params[[7]][[9]][2])
  xxx[[9]][61, 4]          <- unlist(params[[7]][[10]][2])

  xxx[[9]][c(4, 7, 10), 5]     <- unlist(params[[7]][[1]][c(3, 6, 9)])
  xxx[[9]][c(13:15, 18:21), 5] <- unlist(params[[7]][[2]][c(3:5, 8:11)])
  xxx[[9]][24:26, 5]           <- unlist(params[[7]][[3]][3:5])
  xxx[[9]][29:30, 5]           <- unlist(params[[7]][[4]][3:4])
  xxx[[9]][33:36, 5]           <- unlist(params[[7]][[5]][3:6])
  xxx[[9]][39:41, 5]           <- unlist(params[[7]][[6]][3:5])
  xxx[[9]][44:47, 5]           <- unlist(params[[7]][[7]][3:6])
  xxx[[9]][50:51, 5]           <- unlist(params[[7]][[8]][3:4])
  xxx[[9]][54:59, 5]           <- unlist(params[[7]][[9]][3:8])
  xxx[[9]][62:64, 5]           <- unlist(params[[7]][[10]][3:5])

  openxlsx::addWorksheet(wb = template, sheetName = "Interventions")
  openxlsx::writeData(wb = template, sheet = "Interventions", x = xxx[[9]])

  ## Output XLSX workbook
  openxlsx::saveWorkbook(wb = template,
                         file = paste(path, "Template_CoMo-PH.xlsx", sep = "/"))

  ##
  return(template)
}
