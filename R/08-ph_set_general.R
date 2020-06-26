################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for general and
#' area factors
#'
#' @return A list of Philippines-specific CoMo model parameters for general and
#'   area factors
#'
#' @examples
#' ph_set_general()
#'
#' @export
#'
#
################################################################################

ph_set_general <- function() {
  ## Header
  cli::cli_h1(text = "Setting CoMo modeling GENERAL parameters for the Philippines")
  cat("\n")

  ## Check if interactive
  if(interactive()) {
    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Check user response
    if(set_params == 1) {
      country <- "Philippines"

      ## Input mean household size
      cat("\n")
      cli::cli_h2(text = paste("What is the mean household size in ",
                               country, "/area of ", country, "?\n", sep = ""))
      cat("\n")

      ## Receive and check response
      repeat {
        ## Household size prompts
        household_size <- readline(prompt = "Enter mean household size (numeric): ")

        ## Check that household_size is in correct format
        if(is.na(household_size) | household_size == "") {
          cat("\n")
          cli::cli_alert_danger(text = "{cli::col_red('Mean household size should be provided. Try again.')}")
          cat("\n")
        } else {
          if(stringr::str_detect(string = household_size, pattern = "[a-zA-Z]")) {
            cat("\n")
            cli::cli_alert_danger(text = "{cli::col_red('Mean household size should be numeric. Try again.')}")
            cat("\n")
          } else {
            if(as.numeric(household_size) < 1) {
              cat("\n")
              cli::cli_alert_danger(text = "{cli::col_red('Mean household size cannot be less than 1. Try again.')}")
              cat("\n")
            }
            if(as.numeric(household_size) > 9) {
              cat("\n")
              cli::cli_alert_danger(text = "{cli::col_red('Mean household size cannot be more than 9. Try again.')}")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = household_size, pattern = "[0-9]")) {
          if(as.numeric(household_size) >= 1 &
             as.numeric(household_size) <= 9) break
        }
      }

      ## Input mean number of infectious migrants per day
      if(!is.null(household_size) | !is.na(household_size)) {
        cat("\n")
        cli::cli_h2(paste("What is the mean number of infectious migrants per day in ",
                          country, "/area of ", country, "?\n", sep = ""))
        cat("\n")

        ## Receive and check response
        repeat {
          ## Mean imports prompt
          mean_imports <- readline(prompt = "Mean number of infectious migrants per day (numeric): ")

          ## Check that mean_imports is in correct format
          if(is.na(mean_imports) | mean_imports == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Mean imports should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = mean_imports, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Mean imports should be numeric. Try again.')}")
              cat("\n")
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = mean_imports, pattern = "[0-9]")) break
        }
      }

      ## Input start date of simulation
      if(!is.null(mean_imports) | !is.na(mean_imports)) {
        cat("\n")
        cli::cli_h2("Starting date of simulation (DD/MM/YYYY format)")
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
            cli::cli_alert_danger("{cli::col_red('Starting date is not in DD/MM/YYYY format. Try again.')}")
            cat("\n")
          } else {
            ## Check if date is within plausible starting date for simulation
            if(!lubridate::dmy(date_range_simul_start) %within% startEnd) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Starting date is not within plausible dates for simulation. Try again.')}")
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
        cli::cli_h2("Ending date of simulation (DD/MM/YYYY format)\n")
        cat("\n")

        repeat {
          ## Start date of simulation
          date_range_simul_end <- readline(prompt = "End date (DD/MM/YYYY): ")

          ## Check if date is in correct format
          if(is.na(lubridate::dmy(date_range_simul_end, quiet = TRUE))) {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Ending date is not in DD/MM/YYYY format. Try again.')}")
            cat("\n")
          } else {
            ## Check if date is within plausible ending date for simulation
            if(lubridate::dmy(date_range_simul_end) %within%
               lubridate::interval(start = lubridate::dmy(date_range_simul_start),
                                   end = Sys.Date())) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Ending date should be beyond current date. Try again.')}")
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
        cli::cli_h2("Probability of infection given contact")
        cat("\n")

        repeat {
          ## Probability of infection given contact
          p <- readline(prompt = "Probability of infection (numeric; proportion): ")

          ## Check that p is in correct format (numeric)
          if(is.na(p) | p == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Probability of infection (p) should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = p, pattern = "[a-zA-Z]|%")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of infection (p) should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(p) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of infection (p) cannot be 0 or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(p) >= 1 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of infection (p) cannot be 1 or more. Try again.')}")
                cat("\n")
              }
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
        cli::cli_h2("Percentage of all asymptomatic infections that are reported")
        cat("\n")

        repeat {
          ## Percentage of all asymptomatic infections that are reported
          report <- readline(prompt = "Percentage of asymptomatic infections (numeric; %): ")

          ## Check that report is in correct format (numeric)
          if(is.na(report) | report == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Percentage of asymptomatic infections should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = report, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Percentage of asymptomatic infections should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(report) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Percentage of asymptomatic infections cannot be 0% or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(report) >= 100 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Percentage of asymptomatic infection cannot be 100% or more. Try again.')}")
                cat("\n")
              }
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
        cli::cli_h2("Percentage of all symptomatic infections that are reported")
        cat("\n")

        repeat {
          ## Percentage of all symptomatic infections that are reported
          reportc <- readline(prompt = "Percentage of symptomatic infections (numeric; %): ")

          ## Check that reportc is in correct format (numeric)
          if(is.na(reportc) | reportc == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Percentage of symptomatic infections should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = reportc, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Percentage of symptomatic infections should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(reportc) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Percentage of symptomatic infections cannot be 0% or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(reportc) >= 100 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Percentage of symptomatic infections cannot be 100% or more. Try again.')}")
                cat("\n")
              }
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
        cli::cli_h2("Percentage of all hospitalisations that are reported")
        cat("\n")

        repeat {
          ## Percentage of all hospitalisations that are reported
          reporth <- readline(prompt = "Percentage of reported hospitalisations (numeric; %): ")

          ## Check that reporth is in correct format (numeric)
          if(is.na(reportc) | reportc == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Percentage of reported hospitalisations should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = reporth, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Percentage of reported hospitalisations should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(reporth) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Percentage of reported hospitalisations cannot be 0% or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(reporth) > 100 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Percentage of reported hospitalisations cannot be more than 100%. Try again.')}")
                cat("\n")
              }
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = reporth, pattern = "[0-9]")) {
            if(as.numeric(reporth) > 0 &
              as.numeric(reporth) <= 100) break
          }
        }
      }
    } else {
      ##
      country                <- NA
      household_size         <- NA
      mean_imports           <- NA
      date_range_simul_start <- NA
      date_range_simul_end   <- NA
      p                      <- NA
      report                 <- NA
      reportc                <- NA
      reporth                <- NA

      ##
      cat("\n")
      cli::cli_h1("GENERAL modeling parameters have NOT been set.")
      cat("\n")
    }

    ##
    if(all(!is.na(c(country, household_size, mean_imports,
                    date_range_simul_start, date_range_simul_end,
                    p, report, reportc, reporth)))) {
      cat("\n")
      cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                          {cli::col_green('GENERAL modelling parameters have been set.')} |
                          {cli::col_blue(cli::symbol$arrow_right)}
                          {cli::col_blue('Proceed to next parameter.')}")
      cat("\n")
    }
  } else {
    cli::cli_alert_danger(text = "{cli::col_red('GENERAL modelling parameters have NOT been set.')}")
    cli::col_red(text = "Setting GENERAL modelling parameters require interactive input from user. Try again.")

    country                <- NA
    household_size         <- NA
    mean_imports           <- NA
    date_range_simul_start <- NA
    date_range_simul_end   <- NA
    p                      <- NA
    report                 <- NA
    reportc                <- NA
    reporth                <- NA
  }

  ## Concatenate params
  params <- list(country, household_size, mean_imports, date_range_simul_start,
                 date_range_simul_end, p, report, reportc, reporth)

  names(params) <- c("country", "household_size", "mean_imports",
                     "date_range_simul_start", "date_range_simul_end",
                     "p", "report", "reportc", "reporth")

  ## Return params
  return(params)
}
