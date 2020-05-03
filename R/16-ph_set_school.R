################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation schools closure intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model school clostures
#' intervention parameters
#'
#' @examples
#' if(interactive()) ph_set_school()
#'
#' @export
#'
#
################################################################################

ph_set_school <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling schools closure intervention parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input schools closure intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    school <- menu(choices = c("Yes", "No"),
                   title = "Has schools closure been implemented?")
    cat("\n")

    if(school == 1) {
      ## Set work variable as TRUE
      school <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input schools closure parameters
      cat("\n")
      cat("When was schools closure intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of schools closure
        date_school_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_school_on, quiet = TRUE))){
          cat("\n")
          cat("Schools closure starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_school_on) %within% startEnd) {
            cat("\n")
            cat("Schools closure starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_school_on, quiet = TRUE))) {
          if(lubridate::dmy(date_school_on) %within% startEnd) break
        }
      }

      ## Input duration of schools closure
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the schools closure intervention for?\n")
      cat("\n")
      repeat {
        ## Schools closure intervention duration
        school_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that schools closure duration is in correct format
        if(is.na(school_dur) | school_dur == "") {
          cat("\n")
          cat("Duration of schools closure intervention should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = school_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of schools closure should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(school_dur) <= 0) {
              cat("\n")
              cat("Duration of schools closure cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(school_dur) > 52) {
              cat("\n")
              cat("Duration of schools closure cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = school_dur, pattern = "[0-9]")) {
          if(as.numeric(school_dur) > 0 &
             as.numeric(school_dur) <= 52) break
        }
      }

      ## Input schools closure efficacy
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of schools closure efficacy?\n")
      cat("\n")
      repeat {
        ## Schools closure efficacy
        school_eff <- readline(prompt = "Efficacy of schools closure (numeric; %): ")

        ## Check that schools closure efficacy is in correct format
        if(is.na(school_eff) | school_eff == "") {
          cat("\n")
          cat("Schools closure efficacy should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = school_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Schools closure efficacy should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(school_eff) <= 0) {
              cat("\n")
              cat("Schools closure efficacy cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(school_eff) > 100) {
              cat("\n")
              cat("Schools closure efficacy cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = school_eff, pattern = "[0-9]")) {
          if(as.numeric(school_eff) > 0 &
             as.numeric(school_eff) <= 100) break
        }
      }

      ## Input for home contacts inflation
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How much should home contacts be inflated due to schoos closure?\n")
      cat("\n")
      repeat {
        ## Home contacts inflation
        s2h <- readline(prompt = "Home contacts inflation (numeric; %): ")

        ## Check that home contacts inflation is in correct format
        if(is.na(s2h) | s2h == "") {
          cat("\n")
          cat("Home contacts inflation should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = s2h, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Home contacts inflation should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(s2h) <= 0) {
              cat("\n")
              cat("Home contacts inflation cannot be 0 or less. Try again.\n")
              cat("\n")
            }
            if(as.numeric(s2h) > 100) {
              cat("\n")
              cat("Home contacts inflation cannot be greater than 100. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = s2h, pattern = "[0-9]")) {
          if(as.numeric(s2h) > 0 &
             as.numeric(s2h) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      school <- FALSE
      date_school_on <- NA
      school_dur <- NA
      school_eff <- NA
      s2h <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Concatenate params
  params <- list(school, date_school_on, school_dur, school_eff, s2h)
  names(param) <- c("school", "date_school_on", "school_dur", "school_cov", "school_eff", "s2h")

  ## Return params
  return(params)
}




