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
  if(!is.null(reporth) | !is.na(reporth)) {
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
}




