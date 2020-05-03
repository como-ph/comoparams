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

  ## Input working from home intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    hand <- menu(choices = c("Yes", "No"),
                 title = "Has working from home intervention been implemented?")
    cat("\n")

    if(work == 1) {
      ## Set work variable as TRUE
      work <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input working from home parameters
      cat("\n")
      cat("When was working from home intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of working from home
        date_work_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_work_on, quiet = TRUE))){
          cat("\n")
          cat("Working from home starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_work_on) %within% startEnd) {
            cat("\n")
            cat("Working from home starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_work_on, quiet = TRUE))) {
          if(lubridate::dmy(date_work_on) %within% startEnd) break
        }
      }

      ## Input duration of working from home
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the working from home intervention for?\n")
      cat("\n")
      repeat {
        ## Working from home duration
        work_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that working from home duration is in correct format
        if(is.na(work_dur) | work_dur == "") {
          cat("\n")
          cat("Duration of working from home intervention should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = work_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of working from home should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(work_dur) <= 0) {
              cat("\n")
              cat("Duration of working from home cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(work_dur) > 52) {
              cat("\n")
              cat("Duration of working from home cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = work_dur, pattern = "[0-9]")) {
          if(as.numeric(work_dur) > 0 &
             as.numeric(work_dur) <= 52) break
        }
      }

      ## Input working from home coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of working from home coverage?\n")
      cat("\n")
      repeat {
        ## Working from home coverage
        work_cov <- readline(prompt = "Coverage of working from home (numeric; %): ")

        ## Check that working from home coverage is in correct format
        if(is.na(work_cov) | work_cov == "") {
          cat("\n")
          cat("Working from home coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = work_cov, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Coverage of working from home should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(work_cov) <= 0) {
              cat("\n")
              cat("Coverage of working from home cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(work_cov) > 100) {
              cat("\n")
              cat("Coverage of working from home cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = work_cov, pattern = "[0-9]")) {
          if(as.numeric(work_cov) > 0 &
             as.numeric(work_cov) <= 100) break
        }
      }

      ## Input working from home adherence
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of working from home adherence?\n")
      cat("\n")
      repeat {
        ## Working from home adherence
        work_eff <- readline(prompt = "Adherence to working from home (numeric; %): ")

        ## Check that working from home adherence is in correct format
        if(is.na(work_eff) | work_eff == "") {
          cat("\n")
          cat("Working from home adherence should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = work_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Adherence to working from home should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(work_eff) <= 0) {
              cat("\n")
              cat("Adherence to working from home cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(work_eff) > 100) {
              cat("\n")
              cat("Adherence to working from home cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = work_eff, pattern = "[0-9]")) {
          if(as.numeric(work_eff) > 0 &
             as.numeric(work_eff) <= 100) break
        }
      }

      ## Input for home contacts inflation
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How much should home contacts be inflated due to work from home?\n")
      cat("\n")
      repeat {
        ## Home contacts inflation
        w2h <- readline(prompt = "Home contacts inflation (numeric; %): ")

        ## Check that home contacts inflation is in correct format
        if(is.na(w2h) | w2h == "") {
          cat("\n")
          cat("Home contacts inflation should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = w2h, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Home contacts inflation should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(w2h) <= 0) {
              cat("\n")
              cat("Home contacts inflation cannot be 0 or less. Try again.\n")
              cat("\n")
            }
            if(as.numeric(w2h) > 100) {
              cat("\n")
              cat("Home contacts inflation cannot be greater than 10. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = w2h, pattern = "[0-9]")) {
          if(as.numeric(w2h) > 0 &
             as.numeric(w2h) <= 10) break
        }
      }
    } else {
      ## Set params to NA
      work <- FALSE
      work_hand_on <- NA
      work_dur <- NA
      work_cov <- NA
      work_eff <- NA
      w2h <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Concatenate params
  params <- list(work, work_hand_on, work_dur, work_cov, work_eff, w2h)
  names(param) <- c("work", "work_hand_on", "work_dur", "work_cov", "work_eff", "w2h")

  ## Return params
  return(params)
}




