################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for severity of
#' cases and mortality
#'
#' @return A data.frame of Philippines-specific CoMo model parameters for
#'   severity of cases and mortality
#'
#' @examples
#' if(interactive()) ph_set_severe()
#'
#' @export
#'
#
################################################################################

ph_set_severe <- function() {
  ## Check current date and time to see what date is the most recently
  ## available cases data
  #if(lubridate::now(tzone = "UTC") %within%
  #   lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(),
  #                                                "12:00:00 UTC",
  #                                                sep = "")),
  #                       lubridate::ymd_hms(paste(Sys.Date(),
  #                                                "23:59:59 UTC",
  #                                                sep = "")))) {
  #  refDate <- Sys.Date()
  #} else {
  #  refDate <- lubridate::ymd(Sys.Date()) - lubridate::days(1)
  #}

  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling SEVERITY and MORTALITY parameters for the Philippines\n")
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
    cat("Calculating severity and mortality...")

    ##
    #sm <- ph_calculate_rates(date = refDate)
    sm <- ph_get_cases() %>% ph_calculate_cases()

    ##
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("SEVERITY and MORTALITY parameters have been set. Proceed to next parameter.\n")
    cat("\n")
  } else {
    cases <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("SEVERITY and MORTALITY parameters have NOT been set.\n")
    cat("\n")
  }

  ##
  return(sm)
}
