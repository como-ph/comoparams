################################################################################
#
#'
#' Interactive guidance for setting Philppines-specific CoMo model parameters
#'
#' @return A list of Philippines-specific CoMo model parameters
#'
#' @examples
#' if(interactive()) ph_set_params()
#'
#' @export
#'
#
################################################################################

ph_set_params <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling parameters for the Philippines")
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

  ##
  country <- ifelse(set_params == 1, "Philippines", NULL)
  ## Input mean household size
  if(!is.null(country)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat(paste("1. What is the mean household size in ", country, "/area of ", country, "?\n", sep = ""))
    cat("\n")
    repeat {
      ## Household size prompts
      household_size <- readline(prompt = "Enter mean household size (numeric): ")

      ## Check that household_size is in correct format
      if(stringr::str_detect(string = household_size, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Mean household size should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(household_size) < 1) {
          cat("\n")
          cat("Mean household size cannot be less than 1. Try again.\n")
          cat("\n")
        }
        if(as.numeric(household_size) > 9) {
          cat("\n")
          cat("Mean household size cannot be more than 9. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = household_size, pattern = "[0-9]")) {
        if(as.numeric(household_size) >= 1 &
           as.numeric(household_size) <= 9) break
      }
    }
  }

  ## Input mean number of infectious migrants per day
  if(!is.null(household_size) | !is.na(household_size)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat(paste("2. What is the mean number of infectious migrants per day in ", country, "/area of ", country, "?\n", sep = ""))
    cat("\n")
    repeat {
      ## Mean imports prompt
      mean_imports <- readline(prompt = "Mean number of infectious migrants per day (numeric): ")

      ## Check that mean_imports is in correct format
      if(stringr::str_detect(string = mean_imports, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Mean imports should be numeric. Try again.\n")
        cat("\n")
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = mean_imports, pattern = "[0-9]")) break
    }
  }

  ## Input start date of simulation
  if(!is.null(mean_imports) | !is.na(mean_imports)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("3. Starting date of simulation (DD/MM/YYYY format)\n")
    cat("\n")

    ## Calculate comparison values
    intStart <- lubridate::ymd("2019-12-01")
    intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
    startEnd <- interval(start = intStart, end = intEnd)

    repeat {
      ## Start date of simulation
      date_range_simul_start <- readline(prompt = "Start date (DD/MM/YYYY): ")

      ## Check if date is in correct format
      if(is.na(lubridate::dmy(date_range_simul_start, quiet = TRUE))) {
        cat("\n")
        cat("Starting date is not in DD/MM/YYYY format. Try again.\n")
        cat("\n")
      } else {
        ## Check if date is within plausible starting date for simulation
        if(!lubridate::dmy(date_range_simul_start) %within% startEnd) {
          cat("\n")
          cat("Starting date is not within plausible dates for simulation. Try again.\n")
          cat("\n")
        }
      }

      ## Check if date is in correct format and plausible
      if(!is.na(lubridate::dmy(date_range_simul_start, quiet = TRUE))) {
        if(lubridate::dmy(date_range_simul_start) %within% startEnd) break
      }
    }
  }

  ## Input end date of simulation
  if(!is.null(date_range_simul_start) | !is.na(date_range_simul_start)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("4. Ending date of simulation (DD/MM/YYYY format)\n")
    cat("\n")

    ## Calculate comparison values
    intStart <- lubridate::ymd("2019-12-01")
    intEnd <- lubridate::ymd(Sys.Date())
    startEnd <- interval(start = intStart, end = intEnd)

    repeat {
      ## Start date of simulation
      date_range_simul_end <- readline(prompt = "End date (DD/MM/YYYY): ")

      ## Check if date is in correct format
      if(is.na(lubridate::dmy(date_range_simul_end, quiet = TRUE))) {
        cat("\n")
        cat("Ending date is not in DD/MM/YYYY format. Try again.\n")
        cat("\n")
      } else {
        ## Check if date is within plausible ending date for simulation
        if(lubridate::dmy(date_range_simul_end) %within% startEnd) {
          cat("\n")
          cat("Ending date should be beyond current date. Try again.\n")
          cat("\n")
        }
      }

      ## Check if date is in correct format and plausible
      if(!is.na(lubridate::dmy(date_range_simul_end, quiet = TRUE))) {
        if(!lubridate::dmy(date_range_simul_end) %within% startEnd) break
      }
    }
  }

  ## Input probability of infection given contact
  if(!is.null(date_range_simul_end) | !is.na(date_range_simul_end)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("5. Probability of infection given contact\n")
    cat("\n")

    repeat {
      ## Probability of infection given contact
      p <- readline(prompt = "Probability of infection (numeric; proportion): ")

      ## Check that p is in correct format (numeric)
      if(stringr::str_detect(string = p, pattern = "[a-zA-Z]|%")) {
        cat("\n")
        cat("Probability of infection (p) should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(p) <= 0) {
          cat("\n")
          cat("Probability of infection (p) cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(p) >= 1 ) {
          cat("\n")
          cat("Probability of infection (p) cannot be 1 or more. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = p, pattern = "[0-9]")) {
        if(as.numeric(p) > 0 &
           as.numeric(p) < 1) break
      }
    }
  }

  ## Input percentage of all asymptomatic infections that are reported
  if(!is.null(p) | !is.na(p)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("5. Percentage of all asymptomatic infections that are reported\n")
    cat("\n")

    repeat {
      ## Percentage of all asymptomatic infections that are reported
      report <- readline(prompt = "Percentage of asymptomatic infections (numeric; %): ")

      ## Check that report is in correct format (numeric)
      if(stringr::str_detect(string = report, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Percentage of asymptomatic infections should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(report) <= 0) {
          cat("\n")
          cat("Percentage of asymptomatic infections cannot be 0% or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(report) >= 100 ) {
          cat("\n")
          cat("Percentage of asymptomatic infection cannot be 100% or more. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = report, pattern = "[0-9]")) {
        if(as.numeric(report) > 0 &
           as.numeric(report) < 100) break
      }
    }
  }

  ## Input percentage of all symptomatic infections that are reported
  if(!is.null(report) | !is.na(report)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("6. Percentage of all symptomatic infections that are reported\n")
    cat("\n")

    repeat {
      ## Percentage of all symptomatic infections that are reported
      reportc <- readline(prompt = "Percentage of symptomatic infections (numeric; %): ")

      ## Check that reportc is in correct format (numeric)
      if(stringr::str_detect(string = reportc, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Percentage of symptomatic infections should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(reportc) <= 0) {
          cat("\n")
          cat("Percentage of symptomatic infections cannot be 0% or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(reportc) >= 100 ) {
          cat("\n")
          cat("Percentage of symptomatic infections cannot be 100% or more. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = reportc, pattern = "[0-9]")) {
        if(as.numeric(reportc) > 0 &
           as.numeric(reportc) < 100) break
      }
    }
  }

  ## Input percentage of all hospitalisations that are reported
  if(!is.null(reportc) | !is.na(reportc)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("7. Percentage of all hospitalisations that are reported\n")
    cat("\n")

    repeat {
      ## Percentage of all hospitalisations that are reported
      reporth <- readline(prompt = "Percentage of reported hospitalisations (numeric; %): ")

      ## Check that reporth is in correct format (numeric)
      if(stringr::str_detect(string = reporth, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Percentage of reported hospitalisations should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(reporth) <= 0) {
          cat("\n")
          cat("Percentage of reported hospitalisations cannot be 0% or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(reporth) > 100 ) {
          cat("\n")
          cat("Percentage of reported hospitalisations cannot be more than 100%. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = reporth, pattern = "[0-9]")) {
        if(as.numeric(reporth) > 0 &
           as.numeric(reporth) <= 100) break
      }
    }
  }

  ## Input relative infectiousness of incubation phase
  if(!is.null(reporth) | !is.na(reporth)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("8. Relative infectiousness of incubation phase\n")
    cat("\n")
    cat("Current literature suggest a default value of 10%.\n")
    rho_default <- utils::menu(choices = c("Yes", "No"),
                               title = "Should default value be used?")

    if(rho_default == 2) {
      repeat {
        ## Relative infectiousness of incubation phase
        rho <- readline(prompt = "Relative infectiousness of incubation phase (numeric; %): ")

        ## Check that rho is in correct format (numeric)
        if(stringr::str_detect(string = rho, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Relative infectiousness of incubation phase should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(rho) <= 0) {
            cat("\n")
            cat("Relative infectiousness of incubation phase cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(rho) > 100 ) {
            cat("\n")
            cat("Relative infectiousness of incubation phase cannot be more than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = rho, pattern = "[0-9]")) {
          if(as.numeric(rho) > 0 &
             as.numeric(rho) <= 100) break
        }
      }
    } else rho <- 10
  }

  ## Input average incubation period
  if(!is.null(rho) | !is.na(rho)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("9. Average incubation period\n")
    cat("\n")
    cat("Current literature suggest a default value of 3.5 days.\n")
    gamma_default <- utils::menu(choices = c("Yes", "No"),
                                 title = "Should default value be used?")

    if(gamma_default == 2) {
      repeat {
        ## Average incubation period
        gamma <- readline(prompt = "Average incubation period (numeric; days): ")

        ## Check that gamma is in correct format (numeric)
        if(stringr::str_detect(string = gamma, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Average incubation period should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(gamma) <= 0) {
            cat("\n")
            cat("Average incubation period cannot be 0 or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(gamma) > 7 ) {
            cat("\n")
            cat("Average incubation period cannot be more than 7. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = gamma, pattern = "[0-9]")) {
          if(as.numeric(gamma) > 0 &
             as.numeric(gamma) <= 7) break
        }
      }
    } else gamma <- 3.5
  }

  ## Input average duration of symptomatic infection period
  if(!is.null(gamma) | !is.na(gamma)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("10. Average duration of symptomatic infection period\n")
    cat("\n")
    cat("Current literature suggest a default value of 4.5 days.\n")
    nui_default <- utils::menu(choices = c("Yes", "No"),
                               title = "Should default value be used?")

    if(nui_default == 2) {
      repeat {
        ## Average duration of symptomatic infection period
        nui <- readline(prompt = "Average duration of symptomatic infection period (numeric; days): ")

        ## Check that nui is in correct format (numeric)
        if(stringr::str_detect(string = nui, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Average duration of symptomatic infection period should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(nui) <= 0) {
            cat("\n")
            cat("Average duration of symptomatic infection period cannot be 0 or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(nui) > 7 ) {
            cat("\n")
            cat("Average duration of symptomatic infection period cannot be more than 7. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nui, pattern = "[0-9]")) {
          if(as.numeric(nui) > 0 &
             as.numeric(nui) <= 7) break
        }
      }
    } else nui <- 4.5
  }

  ## Input month of peak infectivity of the virus
  if(!is.null(nui) | !is.na(nui)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("11. Month of peak infectivity of the virus\n")
    cat("\n")
    cat("Current literature suggest a default value of January (1).\n")
    phi_default <- utils::menu(choices = c("Yes", "No"),
                               title = "Should default value be used?")

    if(phi_default == 2) {
      ## Average duration of symptomatic infection period
      phi <- utils::menu(choices = month.name,
                         title = "Month of peak infectivity of the virus")

    } else phi <- 1
  }

  ## Input annual variation in infectivity of the virus
  if(!is.null(phi) | !is.na(phi)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("12. Annual variation in infectivity of the virus\n")
    cat("\n")
    cat("Current literature suggest a default value of 0%.\n")
    amp_default <- utils::menu(choices = c("Yes", "No"),
                               title = "Should default value be used?")

    if(amp_default == 2) {
      repeat {
        ## Annual variation in infectivity of the virus
        amp <- readline(prompt = "Annual variation in infectivity of the virus (numeric; %): ")

        ## Check that amp is in correct format (numeric)
        if(stringr::str_detect(string = amp, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Annual variation in infectivity of the virus should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(amp) < 0) {
            cat("\n")
            cat("Annual variation in infectivity of the virus cannot be less than 0%. Try again.\n")
            cat("\n")
          }
          if(as.numeric(amp) > 100 ) {
            cat("\n")
            cat("Annual variation in infectivity of the virus cannot be more than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = amp, pattern = "[0-9]")) {
          if(as.numeric(amp) >= 0 &
             as.numeric(amp) <= 100) break
        }
      }
    } else amp <- 0
  }

  ## Input average duration of immunity
  if(!is.null(amp) | !is.na(amp)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("13. Average duration of immunity\n")
    cat("\n")
    cat("A default value of 150 years is suggested.\n")
    omega_default <- utils::menu(choices = c("Yes", "No"),
                                 title = "Should default value be used?")

    if(omega_default == 2) {
      repeat {
        ## Average duration of immunity
        omega <- readline(prompt = "Average duration of immunity (numeric; years): ")

        ## Check that omega is in correct format (numeric)
        if(stringr::str_detect(string = omega, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Average duration of immunity should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(omega) < 0.5) {
            cat("\n")
            cat("Average duration of immunity cannot be less than 0.5. Try again.\n")
            cat("\n")
          }
          if(as.numeric(omega) > 150 ) {
            cat("\n")
            cat("Average duration of immunity cannot be more than 150. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = omega, pattern = "[0-9]")) {
          if(as.numeric(omega) >= 0.5 &
             as.numeric(nui) <= 150) break
        }
      }
    } else omega <- 150
  }

  ## Input probability upon infection of developing clinical symptoms
  if(!is.null(omega) | !is.na(omega)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("14. Probability upon infection of developing clinical symptoms\n")
    cat("\n")
    cat("Current literature suggest a default value of 55%.\n")
    pclin_default <- utils::menu(choices = c("Yes", "No"),
                                 title = "Should default value be used?")

    if(pclin_default == 2) {
      repeat {
        ## Probability upon infection of developing clinical symptoms
        pclin <- readline(prompt = "Probability upon infection of developing clinical symptoms (numeric; %): ")

        ## Check that pclin is in correct format (numeric)
        if(stringr::str_detect(string = pclin, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability upon infection of developing clinical symptoms should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pclin) <= 0) {
            cat("\n")
            cat("Probability upon infection of developing clinical symptoms cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pclin) >= 100 ) {
            cat("\n")
            cat("Probability upon infection of developing clinical symptoms cannot be 100% or more. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pclin, pattern = "[0-9]")) {
          if(as.numeric(pclin) > 0 &
             as.numeric(pclin) < 100) break
        }
      }
    } else pclin <- 55
  }

  ## Input probability upon hospitalisation of requiring ICU admission
  if(!is.null(pclin) | !is.na(pclin)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("15. Probability upon hospitalisation of requiring ICU admission\n")
    cat("\n")
    cat("Current literature suggest a default value of 50%.\n")
    prob_icu_default <- utils::menu(choices = c("Yes", "No"),
                                    title = "Should default value be used?")

    if(prob_icu_default == 2) {
      repeat {
        ## Probability upon hospitalisation of requiring ICU admission
        prob_icu <- readline(prompt = "Probability upon hospitalisation of requiring ICU admission (numeric; %): ")

        ## Check that prob_icu is in correct format (numeric)
        if(stringr::str_detect(string = prob_icu, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability upon hospitalisation of requiring ICU admission should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(prob_icu) <= 0) {
            cat("\n")
            cat("Probability upon hospitalisation of requiring ICU admission cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(prob_icu) >= 100 ) {
            cat("\n")
            cat("Probability upon hospitalisation of requiring ICU admission cannot be 100% or more. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = prob_icu, pattern = "[0-9]")) {
          if(as.numeric(prob_icu) > 0 &
             as.numeric(prob_icu) < 100) break
        }
      }
    } else prob_icu <- 50
  }

  ## Input probability upon admission to the ICU of requiring a ventilator
  if(!is.null(prob_icu) | !is.na(prob_icu)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("16. Probability upon admission to the ICU of requiring a ventilator\n")
    cat("\n")
    cat("Current literature suggest a default value of 75%.\n")
    prob_vent_default <- utils::menu(choices = c("Yes", "No"),
                                     title = "Should default value be used?")

    if(prob_vent_default == 2) {
      repeat {
        ## Probability upon admission to the ICU of requiring a ventilator
        prob_vent <- readline(prompt = "Probability upon admission to the ICU of requiring a ventilator (numeric; %): ")

        ## Check that prob_vent is in correct format (numeric)
        if(stringr::str_detect(string = prob_vent, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability upon admission to the ICU of requiring a ventilator should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(prob_vent) <= 0) {
            cat("\n")
            cat("Probability upon admission to the ICU of requiring a ventilator cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(prob_vent) >= 100 ) {
            cat("\n")
            cat("Probability upon admission to the ICU of requiring a ventilator cannot be 100% or more. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = prob_vent, pattern = "[0-9]")) {
          if(as.numeric(prob_vent) > 0 &
             as.numeric(prob_vent) < 100) break
        }
      }
    } else prob_vent <- 75
  }

  ## Input maximum number of hospital beds
  if(!is.null(prob_vent) | !is.na(prob_vent)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("17. Maximum number of hospital beds\n")
    cat("\n")

    repeat {
      ## Maximum number of hospital beds
      beds_available <- readline(prompt = "Maximum number of hospital beds (numeric): ")

      ## Check that beds_available is in correct format (numeric)
      if(stringr::str_detect(string = beds_available, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Maximum number of hospital beds should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(beds_available) <= 0) {
          cat("\n")
          cat("Maximum number of hospital beds cannot be 0 or less. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = beds_available, pattern = "[0-9]")) {
        if(as.numeric(beds_available) > 0) break
      }
    }
  }

  ## Input maximum number of ICU beds
  if(!is.null(beds_available) | !is.na(beds_available)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("17. Maximum number of ICU beds\n")
    cat("\n")

    repeat {
      ## Maximum number of ICU beds
      icu_beds_available <- readline(prompt = "Maximum number of ICU beds (numeric): ")

      ## Check that icu_beds_available is in correct format (numeric)
      if(stringr::str_detect(string = icu_beds_available, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Maximum number of ICU beds should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(icu_beds_available) <= 0) {
          cat("\n")
          cat("Maximum number of ICU beds cannot be 0 or less. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = icu_beds_available, pattern = "[0-9]")) {
        if(as.numeric(icu_beds_available) > 0) break
      }
    }
  }

  ## Input maximum number of ventilators
  if(!is.null(icu_beds_available) | !is.na(icu_beds_available)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("18. Maximum number of ventilators\n")
    cat("\n")

    repeat {
      ## Maximum number of ventilators
      ventilators_available <- readline(prompt = "Maximum number of ventilators (numeric): ")

      ## Check that ventilators_available is in correct format (numeric)
      if(stringr::str_detect(string = ventilators_available, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Maximum number of ventilators should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(ventilators_available) <= 0) {
          cat("\n")
          cat("Maximum number of ventilators cannot be 0 or less. Try again.\n")
          cat("\n")
        }
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = ventilators_available, pattern = "[0-9]")) {
        if(as.numeric(ventilators_available) > 0) break
      }
    }
  }

  ## Input relative percentage of regular daily contacts when hospitalised.
  if(!is.null(ventilators_available) | !is.na(ventilators_available)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("19. Relative percentage of regular daily contacts when hospitalised\n")
    cat("\n")
    cat("Current literature suggest a default value of 15%.\n")
    rhos_default <- utils::menu(choices = c("Yes", "No"),
                                title = "Should default value be used?")

    if(rhos_default == 2) {
      repeat {
        ## Relative percentage of regular daily contacts when hospitalised
        rhos <- readline(prompt = "Relative percentage of regular daily contacts when hospitalised (numeric; %): ")

        ## Check that rhos are in correct format (numeric)
        if(stringr::str_detect(string = rhos, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Relative percentage of regular daily contacts when hospitalised should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(rhos) <= 0) {
            cat("\n")
            cat("Relative percentage of regular daily contacts when hospitalised cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(rhos) >= 100 ) {
            cat("\n")
            cat("Relative percentage of regular daily contacts when hospitalised cannot be 100% or more. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = rhos, pattern = "[0-9]")) {
          if(as.numeric(rhos) > 0 &
             as.numeric(rhos) < 100) break
        }
      }
    } else rhos <- 15
  }

  ## Input scaling factor for infection hospitalisation rate
  if(!is.null(rhos) | !is.na(rhos)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("20. Scaling factor for infection hospitalisation rate\n")
    cat("\n")
    cat("This is currently set at a default value of 1.\n")
    ihr_scaling_default <- utils::menu(choices = c("Yes", "No"),
                                       title = "Should default value be used?")

    if(ihr_scaling_default == 2) {
      repeat {
        ## Scaling factor for infection hospitalisation rate
        ihr_scaling <- readline(prompt = "Scaling factor for infection hospitalisation rate (numeric; %): ")

        ## Check that ihr_scaling are in correct format (numeric)
        if(stringr::str_detect(string = ihr_scaling, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Scaling factor for infection hospitalisation rate should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(ihr_scaling) <= 0) {
            cat("\n")
            cat("Scaling factor for infection hospitalisation rate cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(ihr_scaling) > 1 ) {
            cat("\n")
            cat("Scaling factor for infection hospitalisation rate cannot be 100% or more. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = ihr_scaling, pattern = "[0-9]")) {
          if(as.numeric(ihr_scaling) > 0 &
             as.numeric(ihr_scaling) <= 1) break
        }
      }
    } else ihr_scaling <- 1
  }

  ## Input probability of dying when hospitalised.
  if(!is.null(ihr_scaling) | !is.na(ihr_scaling)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("21. Probability of dying when hospitalised\n")
    cat("\n")
    cat("Current literature suggest a default value of 35%.\n")
    pdeath_h_default <- utils::menu(choices = c("Yes", "No"),
                                title = "Should default value be used?")

    if(pdeath_h_default == 2) {
      repeat {
        ## Probability of dying when hospitalised
        pdeath_h <- readline(prompt = "Probability of dying when hospitalised (numeric; %): ")

        ## Check that pdeath_h are in correct format (numeric)
        if(stringr::str_detect(string = pdeath_h, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability of dying when hospitalised should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pdeath_h) <= 0) {
            cat("\n")
            cat("Probability of dying when hospitalised cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pdeath_h) > 100 ) {
            cat("\n")
            cat("Probability of dying when hospitalised cannot be greater than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pdeath_h, pattern = "[0-9]")) {
          if(as.numeric(pdeath_h) > 0 &
             as.numeric(pdeath_h) <= 100) break
        }
      }
    } else pdeath_h <- 35
  }

  ## Input probability of dying when denied hospitalisation.
  if(!is.null(pdeath_h) | !is.na(pdeath_h)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("22. Probability of dying when denied hospitalisation\n")
    cat("\n")
    cat("Current literature suggest a default value of 45%.\n")
    pdeath_hc_default <- utils::menu(choices = c("Yes", "No"),
                                     title = "Should default value be used?")

    if(pdeath_hc_default == 2) {
      repeat {
        ## Probability of dying when denied hospitalisation
        pdeath_hc <- readline(prompt = "Probability of dying when denied hospitalisation (numeric; %): ")

        ## Check that pdeath_hc are in correct format (numeric)
        if(stringr::str_detect(string = pdeath_hc, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability of dying when denied hospitalisation should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pdeath_hc) <= 0) {
            cat("\n")
            cat("Probability of dying when denied hospitalisation cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pdeath_hc) > 100 ) {
            cat("\n")
            cat("Probability of dying when denied hospitalisation cannot be greater than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pdeath_hc, pattern = "[0-9]")) {
          if(as.numeric(pdeath_hc) > 0 &
             as.numeric(pdeath_hc) <= 100) break
        }
      }
    } else pdeath_hc <- 45
  }

  ## Input probability of dying when admitted to ICU
  if(!is.null(pdeath_hc) | !is.na(pdeath_hc)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("23. Probability of dying when admitted to ICU\n")
    cat("\n")
    cat("Current literature suggest a default value of 55%.\n")
    pdeath_icu_default <- utils::menu(choices = c("Yes", "No"),
                                      title = "Should default value be used?")

    if(pdeath_icu_default == 2) {
      repeat {
        ## Probability of dying when admitted to ICU
        pdeath_icu <- readline(prompt = "Probability of dying when admitted to ICU (numeric; %): ")

        ## Check that pdeath_icu are in correct format (numeric)
        if(stringr::str_detect(string = pdeath_icu, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability of dying when admitted to ICU should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pdeath_icu) <= 0) {
            cat("\n")
            cat("Probability of dying when admitted to ICU cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pdeath_icu) > 100 ) {
            cat("\n")
            cat("Probability of dying when admitted to ICU cannot be greater than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pdeath_icu, pattern = "[0-9]")) {
          if(as.numeric(pdeath_icu) > 0 &
             as.numeric(pdeath_icu) <= 100) break
        }
      }
    } else pdeath_icu <- 55
  }

  ## Input probability of dying when admission to ICU denied
  if(!is.null(pdeath_icu) | !is.na(pdeath_icu)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("24. Probability of dying when admission to ICU denied\n")
    cat("\n")
    cat("Current literature suggest a default value of 55%.\n")
    pdeath_icuc_default <- utils::menu(choices = c("Yes", "No"),
                                       title = "Should default value be used?")

    if(pdeath_icuc_default == 2) {
      repeat {
        ## Probability of dying when admission to ICU denied
        pdeath_icuc <- readline(prompt = "Probability of dying when admission to ICU denied (numeric; %): ")

        ## Check that pdeath_icuc are in correct format (numeric)
        if(stringr::str_detect(string = pdeath_icuc, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability of dying when admission to ICU denied should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pdeath_icuc) <= 0) {
            cat("\n")
            cat("Probability of dying when admission to ICU denied cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pdeath_icuc) > 100 ) {
            cat("\n")
            cat("Probability of dying when admission to ICU denied cannot be greater than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pdeath_icuc, pattern = "[0-9]")) {
          if(as.numeric(pdeath_icuc) > 0 &
             as.numeric(pdeath_icuc) <= 100) break
        }
      }
    } else pdeath_icuc <- 80
  }

  ## Input probability of dying when ventilated
  if(!is.null(pdeath_icuc) | !is.na(pdeath_icuc)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("24. Probability of dying when ventilated\n")
    cat("\n")
    cat("Current literature suggest a default value of 80%.\n")
    pdeath_vent_default <- utils::menu(choices = c("Yes", "No"),
                                       title = "Should default value be used?")

    if(pdeath_vent_default == 2) {
      repeat {
        ## Probability of dying when ventilated
        pdeath_vent <- readline(prompt = "Probability of dying when ventilated (numeric; %): ")

        ## Check that pdeath_vent are in correct format (numeric)
        if(stringr::str_detect(string = pdeath_vent, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability of dying when ventilated should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pdeath_vent) <= 0) {
            cat("\n")
            cat("Probability of dying when ventilated cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pdeath_vent) > 100 ) {
            cat("\n")
            cat("Probability of dying when ventilated cannot be greater than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pdeath_vent, pattern = "[0-9]")) {
          if(as.numeric(pdeath_vent) > 0 &
             as.numeric(pdeath_vent) <= 100) break
        }
      }
    } else pdeath_vent <- 80
  }

  ## Input probability of dying when ventilator denied
  if(!is.null(pdeath_vent) | !is.na(pdeath_vent)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("25. Probability of dying when ventilator denied\n")
    cat("\n")
    cat("Current literature suggest a default value of 95%.\n")
    pdeath_ventc_default <- utils::menu(choices = c("Yes", "No"),
                                        title = "Should default value be used?")

    if(pdeath_ventc_default == 2) {
      repeat {
        ## Probability of dying when ventilator denied
        pdeath_ventc <- readline(prompt = "Probability of dying when ventilator denied (numeric; %): ")

        ## Check that pdeath_ventc are in correct format (numeric)
        if(stringr::str_detect(string = pdeath_ventc, pattern = "[a-zA-Z]")) {
          cat("\n")
          cat("Probability of dying when ventilator denied should be numeric. Try again.\n")
          cat("\n")
        } else {
          if(as.numeric(pdeath_ventc) <= 0) {
            cat("\n")
            cat("Probability of dying when ventilator denied cannot be 0% or less. Try again.\n")
            cat("\n")
          }
          if(as.numeric(pdeath_ventc) > 100 ) {
            cat("\n")
            cat("Probability of dying when ventilator denied cannot be greater than 100%. Try again.\n")
            cat("\n")
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = pdeath_ventc, pattern = "[0-9]")) {
          if(as.numeric(pdeath_ventc) > 0 &
             as.numeric(pdeath_ventc) <= 100) break
        }
      }
    } else pdeath_ventc <- 95
  }

  ## Input duration of hospitalised infection
  if(!is.null(pdeath_ventc) | !is.na(pdeath_ventc)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("26. Duration of hospitalised infection\n")
    cat("\n")

    repeat {
      ## Duration of hospitalised infection
      nus <- readline(prompt = "Duration of hospitalised infection (numeric; days): ")

      ## Check that nus are in correct format (numeric)
      if(stringr::str_detect(string = nus, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Duration of hospitalised infection should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(nus) <= 0) {
          cat("\n")
          cat("Duration of hospitalised infection cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(nus) > 30 ) {
          cat("\n")
          cat("Duration of hospitalised infection cannot be greater than 30. Try again.\n")
          cat("\n")
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nus, pattern = "[0-9]")) {
          if(as.numeric(nus) > 0 &
             as.numeric(nus) <= 30) break
        }
      }
    }
  }

  ## Input duration of denied hospitalisation infection
  if(!is.null(nus) | !is.na(nus)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("27. Duration of denied hospitalisation infection\n")
    cat("\n")

    repeat {
      ## Duration of denied hospitalisation infection
      nusc <- readline(prompt = "Duration of denied hospitalisation infection (numeric; days): ")

      ## Check that nusc are in correct format (numeric)
      if(stringr::str_detect(string = nusc, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Duration of denied hospitalisation infection should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(nusc) <= 0) {
          cat("\n")
          cat("Duration of denied hospitalisation infection cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(nusc) > 30 ) {
          cat("\n")
          cat("Duration of denied hospitalisation infection cannot be greater than 30. Try again.\n")
          cat("\n")
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nusc, pattern = "[0-9]")) {
          if(as.numeric(nusc) > 0 &
             as.numeric(nusc) <= 30) break
        }
      }
    }
  }

  ## Input duration of ICU infection
  if(!is.null(nusc) | !is.na(nusc)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("28. Duration of ICU infection\n")
    cat("\n")

    repeat {
      ## Duration of ICU infection
      nu_icu <- readline(prompt = "Duration of ICU infection (numeric; days): ")

      ## Check that nu_icu in correct format (numeric)
      if(stringr::str_detect(string = nu_icu, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Duration of ICU infection should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(nu_icu) <= 0) {
          cat("\n")
          cat("Duration of ICU infection cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(nu_icu) > 30 ) {
          cat("\n")
          cat("Duration of ICU infection cannot be greater than 30. Try again.\n")
          cat("\n")
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_icu, pattern = "[0-9]")) {
          if(as.numeric(nu_icu) > 0 &
             as.numeric(nu_icu) <= 30) break
        }
      }
    }
  }

  ## Input duration of denied ICU infection
  if(!is.null(nu_icu) | !is.na(nu_icu)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("29. Duration of denied ICU infection\n")
    cat("\n")

    repeat {
      ## Duration of denied ICU infection
      nu_icuc <- readline(prompt = "Duration of denied ICU infection (numeric; days): ")

      ## Check that nu_icuc in correct format (numeric)
      if(stringr::str_detect(string = nu_icuc, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Duration of denied ICU infection should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(nu_icuc) <= 0) {
          cat("\n")
          cat("Duration of denied ICU infection cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(nu_icuc) > 30 ) {
          cat("\n")
          cat("Duration of denied ICU infection cannot be greater than 30. Try again.\n")
          cat("\n")
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_icuc, pattern = "[0-9]")) {
          if(as.numeric(nu_icuc) > 0 &
             as.numeric(nu_icuc) <= 30) break
        }
      }
    }
  }

  ## Input duration of ventilated infection
  if(!is.null(nu_icuc) | !is.na(nu_icuc)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("30. Duration of ventilated infection\n")
    cat("\n")

    repeat {
      ## Duration of ventilated infection
      nu_vent <- readline(prompt = "Duration of ventilated infection (numeric; days): ")

      ## Check that nu_vent in correct format (numeric)
      if(stringr::str_detect(string = nu_vent, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Duration of ventilated infection should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(nu_vent) <= 0) {
          cat("\n")
          cat("Duration of ventilated infection cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(nu_vent) > 30 ) {
          cat("\n")
          cat("Duration of ventilated infection cannot be greater than 30. Try again.\n")
          cat("\n")
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_vent, pattern = "[0-9]")) {
          if(as.numeric(nu_vent) > 0 &
             as.numeric(nu_vent) <= 30) break
        }
      }
    }
  }

  ## Input duration of denied ventilated infection
  if(!is.null(nu_vent) | !is.na(nu_vent)) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("31. Duration of denied ventilated infection\n")
    cat("\n")

    repeat {
      ## Duration of denied ventilated infection
      nu_ventc <- readline(prompt = "Duration of denied ventilated infection (numeric; days): ")

      ## Check that nu_ventc in correct format (numeric)
      if(stringr::str_detect(string = nu_ventc, pattern = "[a-zA-Z]")) {
        cat("\n")
        cat("Duration of denied ventilated infection should be numeric. Try again.\n")
        cat("\n")
      } else {
        if(as.numeric(nu_ventc) <= 0) {
          cat("\n")
          cat("Duration of denied ventilated infection cannot be 0 or less. Try again.\n")
          cat("\n")
        }
        if(as.numeric(nu_ventc) > 30 ) {
          cat("\n")
          cat("Duration of denied ventilated infection cannot be greater than 30. Try again.\n")
          cat("\n")
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_ventc, pattern = "[0-9]")) {
          if(as.numeric(nu_ventc) > 0 &
             as.numeric(nu_ventc) <= 30) break
        }
      }
    }
  }

  ## Concatenate params
  params <- list(country, household_size, mean_imports, date_range_simul_start,
                 date_range_simul_end, p, report, reportc, reporth, gamma, nui,
                 phi, amp, omega, pclin, prob_icu, prob_vent, beds_available,
                 icu_beds_available, ventilators_available, rhos, ihr_scaling,
                 pdeath_h, pdeath_hc, pdeath_icu, pdeath_icuc, pdeath_vent,
                 pdeath_ventc, nus, nusc, nu_icu, nu_icuc, nu_vent, nu_ventc)

  ## Return params
  return(params)
}




