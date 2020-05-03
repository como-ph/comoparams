################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation travel ban intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model travel ban intervention
#' parameters
#'
#' @examples
#' if(interactive()) ph_set_travel()
#'
#' @export
#'
#
################################################################################

ph_set_travel <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling travel ban intervention parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input travel ban intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    tavel <- menu(choices = c("Yes", "No"),
                  title = "Has travel ban been implemented?")
    cat("\n")

    if(travel == 1) {
      ## Set travel variable as TRUE
      travel <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input travel ban parameters
      cat("\n")
      cat("When was travel ban intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of travel ban
        date_travelban_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_travelban_on, quiet = TRUE))){
          cat("\n")
          cat("Travel ban starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_travelban_on) %within% startEnd) {
            cat("\n")
            cat("Travel ban starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_travelban_on, quiet = TRUE))) {
          if(lubridate::dmy(date_travelban_on) %within% startEnd) break
        }
      }

      ## Input duration of travel ban
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the travel ban intervention for?\n")
      cat("\n")
      repeat {
        ## Travel ban duration
        travelban_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that travel ban duration is in correct format
        if(is.na(travelban_dur) | travelban_dur == "") {
          cat("\n")
          cat("Duration of travel ban intervention should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = travelban_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of travel ban should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(travelban_dur) <= 0) {
              cat("\n")
              cat("Duration of travel ban cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(travelban_dur) > 52) {
              cat("\n")
              cat("Duration of travel ban cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = travelban_dur, pattern = "[0-9]")) {
          if(as.numeric(travelban_dur) > 0 &
             as.numeric(travelban_dur) <= 52) break
        }
      }

      ## Input travel ban efficacy
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of travel ban efficacy?\n")
      cat("\n")
      repeat {
        ## Travel ban efficacy
        travelban_eff <- readline(prompt = "Efficacy of travel ban (numeric; %): ")

        ## Check that travel ban efficacy is in correct format
        if(is.na(travelban_eff) | travelban_eff == "") {
          cat("\n")
          cat("Travel ban efficacy should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = travelban_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Travel ban efficacy should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(travelban_eff) <= 0) {
              cat("\n")
              cat("Travel ban efficacy cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(travelban_eff) > 100) {
              cat("\n")
              cat("Travel ban efficacy cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = travelban_eff, pattern = "[0-9]")) {
          if(as.numeric(travelban_eff) > 0 &
             as.numeric(travelban_eff) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      travel <- FALSE
      date_travelban_on <- NA
      travelban_dur <- NA
      travelban_eff <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Concatenate params
  params <- list(travel, date_travelban_on, travelban_dur, travelban_eff)
  names(param) <- c("travel", "date_travelban_on", "travelban_dur", "travelban_eff")

  ## Return params
  return(params)
}




