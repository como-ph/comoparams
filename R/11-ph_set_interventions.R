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

  ## Input lockdown information
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    lockdown <- menu(choices = c("Yes", "No"),
                     title = "Has lockdown been implemented?")
    cat("\n")

    if(lockdown == 1) {
      repeat {
        ## Type of lockdown
        lockdown_level <- menu(choices = c("Low", "Mid", "High"),
                               title = "Select level of lockdown that has been implemented?")

        ## Check of appropriate lockdown level chosen
        if(as.numeric(lockdown_level) %in% 1:3) break
      }

        ## Calculate comparison values
        intStart <- lubridate::ymd("2019-12-01")
        intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
        startEnd <- interval(start = intStart, end = intEnd)

      repeat {
        ## Start date of lockdown
        lockdown_start <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Duration of lockdown
        lockdown_duration <- readline(prompt = "Duration (weeks): ")

        ## Check if date provided is within plausible range of dates
        if(is.na(lubridate::dmy(lockdown_start, quiet = TRUE))){
          cat("\n")
          cat("Lockdown starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible starting date for simulation
          if(!lubridate::dmy(lockdown_start) %within% startEnd) {
            cat("\n")
            cat("Lockdown starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(lockdown_start, quiet = TRUE))) {
          if(lubridate::dmy(lockdown_start) %within% startEnd) break
        }
      }

      ## Assign inputs to appropriate variables

      ## Lockdown low
      if(lockdown_level == 1) {
        lockdown_low_switch <- TRUE
        date_lockdown_low_on <- lockdown_start
        lockdown_low_dur <- lockdown_duration
      } else {
        lockdown_low_switch <- FALSE
        date_lockdown_low_on <- NA
        lockdown_low_dur <- NA
      }

      ## Lockdown mid
      if(lockdown_level == 2) {
        lockdown_mid_switch <- TRUE
        date_lockdown_mid_on <- lockdown_start
        lockdown_mid_dur <- lockdown_duration
      } else {
        lockdown_mid_switch <- FALSE
        date_lockdown_mid_on <- NA
        lockdown_mid_dur <- NA
      }

      ## Lockdown high
      if(lockdown_level == 3) {
        lockdown_high_switch <- TRUE
        date_lockdown_high_on <- lockdown_start
        lockdown_high_dur <- lockdown_duration
      } else {
        lockdown_high_switch <- FALSE
        date_lockdown_high_on <- NA
        lockdown_high_dur <- NA
      }
    }

    ##
  }

  ## Concatenate params
  params <- list(lockdown_low_switch, date_lockdown_low_on, lockdown_low_dur,
                 lockdown_mid_switch, date_lockdown_mid_on, lockdown_mid_dur,
                 lockdown_high_switch, date_lockdown_high_on, lockdown_high_dur)

  ## Return params
  return(params)
}




