################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for COVID-19 cases
#'
#' @return A data.frame of Philippines-specific CoMo model parameters for
#'   COVID-19 cases
#'
#' @examples
#' if(interactive()) ph_set_cases()
#'
#' @export
#'
#
################################################################################

ph_set_cases <- function() {
  ## Check current date and time to see what date is the most recently
  ## available cases data
  if(lubridate::now(tzone = "UTC") %within%
     lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(),
                                                  "12:00:00 UTC",
                                                  sep = "")),
                         lubridate::ymd_hms(paste(Sys.Date(),
                                                  "23:59:59 UTC",
                                                  sep = "")))) {
    refDate <- Sys.Date()
  } else {
    refDate <- lubridate::ymd(Sys.Date()) - lubridate::days(1)
  }

  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling CASES parameters for the Philippines\n")
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
    cat("Calculating cases...")

    ##
    cases <- ph_calculate_cases(date = refDate)

    ##
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("CASES parameters have been set. Proceed to next parameter.\n")
    cat("\n")
  } else {
    cases <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("CASES parameters have NOT been set.\n")
    cat("\n")
  }

  ##
  return(cases)
}
