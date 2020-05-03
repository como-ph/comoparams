################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation handwashing intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model handwashing intervention
#'   parameters
#'
#' @examples
#' if(interactive()) ph_set_handwashing()
#'
#' @export
#'
#
################################################################################

ph_set_handwashing <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling handwashing intervention parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input handwashing intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    hand <- menu(choices = c("Yes", "No"),
                 title = "Has handwashing intervention been implemented?")
    cat("\n")

    if(hand == 1) {
      ## Set hand variable as TRUE
      hand <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input social distancing parameters
      cat("\n")
      cat("When was handwashing intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of handwashing
        date_hand_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_hand_on, quiet = TRUE))){
          cat("\n")
          cat("Handwashing starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_hand_on) %within% startEnd) {
            cat("\n")
            cat("Handwashing starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_hand_on, quiet = TRUE))) {
          if(lubridate::dmy(date_hand_on) %within% startEnd) break
        }
      }

      ## Input duration of handwashing
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the handwashing intervention for?\n")
      cat("\n")
      repeat {
        ## Handwashing duration
        hand_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that handwahsing duration is in correct format
        if(is.na(hand_dur) | hand_dur == "") {
          cat("\n")
          cat("Duration of handwashing interventions should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = hand_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of handwashing should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(hand_dur) <= 0) {
              cat("\n")
              cat("Duration of handwashing cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(hand_dur) > 52) {
              cat("\n")
              cat("Duration of handwashing cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = hand_dur, pattern = "[0-9]")) {
          if(as.numeric(hand_dur) > 0 &
             as.numeric(hand_dur) <= 52) break
        }
      }

      ## Input handwashing adherence
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of handwashing adherence?\n")
      cat("\n")
      repeat {
        ## Handwashing adherence
        hand_eff <- readline(prompt = "Adherence to handwashing (numeric; %): ")

        ## Check that handwashing adherence is in correct format
        if(is.na(hand_eff) | hand_eff == "") {
          cat("\n")
          cat("Handwashing adherence should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = hand_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Adherence to handwashing should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(hand_eff) <= 0) {
              cat("\n")
              cat("Adherence to handwashing cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(hand_eff) > 100) {
              cat("\n")
              cat("Adherence to handwashing cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = hand_eff, pattern = "[0-9]")) {
          if(as.numeric(hand_eff) > 0 &
             as.numeric(hand_eff) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      hand <- FALSE
      date_hand_on <- NA
      hand_dur <- NA
      hand_eff <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    return(cat("Thank you for using comoparams!\n"))
  }

  ## Concatenate params
  params <- list(hand, date_hand_on, hand_dur, hand_eff)
  names(param) <- c("hand", "date_hand_on", "hand_dur", "hand_deff")

  ## Return params
  return(params)
}




