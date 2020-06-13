################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation lockdown intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model lockdown intervention
#' parameters
#'
#' @examples
#' if(interactive()) ph_set_lockdown()
#'
#' @export
#'
#
################################################################################

ph_set_lockdown <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling LOCKDOWN intervention parameters for the Philippines\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input lockdown information
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    lockdown <- menu(choices = c("Yes", "No"),
                     title = "Has lockdown been implemented?")

    if(lockdown == 1) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      repeat {
        ## Type of lockdown
        lockdown_level <- menu(choices = c("Low", "Mid", "High"),
                               title = "Select level of lockdown that has been implemented?")

        ## Check of appropriate lockdown level chosen
        if(as.numeric(lockdown_level) %in% 1:3) break
      }

      ## Input start date of lockdown

      ## Calculate comparison values
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("When was lockdown started?\n")
      cat("\n")
      repeat {
        ## Start date of lockdown
        lockdown_start <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(lockdown_start, quiet = TRUE))){
          cat("\n")
          cat("Lockdown starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
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

      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is lockdown for?\n")
      cat("\n")
      repeat{
        ## Duration of lockdown
        lockdown_duration <- readline(prompt = "Lockdown duration (weeks): ")

        ## Check that lockdown duration is in correct format
        if(stringr::str_detect(string = lockdown_duration, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Duration of lockdown should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(lockdown_duration) <= 0) {
            cat("\n")
            cat("Duration of lockdown cannot be 0 weeks or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(lockdown_duration) > 52) {
            cat("\n")
            cat("Duration of lockdown cannot be greater than 52 weeks. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to nsxt
        if(stringr::str_detect(string = lockdown_duration, pattern = "[0-9]")) {
          if(as.numeric(lockdown_duration) > 0 &
             as.numeric(lockdown_duration) <= 52) break
        }
      }

      ## Assign inputs to appropriate variables

      ## Lockdown low
      if(lockdown_level == 1) {
        lockdown_low_switch  <- TRUE
        date_lockdown_low_on <- lockdown_start
        lockdown_low_dur     <- lockdown_duration
      } else {
        lockdown_low_switch  <- FALSE
        date_lockdown_low_on <- NA
        lockdown_low_dur     <- NA
      }

      ## Lockdown mid
      if(lockdown_level == 2) {
        lockdown_mid_switch  <- TRUE
        date_lockdown_mid_on <- lockdown_start
        lockdown_mid_dur     <- lockdown_duration
      } else {
        lockdown_mid_switch  <- FALSE
        date_lockdown_mid_on <- NA
        lockdown_mid_dur     <- NA
      }

      ## Lockdown high
      if(lockdown_level == 3) {
        lockdown_high_switch  <- TRUE
        date_lockdown_high_on <- lockdown_start
        lockdown_high_dur     <- lockdown_duration
      } else {
        lockdown_high_switch  <- FALSE
        date_lockdown_high_on <- NA
        lockdown_high_dur     <- NA
      }
    } else {
      lockdown_low_switch   <- NA
      date_lockdown_low_on  <- NA
      lockdown_low_dur      <- NA
      lockdown_mid_switch   <- NA
      date_lockdown_mid_on  <- NA
      lockdown_mid_dur      <- NA
      lockdown_high_switch  <- NA
      date_lockdown_high_on <- NA
      lockdown_high_dur     <- NA
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("LOCKDOWN intervention has NOT been implemented yet. Proceed to next intervention.\n")
      cat("\n")
    }
  } else {
    lockdown_low_switch   <- NA
    date_lockdown_low_on  <- NA
    lockdown_low_dur      <- NA
    lockdown_mid_switch   <- NA
    date_lockdown_mid_on  <- NA
    lockdown_mid_dur      <- NA
    lockdown_high_switch  <- NA
    date_lockdown_high_on <- NA
    lockdown_high_dur     <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("LOCKDOWN intervention parameters have NOT been set.\n")
    cat("\n")
  }

  if(all(!is.na(c(lockdown_low_switch, date_lockdown_low_on, lockdown_low_dur)) |
         !is.na(c(lockdown_mid_switch, date_lockdown_mid_on, lockdown_mid_dur)) |
         !is.na(c(lockdown_high_switch, date_lockdown_high_on, lockdown_high_dur)))) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("LOCKDOWN intervention parameters have been set. Proceed to next intervention.\n")
    cat("\n")
  }

  ## Concatenate params
  params <- list(lockdown_low_switch, date_lockdown_low_on, as.numeric(lockdown_low_dur),
                 lockdown_mid_switch, date_lockdown_mid_on, as.numeric(lockdown_mid_dur),
                 lockdown_high_switch, date_lockdown_high_on, as.numeric(lockdown_high_dur))

  ## Rename list elements
  names(params) <- c("lockdown_low_switch", "date_lockdown_low_on", "lockdown_low_dur",
                     "lockdown_mid_switch", "date_lockdown_mid_on", "lockdown_mid_dur",
                     "lockdown_high_switch", "date_lockdown_high_on", "lockdown_high_dur")

  ## Return params
  return(params)
}




