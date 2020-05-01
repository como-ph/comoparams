################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation intervention parameters
#'
#' @return A list of Philippines-specific CoMo model intervention parameters
#'
#' @examples
#' if(interactive()) ph_set_interevention()
#'
#' @export
#'
#
################################################################################

ph_set_intervention <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling intervention parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")
  ##
  if(set_params == 2) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Input start date of simulation
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("3. Starting date of simulation (DD/MM/YYYY format)\n")
    cat("\n")

    ## Calculate comparison values
    intStart <- lubridate::ymd("2019-12-01")
    intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
    startEnd <- interval(start = intStart, end = intEnd)

    repeat {
      ## Start date of simulation
      date_range_simul_start <- readline(prompt = "Start date (DD/MM/YYYY): ")

      ## Check if date is in correct format
      if(is.na(lubridate::dmy(date_range_simul_start, quiet = TRUE))) {
        cat("\n")
        cat("Starting date is not in DD/MM/YYYY format. Try again.\n")
        cat("\n")
      } else {
        ## Check if date is within plausible starting date for simulation
        if(!lubridate::dmy(date_range_simul_start) %within% startEnd) {
          cat("\n")
          cat("Starting date is not within plausible dates for simulation. Try again.\n")
          cat("\n")
        }
      }

      ## Check if date is in correct format and plausible
      if(!is.na(lubridate::dmy(date_range_simul_start, quiet = TRUE))) {
        if(lubridate::dmy(date_range_simul_start) %within% startEnd) break
      }
    }
  }

  ## Input end date of simulation
  if(!is.null(date_range_simul_start) | !is.na(date_range_simul_start)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("4. Ending date of simulation (DD/MM/YYYY format)\n")
    cat("\n")

    ## Calculate comparison values
    intStart <- lubridate::ymd("2019-12-01")
    intEnd <- lubridate::ymd(Sys.Date())
    startEnd <- interval(start = intStart, end = intEnd)

    repeat {
      ## Start date of simulation
      date_range_simul_end <- readline(prompt = "End date (DD/MM/YYYY): ")

      ## Check if date is in correct format
      if(is.na(lubridate::dmy(date_range_simul_end, quiet = TRUE))) {
        cat("\n")
        cat("Ending date is not in DD/MM/YYYY format. Try again.\n")
        cat("\n")
      } else {
        ## Check if date is within plausible ending date for simulation
        if(lubridate::dmy(date_range_simul_end) %within% startEnd) {
          cat("\n")
          cat("Ending date should be beyond current date. Try again.\n")
          cat("\n")
        }
      }

      ## Check if date is in correct format and plausible
      if(!is.na(lubridate::dmy(date_range_simul_end, quiet = TRUE))) {
        if(!lubridate::dmy(date_range_simul_end) %within% startEnd) break
      }
    }
  }

  ## Input probability of infection given contact
  if(!is.null(date_range_simul_end) | !is.na(date_range_simul_end)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("5. Probability of infection given contact\n")
    cat("\n")

    repeat {
      ## Probability of infection given contact
      p <- readline(prompt = "Probability of infection (numeric; proportion): ")

      ## Check that p is in correct format (numeric)
      if(stringr::str_detect(string = p, pattern = "[a-zA-Z]|%")) {
        cat("\n")
        cat("Probability of infection (p) should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(p) <= 0) {
          cat("\n")
          cat("Probability of infection (p) cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(p) >= 1 ) {
          cat("\n")
          cat("Probability of infection (p) cannot be 1 or more. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = p, pattern = "[0-9]")) {
        if(as.numeric(p) > 0 &
           as.numeric(p) < 1) break
      }
    }
  }

  ## Concatenate params
  params <- list()

  ## Return params
  return(params)
}




