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

    ## Input self-isolation intervention parameters
    if(lockdown == 2 | !is.null(lockdown_duration) | !is.na(lockdown_duration)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      selfis <- menu(choices = c("Yes", "No"),
                      title = "Has self-isolation of symptomatics been implemented?")
      cat("\n")

      if(selfis == 1) {
        ## Calculate comparison values
        intStart <- lubridate::ymd("2019-12-01")
        intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
        startEnd <- interval(start = intStart, end = intEnd)

        ## Input date_selfis_on
        cat("\n")
        cat("================================================================================\n")
        cat("\n")
        cat("When was self-isolation intervention started?\n")
        cat("\n")
        repeat {
          ## Start date of self-isolation
          date_selfis_on <- readline(prompt = "Start date (DD/MM/YYY): ")

          ## Check if date provided is in correct format
          if(is.na(lubridate::dmy(date_selfis_on, quiet = TRUE))){
            cat("\n")
            cat("Self-isolation starting date is not in DD/MM/YYYY format. Try again.\n")
            cat("\n")
          } else {
            ## Check if date is within plausible range of dates
            if(!lubridate::dmy(date_selfis_on) %within% startEnd) {
              cat("\n")
              cat("Lockdown starting date is not within plausible dates. Try again.\n")
              cat("\n")
            }
          }

          ## Check if date is in correct format and plausible
          if(!is.na(lubridate::dmy(date_selfis_on, quiet = TRUE))) {
            if(lubridate::dmy(date_selfis_on) %within% startEnd) break
          }
        }

        ## Input duration of self-isolation
        cat("\n")
        cat("================================================================================\n")
        cat("\n")
        cat("How long is the self-isolation intervention for?\n")
        cat("\n")
        repeat {
          ## Self-isolation duration
          selfis_dur <- readline(prompt = "Duration (weeks): ")

          ## Check that self-isolation duration is in correct format
          if(stringr::str_detect(string = selfis_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of self-isolation should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(selfis_dur) <= 0) {
              cat("\n")
              cat("Duration of self-isolation cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(selfis_dur) > 52) {
              cat("\n")
              cat("Duration of self-isolation cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = selfis_dur, pattern = "[0-9]")) {
            if(as.numeric(selfis_dur) > 0 &
               as.numeric(selfis_dur) <= 52) break
          }
        }

        ## Input self-isolation coverage
        cat("\n")
        cat("================================================================================\n")
        cat("\n")
        cat("What is the level of self-isolation coverage?\n")
        cat("\n")
        repeat {
          ## Self-isolation coverage
          selfis_cov <- readline(prompt = "Coverage of self-isolation (numeric; %): ")

          ## Check that self-isolation coverage is in correct format
          if(stringr::str_detect(string = selfis_cov, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Coverage of self-isolation should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(selfis_cov) <= 0) {
              cat("\n")
              cat("Coverage of self-isolation cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(selfis_cov) > 100) {
              cat("\n")
              cat("Coverage of self-isolation cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = selfis_cov, pattern = "[0-9]")) {
            if(as.numeric(selfis_cov) > 0 &
               as.numeric(selfis_cov) <= 100) break
          }
        }

        ## Input self-isolation adherence
        cat("\n")
        cat("================================================================================\n")
        cat("\n")
        cat("What is the level of self-isolation adherence?\n")
        cat("\n")
        repeat {
          ## Self-isolation adherence
          selfis_eff <- readline(prompt = "Adherence to self-isolation (numeric; %): ")

          ## Check that self-isolation adherence is in correct format
          if(stringr::str_detect(string = selfis_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Adherence to self-isolation should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(selfis_eff) <= 0) {
              cat("\n")
              cat("Adherence to self-isolation cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(selfis_eff) > 100) {
              cat("\n")
              cat("Adherence to self-isolation cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = selfis_eff, pattern = "[0-9]")) {
            if(as.numeric(selfis_eff) > 0 &
               as.numeric(selfis_eff) <= 100) break
          }
        }

        ## Input for screening
        cat("\n")
        cat("================================================================================\n")
        cat("\n")
        screen_switch <- menu(choices = c("Yes", "No"),
                              title = "Is screening for cases conducted?")
        cat("\n")

        if(screen_switch == 1) {
          ## Input start date for screening
          cat("\n")
          cat("================================================================================\n")
          cat("\n")
          cat("When did screening for cases start?\n")
          cat("\n")

          ## Calculate comparison values
          intStart <- lubridate::ymd("2019-12-01")
          intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
          startEnd <- interval(start = intStart, end = intEnd)

          repeat {
            date_screen_on <- readline(prompt = "Start date (DD/MM/YYY): ")

            ## Check if date provided is in correct format
            if(is.na(lubridate::dmy(date_screen_on, quiet = TRUE))){
              cat("\n")
              cat("Screening starting date is not in DD/MM/YYYY format. Try again.\n")
              cat("\n")
            } else {
              ## Check if date is within plausible range of dates
              if(!lubridate::dmy(date_screen_on) %within% startEnd) {
                cat("\n")
                cat("Screening starting date is not within plausible dates. Try again.\n")
                cat("\n")
              }
            }

            ## Check if date is in correct format and plausible
            if(!is.na(lubridate::dmy(date_screen_on, quiet = TRUE))) {
              if(lubridate::dmy(date_screen_on) %within% startEnd) break
            }
          }

          ## Input screen coverage
          cat("\n")
          cat("================================================================================\n")
          cat("\n")
          cat("What is the level of screening coverage?\n")
          cat("\n")
          repeat {
            ## screening coverage
            screen_cov <- readline(prompt = "Coverage of screening (numeric; %): ")

            ## Check that screening coverage is in correct format
            if(stringr::str_detect(string = screen_cov, pattern = "[a-zA-Z]")) {
              cat("\n")
              cat("Coverage of screening should be numeric. Try again.\n")
              cat("\n")
            } else {
              if(as.numeric(screen_cov) <= 0) {
                cat("\n")
                cat("Coverage of screening cannot be 0% or less. Try again.\n")
                cat("/n")
              }
              if(as.numeric(screen_cov) > 100) {
                cat("\n")
                cat("Coverage of screening cannot be greater than 100%. Try again.\n")
                cat("\n")
              }
            }

            ## If in correct format, go to next
            if(stringr::str_detect(string = screen_cov, pattern = "[0-9]")) {
              if(as.numeric(screen_cov) > 0 &
                 as.numeric(screen_cov) <= 100) break
            }
          }

          ## Input screening duration
          cat("\n")
          cat("================================================================================\n")
          cat("\n")
          cat("How long is the screening of cases for?\n")
          cat("\n")
          repeat {
            ## Screening duration
            screen_dur <- readline(prompt = "Duration (weeks): ")

            ## Check that screening duration is in correct format
            if(stringr::str_detect(string = screen_dur, pattern = "[a-zA-Z]")) {
              cat("\n")
              cat("Duration of screening should be numeric. Try again.\n")
              cat("\n")
            } else {
              if(as.numeric(screen_dur) <= 0) {
                cat("\n")
                cat("Duration of screening cannot be 0 weeks or less. Try again.\n")
                cat("/n")
              }
              if(as.numeric(screen_dur) > 52) {
                cat("\n")
                cat("Duration of screening cannot be greater than 52 weeks. Try again.\n")
                cat("\n")
              }
            }
          }

          ## Input for screening overdispersion
          cat("\n")
          cat("================================================================================\n")
          cat("\n")
          cat("How much is the level of screening overdispersion?\n")
          cat("\n")
          repeat {
            ## Screening overdispersion
            screen_overdispersion <- readline(prompt = "Screening overdispersion (numeric; 1-5): ")

            ## Check that screening overdispersion is in correct format
            if(stringr::str_detect(string = screen_overdispersion, pattern = "[a-zA-Z]")) {
              cat("\n")
              cat("Screening overdispersion should be numeric. Try again.\n")
              cat("\n")
            } else {
              if(as.numeric(screen_overdispersion) <= 0) {
                cat("\n")
                cat("Screening overdispersion cannot be 0 or less. Try again.\n")
                cat("\n")
              }
              if(as.numeric(screen_overdispersion) > 5) {
                cat("\n")
                cat("Screening overdispersion cannot be greater than 5. Try again.\n")
                cat("\n")
              }
            }
          }

          ## Input for number of screening contacts
          cat("\n")
          cat("================================================================================\n")
          cat("\n")
          cat("How many screening contacts?\n")
          cat("\n")
          repeat {
            ## Screening contacts
            screen_contacts <- readline(prompt = "Screening contacts (numeric; 1-10): ")

            ## Check that screening contacts is in correct format
            if(stringr::str_detect(string = screen_contacts, pattern = "[a-zA-Z]")) {
              cat("\n")
              cat("Screening contacts should be numeric. Try again.\n")
              cat("\n")
            } else {
              if(as.numeric(screen_contacts) <= 0) {
                cat("\n")
                cat("Screening contacts cannot be 0 or less. Try again.\n")
                cat("\n")
              }
              if(as.numeric(screen_contacts) > 10) {
                cat("\n")
                cat("Screening contacts cannot be greater than 10. Try again.\n")
                cat("\n")
              }
            }
          }
        }
      }
    }

    ## Input social distancing intervention parameters
    if(selfis == 2 | !is.null(screen_contacts) | !is.na(screen_contacts)) {

    }
  }

  ## Concatenate params
  params <- list(lockdown_low_switch, date_lockdown_low_on, lockdown_low_dur,
                 lockdown_mid_switch, date_lockdown_mid_on, lockdown_mid_dur,
                 lockdown_high_switch, date_lockdown_high_on, lockdown_high_dur,
                 date_selfis_on, selfis_dur, selfis_cov, selfis_eff,
                 screen_switch, date_screen_on, screen_cov, screen_dur,
                 screen_overdispersion, screen_contacts)

  ## Return params
  return(params)
}




