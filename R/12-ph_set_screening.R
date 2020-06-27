################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation screening intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model screening intervention
#'   parameters
#'
#' @examples
#' ph_set_screening()
#'
#' @export
#'
#
################################################################################

ph_set_screening <- function() {
  ## Header
  cli::cli_h1("Setting CoMo modelling SCREENING TEST intervention parameters for the Philippines")
  cat("\n")

  ## Check if interacrive
  if(interactive()) {
    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Input screening information
    if(set_params == 1) {
      ## Input for screening
      cat("\n")
      cli::cli_h2("Screening test")
      cat("\n")
      screen <- menu(choices = c("Yes", "No"),
                     title = "Is screening for cases conducted?")
      cat("\n")

      if(screen == 1) {
        ## Input screen coverage
        cat("\n")
        cli::cli_h3("What is the level of screening coverage?")
        cat("\n")
        repeat {
          ## screening coverage
          screen_cov <- readline(prompt = "Coverage of screening (numeric; %): ")

          ## Check that screening coverage is in correct format
          if(is.na(screen_cov) | screen_cov == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Coverage of screening should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = screen_cov, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Coverage of screening should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(screen_cov) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Coverage of screening cannot be 0% or less. Try again')}")
                cat("/n")
              }
              if(as.numeric(screen_cov) > 100) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Coverage of screening cannot be greater than 100%. Try again.')}")
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

        ## Input for screening overdispersion
        cat("\n")
        cli::cli_h3("How much is the level of screening overdispersion?")
        cat("\n")
        repeat {
          ## Screening overdispersion
          screen_overdispersion <- readline(prompt = "Screening overdispersion (numeric; 1-5): ")

          ## Check that screening overdispersion is in correct format
          if(is.na(screen_overdispersion) | screen_overdispersion == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Screening overdispersion should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = screen_overdispersion, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Screening overdispersion should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(screen_overdispersion) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Screening overdispersion cannot be 0 or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(screen_overdispersion) > 5) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Screening overdispersion cannot be greater than 5. Try again.')}")
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
        cli::cli_h3("What is the screening test sensitivity?")
        cat("\n")
        repeat {
          ## Screening contacts
          screen_test_sens <- readline(prompt = "Screening test sensitivity (numeric; %): ")

          ## Check that screening contacts is in correct format
          if(is.na(screen_test_sens) | screen_test_sens == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Screening test sensitivity should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = screen_test_sens, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Screening test sensitivity should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(screen_test_sens) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Screening test sensitivity cannot be 0% or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(screen_test_sens) > 100) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Screening test sensitivity cannot be greater than 100%. Try again.')}")
                cat("\n")
              }
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = screen_test_sens, pattern = "[0-9]")) {
            if(as.numeric(screen_test_sens) > 0 &
               as.numeric(screen_test_sens) <= 10) break
          }
        }
      } else {
        cat("\n")
        cli::cli_alert_warning("{cli::col_yellow('SCREENING TEST intervention has NOT been implemented yet. Proceed to next intervention.')}")
        cat("\n")

        ## set screening params to NA
        screen                <- FALSE
        screen_cov            <- NA
        screen_overdispersion <- NA
        screen_test_sens      <- NA
      }
    } else {
      cat("\n")
      cli::cli_alert_danger("{cli::col_red('SCREENING TEST intervention parameters have NOT been set.')}")
      cat("\n")
      ## set screening params to NA
      screen                <- FALSE
      screen_cov            <- NA
      screen_overdispersion <- NA
      screen_test_sens      <- NA
    }
  } else {
    cat("\n")
    cli::cli_alert_danger(text = "{cli::col_red('SCREENING TEST parameters have NOT been set.')}")
    cli::cli_text(text = "{cli::col_red('Setting SCREENING TEST parameters require interactive input from user. Try again.)}")

    ## set screening params to NA
    screen                <- FALSE
    screen_cov            <- NA
    screen_overdispersion <- NA
    screen_test_sens      <- NA
  }

  if(all(!is.na(c(selfis, date_selfis_on, selfis_dur, selfis_cov, selfis_eff,
                  screen_switch, date_screen_on, screen_cov, screen_dur,
                  screen_overdispersion, screen_contacts)))) {
    cat("\n")
    cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                          {cli::col_green('SCRENING TEST intervention parameters have been set.')} |
                          {cli::col_blue(cli::symbol$arrow_right)}
                          {cli::col_blue('Proceed to next parameter.')}")
    cat("\n")
  }

  ## Concatenate params
  params <- list(screen,
                 as.numeric(screen_cov),
                 as.numeric(screen_overdispersion),
                 as.numeric(screen_test_sens))

  ##
  names(params) <- list("screen",
                        "screen_cov",
                        "screen_overdispersion",
                        "screen_test_sene")

  ## Return params
  return(params)
}

