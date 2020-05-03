################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation vaccination intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model vaccination intervention
#' parameters
#'
#' @examples
#' if(interactive()) ph_set_vaccination()
#'
#' @export
#'
#
################################################################################

ph_set_vaccination <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling vaccination intervention parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input vaccination intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    vaccine <- menu(choices = c("Yes", "No"),
                 title = "Has vaccination intervention been implemented?")
    cat("\n")

    if(vaccine == 1) {
      ## Set dist variable as TRUE
      vaccine <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input vaccination parameters
      cat("\n")
      cat("When was vaccination intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of vaccination
        date_vaccine_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_vaccine_on, quiet = TRUE))){
          cat("\n")
          cat("Vaccination starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_vaccine_on) %within% startEnd) {
            cat("\n")
            cat("Vaccination starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_vaccine_on, quiet = TRUE))) {
          if(lubridate::dmy(date_vaccine_on) %within% startEnd) break
        }
      }

      ## Input time to reach target coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How many weeks did it take to reach target vaccination coverage?\n")
      cat("\n")
      repeat {
        ## Weeks to target coverage
        vac_campaign <- readline(prompt = "Duration (weeks): ")

        ## Check that weeks to target coverage is in correct format
        if(is.na(vac_campaign) | vac_campaign == "") {
          cat("\n")
          cat("Number of weeks to target coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = vac_campaign, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Number of weeks to target coverage should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(vac_campaign) <= 0) {
              cat("\n")
              cat("Number of weeks to target coverage cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(vac_campaign) > 52) {
              cat("\n")
              cat("Number of weeks to target coverage cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = vac_campaign, pattern = "[0-9]")) {
          if(as.numeric(vac_campaign) > 0 &
             as.numeric(vac_campaign) <= 52) break
        }
      }

      ## Input vaccination coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of vaccination coverage reached?\n")
      cat("\n")
      repeat {
        ## Vaccination coverage
        vaccine_cov <- readline(prompt = "Coverage of vaccination (numeric; %): ")

        ## Check that vaccination coverage is in correct format
        if(is.na(vaccine_cov) | vaccine_cov == "") {
          cat("\n")
          cat("Vaccination coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = vaccine_cov, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Vaccinataion coverage should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(vaccine_cov) <= 0) {
              cat("\n")
              cat("Vaccination coverage cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(vaccine_cov) > 100) {
              cat("\n")
              cat("Vaccination coverage cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = vaccine_cov, pattern = "[0-9]")) {
          if(as.numeric(vaccine_cov) > 0 &
             as.numeric(vaccine_cov) <= 100) break
        }
      }

      ## Input vaccination efficacy
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the efficacy of vaccination?\n")
      cat("\n")
      repeat {
        ## Vaccination efficacy
        vaccine_eff <- readline(prompt = "Efficacy of vaccination (numeric; %): ")

        ## Check that vaccination efficacy is in correct format
        if(is.na(vaccine_eff) | vaccine_eff == "") {
          cat("\n")
          cat("Vaccine efficacy should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = vaccine_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Vaccine efficacy should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(vaccine_eff) <= 0) {
              cat("\n")
              cat("Vaccine efficacy cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(vaccine_eff) > 100) {
              cat("\n")
              cat("Vaccine efficacy cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = vaccine_eff, pattern = "[0-9]")) {
          if(as.numeric(vaccine_eff) > 0 &
             as.numeric(vaccine_eff) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      vaccine <- FALSE
      date_vaccine_on <- NA
      vac_campaign <- NA
      vaccine_cov <- NA
      vaccine_eff <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Concatenate params
  params <- list(vaccine, data_vaccine_on, vac_campaign, vaccine_cov, vaccine_eff)
  names(params) <- c("vaccine", "data_vaccine_on", "vac_campaign", "vaccine_cov", "vaccine_eff")

  ## Return params
  return(params)
}




