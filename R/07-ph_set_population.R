################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for population
#'
#' @return A data.frame of Philippines-specific CoMo model parameters for
#'   population
#'
#' @examples
#' if(interactive()) ph_set_population()
#'
#' @export
#'
#
################################################################################

ph_set_population <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling POPULATION parameters for the Philippines\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("Reading population data...")

    ##
    pop <- ph_get_wpp2019_pop(file = "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_PopulationByAgeSex_Medium.csv")

    ##
    birth <- ph_get_wpp2019_births(file = "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/EXCEL_FILES/2_Fertility/WPP2019_FERT_F06_BIRTHS_BY_AGE_OF_MOTHER.xlsx",
                                   period = 2019)

    ##
    death <- ph_get_wpp2019_deaths(file = "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/EXCEL_FILES/3_Mortality/WPP2019_MORT_F04_1_DEATHS_BY_AGE_BOTH_SEXES.xlsx",
                                   period = 2019)

    ##
    pop <- data.frame(pop[ , c("area", "year", "age_category", "total")],
                      birth[ , "birth"],
                      death[ , "death"],
                      stringsAsFactors = FALSE)
    ##
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("POPULATION parameters have been set. Proceed to next parameter.\n")
    cat("\n")
  } else {
    pop <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("POPULATION parameters have NOT been set.\n")
    cat("\n")
  }

  ##
  return(pop)
}
