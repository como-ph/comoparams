################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation for shielding the elderly
#' intervention parameters
#'
#' @return A list of Philippines-specific CoMo model shielding the elderly
#' intervention parameters
#'
#' @examples
#' if(interactive()) ph_set_cocoon()
#'
#' @export
#'
#
################################################################################

ph_set_cocoon <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling shielding the elderly intervention parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input working from home intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    work <- menu(choices = c("Yes", "No"),
                 title = "Has shielding the elderly intervention been implemented?")
    cat("\n")

    if(cocoon == 1) {
      ## Set cocoon variable as TRUE
      cocoon <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input shielding the elderly parameters
      cat("\n")
      cat("When was the shielding the elderly intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of shielding the elderly intervention
        date_cocoon_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_cocoon_on, quiet = TRUE))){
          cat("\n")
          cat("Shielding the elderly starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_cocoon_on) %within% startEnd) {
            cat("\n")
            cat("Shielding the elderly starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_cocoon_on, quiet = TRUE))) {
          if(lubridate::dmy(date_cocoon_on) %within% startEnd) break
        }
      }

      ## Input duration of shielding the elderly
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the shielding the elderly intervention for?\n")
      cat("\n")
      repeat {
        ## Shielding the elderly duration
        cocoon_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that shielding the elderly duration is in correct format
        if(is.na(cocoon_dur) | cocoon_dur == "") {
          cat("\n")
          cat("Duration of shielding the elderly intervention should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = cocoon_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of shielding the elderly should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(cocoon_dur) <= 0) {
              cat("\n")
              cat("Duration of shielding the elderly cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(cocoon_dur) > 52) {
              cat("\n")
              cat("Duration of shielding the elderly cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = cocoon_dur, pattern = "[0-9]")) {
          if(as.numeric(cocoon_dur) > 0 &
             as.numeric(cocoon_dur) <= 52) break
        }
      }

      ## Input shielding the elderly coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of shielding the elderl coverage?\n")
      cat("\n")
      repeat {
        ## Shielding the eldearly coverage
        cocoon_cov <- readline(prompt = "Coverage of shielding the elderly (numeric; %): ")

        ## Check that shielding the elderly coverage is in correct format
        if(is.na(cocoon_cov) | cocoon_cov == "") {
          cat("\n")
          cat("Shielding the elderly coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = cocoon_cov, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Coverage of shielding the elderly should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(cocoon_cov) <= 0) {
              cat("\n")
              cat("Coverage of shielding the elderly cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(cocoon_cov) > 100) {
              cat("\n")
              cat("Coverage of shielding the elderly cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = cocoon_cov, pattern = "[0-9]")) {
          if(as.numeric(cocoon_cov) > 0 &
             as.numeric(cocoon_cov) <= 100) break
        }
      }

      ## Input shielding the elderly efficacy
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of shielding the elderly efficacy?\n")
      cat("\n")
      repeat {
        ## Shielding the elderly efficacy
        cocoon_eff <- readline(prompt = "Efficacy of shielding the elderly (numeric; %): ")

        ## Check that shielding the elderly efficacy is in correct format
        if(is.na(cocoon_eff) | cocoon_eff == "") {
          cat("\n")
          cat("Shielding the elderly efficacy should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = cocoon_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Shielding the elderly efficacy should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(cocoon_eff) <= 0) {
              cat("\n")
              cat("Shielding the elderly efficacy cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(cocoon_eff) > 100) {
              cat("\n")
              cat("Shielding the elderly efficacy cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = cocoon_eff, pattern = "[0-9]")) {
          if(as.numeric(cocoon_eff) > 0 &
             as.numeric(cocoon_eff) <= 100) break
        }
      }

      ## Input for minimum age for shielding the elderly intervention
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the minimum age for shielding the elderly?\n")
      cat("\n")
      repeat {
        ## Minimum age for shielding the elderly
        age_cocoon <- readline(prompt = "Minimum age (numeric): ")

        ## Check that minimum age for shielding the elderly is in correct format
        if(is.na(age_cocoon) | age_cocoon == "") {
          cat("\n")
          cat("Minimum age for shielding the elderly should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = age_cocoon, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Minimum age for shielding the elderly should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(age_cocoon) < 50) {
              cat("\n")
              cat("Minimum age for shielding the elderly cannot be less than 50. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = age_cocoon, pattern = "[0-9]")) {
          if(as.numeric(age_cocoon) > 0 &
             as.numeric(age_cocoon) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      cocoon <- FALSE
      date_cocoon_on <- NA
      cocoon_dur <- NA
      cocoon_cov <- NA
      cocoon_eff <- NA
      age_cocoon <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Concatenate params
  params <- list(cocoon, date_cocoon_on, cocoon_dur, cocoon_cov, cocoon_eff, age_cocoon)
  names(param) <- c("cocoon", "date_cocoon_on", "cocoon_dur", "cocoon_cov", "cocoon_eff", "age_cocoon")

  ## Return params
  return(params)
}




