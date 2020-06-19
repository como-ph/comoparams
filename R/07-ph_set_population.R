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
    pop <- population_wpp_2019

    ##
    birth <- births_wpp_2019

    ##
    death <- deaths_wpp_2019

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
