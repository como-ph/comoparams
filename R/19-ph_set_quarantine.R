################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation voluntary home quarantine
#' intervention parameters
#'
#' @return A list of Philippines-specific CoMo model voluntary home quarantine
#' intervention parameters
#'
#' @examples
#' if(interactive()) ph_set_quarantine()
#'
#' @export
#'
#
################################################################################

ph_set_quarantine <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling VOLUNTARY HOME QUARANTINE intervention parameters for the Philippines\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input voluntary home quarantine intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    quarantine <- menu(choices = c("Yes", "No"),
                       title = "Has voluntary home quarantine intervention been implemented?")
    cat("\n")

    if(quarantine == 1) {
      ## Set quarantine variable as TRUE
      quarantine <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input voluntary home quarantine parameters
      cat("\n")
      cat("When was voluntary home quarantine intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of voluntary home quarantine
        date_quarantine_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_quarantine_on, quiet = TRUE))){
          cat("\n")
          cat("Voluntary home quarantine starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_quarantine_on) %within% startEnd) {
            cat("\n")
            cat("Voluntary home quarantine starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_quarantine_on, quiet = TRUE))) {
          if(lubridate::dmy(date_quarantine_on) %within% startEnd) break
        }
      }

      ## Input duration of voluntary home quarantine
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the voluntary home quarantine for?\n")
      cat("\n")
      repeat {
        ## Voluntary home quarantine duration
        quarantine_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that voluntary home quarantine duration is in correct format
        if(is.na(quarantine_dur) | quarantine_dur == "") {
          cat("\n")
          cat("Duration of voluntary home quarantine intervention should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = quarantine_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of voluntary home quarantine should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(quarantine_dur) <= 0) {
              cat("\n")
              cat("Duration of voluntary home quarantine cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(quarantine_dur) > 52) {
              cat("\n")
              cat("Duration of voluntary home quarantine cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = quarantine_dur, pattern = "[0-9]")) {
          if(as.numeric(quarantine_dur) > 0 &
             as.numeric(quarantine_dur) <= 52) break
        }
      }

      ## Input days in isolation/quarantine for average person
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How many days of voluntary home quarantine for average person?\n")
      cat("\n")
      repeat {
        ## Number of days of voluntary home quarantine
        quarantine_days <- readline(prompt = "Number of days of quarantine (numeric; days): ")

        ## Check that voluntary home quarantine days is in correct format
        if(is.na(quarantine_days) | quarantine_days == "") {
          cat("\n")
          cat("Number of days of voluntary home quarantine should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = quarantine_days, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Number of days of voluntary home quarantine should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(quarantine_days) <= 0) {
              cat("\n")
              cat("Number of days of voluntary home quarantine cannot be 0 days or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(quarantine_days) > 21) {
              cat("\n")
              cat("Number of days of voluntary home quarantine cannot be greater than 21 days. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = quarantine_days, pattern = "[0-9]")) {
          if(as.numeric(quarantine_days) > 0 &
             as.numeric(quarantine_days) <= 21) break
        }
      }

      ## Input voluntary home quarantine coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of voluntary home quarantine coverage?\n")
      cat("\n")
      repeat {
        ## Voluntary home quarantine coverage
        quarantine_cov <- readline(prompt = "Coverage of voluntary home quarantine (numeric; %): ")

        ## Check that voluntary home quarantine is in correct format
        if(is.na(quarantine_cov) | quarantine_cov == "") {
          cat("\n")
          cat("Voluntary home quarantine coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = quarantine_cov, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Coverage of voluntary home quarantine should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(quarantine_cov) <= 0) {
              cat("\n")
              cat("Coverage of voluntary home quarantine cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(quarantine_cov) > 100) {
              cat("\n")
              cat("Coverage of voluntary home quarantine cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = quarantine_cov, pattern = "[0-9]")) {
          if(as.numeric(quarantine_cov) > 0 &
             as.numeric(quarantine_cov) <= 100) break
        }
      }

      ## Input days to implement maximum quarantine coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How many days taken to implement maximum quarantine coverage?\n")
      cat("\n")
      repeat {
        ## Number of days of effort to reach maximum quarantine coverage
        quarantine_effort <- readline(prompt = "Number of days to reach maximum quarantine coverage (numeric; days): ")

        ## Check that number of days to reach maximum quarantine coverage is in correct format
        if(is.na(quarantine_effort) | quarantine_effort == "") {
          cat("\n")
          cat("Number of days to reach maximum quarantine coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = quarantine_effort, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Number of days to reach maximum quarantine coverage should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(quarantine_effort) <= 0) {
              cat("\n")
              cat("Number of days to reach maximum quarantine coverage cannot be 0 days or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(quarantine_effort) > 5) {
              cat("\n")
              cat("Number of days to reach maximum quarantine coverage cannot be greater than 5 days. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = quarantine_effort, pattern = "[0-9]")) {
          if(as.numeric(quarantine_effort) > 0 &
             as.numeric(quarantine_effort) <= 5) break
        }
      }

      ## Input voluntary home quarantine efficacy
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the percentage of decrease in the the number of other contacts when quarantined?\n")
      cat("\n")
      repeat {
        ## Decrease in the number of other contacts when quarantined
        quarantine_eff_other <- readline(prompt = "Decrease in other contacts (numeric; %): ")

        ## Check that decrease in other contacts is in correct format
        if(is.na(quarantine_eff_other) | quarantine_eff_other == "") {
          cat("\n")
          cat("Decrease in other contacts should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = quarantine_eff_other, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Decrease in other contacts should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(quarantine_eff_other) <= 0) {
              cat("\n")
              cat("Decrease in other contacts cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(quarantine_eff_other) > 100) {
              cat("\n")
              cat("Decrease in other contacts cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = quarantine_eff_other, pattern = "[0-9]")) {
          if(as.numeric(quarantine_eff_other) > 0 &
             as.numeric(quarantine_eff_other) <= 100) break
        }
      }

      ## Input for increase in home contacts
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the percentage of increase in the the number of home contacts when quarantined?\n")
      cat("\n")
      repeat {
        ## Home contacts inflation
        quarantine_eff_home <- readline(prompt = "Increase in home contacts (numeric; %): ")

        ## Check that increase in home contacts is in correct format
        if(is.na(quarantine_eff_home) | quarantine_eff_home == "") {
          cat("\n")
          cat("Increase in home contacts should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = quarantine_eff_home, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Increase in home contacts should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(quarantine_eff_home) <= 0) {
              cat("\n")
              cat("Increase in home contacts cannot be 0 or less. Try again.\n")
              cat("\n")
            }
            if(as.numeric(quarantine_eff_home) > 100) {
              cat("\n")
              cat("Increase in home contacts cannot be greater than 100. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = quarantine_eff_home, pattern = "[0-9]")) {
          if(as.numeric(quarantine_eff_home) > 0 &
             as.numeric(quarantine_eff_home) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      quarantine           <- FALSE
      date_quarantine_on   <- NA
      quarantine_dur       <- NA
      quarantine_days      <- NA
      quarantine_cov       <- NA
      quarantine_effort    <- NA
      quarantine_eff_other <- NA
      quarantine_eff_home  <- NA
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("VOLUNTARY HOME QUARANTINE intervention has not been implemented yet. Proceed to next intervention.\n")
      cat("\n")
    }
  } else {
    ## Set params to NA
    quarantine           <- FALSE
    date_quarantine_on   <- NA
    quarantine_dur       <- NA
    quarantine_days      <- NA
    quarantine_cov       <- NA
    quarantine_effort    <- NA
    quarantine_eff_other <- NA
    quarantine_eff_home  <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("VOLUNTARY HOME QUARANTINE intervention parameters have NOT been set.\n")
    cat("\n")
  }

  ##
  if(all(!is.na(c(quarantine, date_quarantine_on, quarantine_dur, quarantine_days,
                  quarantine_cov, quarantine_effort, quarantine_eff_other,
                  quarantine_eff_home)))) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("VOLUNTARY HOME QUARANTINE intervention parameters have been set. Proceed to next intervention\n")
    cat("\n")
  }

  ## Concatenate params
  params <- list(quarantine, date_quarantine_on, as.numeric(quarantine_dur),
                 as.numeric(quarantine_days), as.numeric(quarantine_cov),
                 as.numeric(quarantine_effort), as.numeric(quarantine_eff_other),
                 as.numeric(quarantine_eff_home))

  ##
  names(params) <- c("quarantine", "date_quarantine_on", "quarantine_dur", "quarantine_days",
                     "quarantine_cov", "quarantine_effort", "quarantine_eff_other",
                     "quarantine_eff_home")

  ## Return params
  return(params)
}




