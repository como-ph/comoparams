################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation self-isolation intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model self-isolation intervention
#'   parameters
#'
#' @examples
#' if(interactive()) ph_set_household()
#'
#' @export
#'
#
################################################################################

ph_set_household <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling SELF-ISOLATION intervention parameters for the Philippines\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input self-isolation information
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    selfis <- menu(choices = c("Yes", "No"),
                   title = "Has self-isolation of symptomatics been implemented?")

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
            cat("Self-isolation starting date is not within plausible dates. Try again.\n")
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

        ##
        if(is.na(selfis_dur) | selfis_dur == "") {
          cat("\n")
          cat("Duration of self-isolation should be provided. Try again.\n")
          cat("\n")
        } else {
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
        if(is.na(selfis_cov) | selfis_cov == "") {
          cat("\n")
          cat("Coverage of self-isolation should be provided. Try again.\n")
          cat("\n")
        } else {
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
        if(is.na(selfis_eff) | selfis_eff == "") {
          cat("\n")
          cat("Adherence of self-isolation should be provided. Try again.\n")
          cat("\n")
        } else {
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
          if(is.na(screen_cov) | screen_cov == "") {
            cat("\n")
            cat("Coverage of screening should be provided. Try again.\n")
            cat("\n")
          } else {
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
          if(is.na(screen_dur) | screen_dur == "") {
            cat("\n")
            cat("Duration of screening should be provided. Try again.\n")
            cat("\n")
          } else {
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

          ## If in correct format, go to next
          if(stringr::str_detect(string = screen_dur, pattern = "[0-9]")) {
            if(as.numeric(screen_dur) > 0 &
               as.numeric(screen_dur) <= 52) break
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
          if(is.na(screen_overdispersion) | screen_overdispersion == "") {
            cat("\n")
            cat("Screening overdispersion should be provided. Try again.\n")
            cat("\n")
          } else {
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

          ## If in correct format, go to next
          if(stringr::str_detect(string = screen_overdispersion, pattern = "[0-9]")) {
            if(as.numeric(screen_overdispersion) > 0 &
               as.numeric(screen_overdispersion) <= 5) break
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
          if(is.na(screen_contacts) | screen_contacts == "") {
            cat("\n")
            cat("Screening contacts should be provided. Try again.\n")
            cat("\n")
          } else {
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

          ## If in correct format, go to next
          if(stringr::str_detect(string = screen_contacts, pattern = "[0-9]")) {
            if(as.numeric(screen_contacts) > 0 &
               as.numeric(screen_contacts) <= 10) break
          }
        }
      } else {
        ## set screening params to NA
        date_screen_on        <- NA
        screen_cov            <- NA
        screen_dur            <- NA
        screen_overdispersion <- NA
        screen_contacts       <- NA
      }
    } else {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("SELF-ISOLATION intervention parameters have NOT been set.\n")
      cat("\n")
      ## set params to NA
      selfis                <- FALSE
      date_selfis_on        <- NA
      selfis_dur            <- NA
      selfis_cov            <- NA
      selfis_eff            <- NA
      screen_switch         <- NA
      date_screen_on        <- NA
      screen_cov            <- NA
      screen_dur            <- NA
      screen_overdispersion <- NA
      screen_contacts       <- NA
    }
  } else {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("SELF-ISOLATION intervention has NOT been implemented yet. Proceed to next intervention.\n")
    cat("\n")
    ## set params to NA
    selfis                <- FALSE
    date_selfis_on        <- NA
    selfis_dur            <- NA
    selfis_cov            <- NA
    selfis_eff            <- NA
    screen_switch         <- NA
    date_screen_on        <- NA
    screen_cov            <- NA
    screen_dur            <- NA
    screen_overdispersion <- NA
    screen_contacts       <- NA
  }

  if(all(!is.na(c(selfis, date_selfis_on, selfis_dur, selfis_cov, selfis_eff,
                  screen_switch, date_screen_on, screen_cov, screen_dur,
                  screen_overdispersion, screen_contacts)))) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("SELF-ISOLATION intervention parameters have been set. Proceed to next intervention.\n")
    cat("\n")
  }

  ## Concatenate params
  params <- list(selfis, date_selfis_on, as.numeric(selfis_dur), as.numeric(selfis_cov),
                 as.numeric(selfis_eff), screen_switch, date_screen_on,
                 as.numeric(screen_cov), as.numeric(screen_dur),
                 as.numeric(screen_overdispersion), as.numeric(screen_contacts))

  ##
  names(params) <- list("selfis", "date_selfis_on", "selfis_dur", "selfis_cov", "selfis_eff",
                        "screen_switch", "date_screen_on", "screen_cov",
                        "screen_dur", "screen_overdispersion", "screen_contacts")

  ## Return params
  return(params)
}

