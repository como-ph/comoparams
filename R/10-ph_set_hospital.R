################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for hospitalisation
#' parameters
#'
#' @return A list of Philippines-specific CoMo model parameters for
#'   hospitalisation parameters
#'
#' @examples
#' ph_set_hospital()
#'
#' @export
#'
#
################################################################################

ph_set_hospital <- function() {
  ## Header
  cli::cli_h1("Setting CoMo modeling HOSPITALISATION parameters for the Philippines")
  cat("\n")

  if(interactive()) {
    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Input maximum number of hospital beds
    if(set_params == 1) {
      cat("\n")
      cli::cli_h2("Maximum number of hospital beds")
      cat("\n")

      repeat {
        ## Maximum number of hospital beds
        beds_available <- readline(prompt = "Maximum number of hospital beds (numeric): ")

        ## Check that beds_available is in correct format (numeric)
        if(is.na(beds_available) | beds_available == "") {
          cat("\n")
          cli::cli_alert_danger("{cli::col_red('Maximum number of hospital beds should be provided. Try again.')}")
          cat("\n")
        } else {
          if(stringr::str_detect(string = beds_available, pattern = "[a-zA-Z]")) {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Maximum number of hospital beds should be numeric. Try again.')}")
            cat("\n")
          } else {
            if(as.numeric(beds_available) <= 0) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Maximum number of hospital beds cannot be 0 or less. Try again.')}")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = beds_available, pattern = "[0-9]")) {
          if(as.numeric(beds_available) > 0) break
        }
      }

      ## Input maximum number of ICU beds
      if(!is.null(beds_available) | !is.na(beds_available)) {
        cat("\n")
        cli::cli_h2("Maximum number of ICU beds")
        cat("\n")

        repeat {
          ## Maximum number of ICU beds
          icu_beds_available <- readline(prompt = "Maximum number of ICU beds (numeric): ")

          ## Check that icu_beds_available is in correct format (numeric)
          if(is.na(icu_beds_available) | icu_beds_available == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Maximum number of ICU beds should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = icu_beds_available, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Maximum number of ICU beds should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(icu_beds_available) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Maximum number of ICU beds cannot be 0 or less. Try again.')}")
                cat("\n")
              }
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
        cli::cli_h2("Maximum number of ventilators")
        cat("\n")

        repeat {
          ## Maximum number of ventilators
          ventilators_available <- readline(prompt = "Maximum number of ventilators (numeric): ")

          ## Check that ventilators_available is in correct format (numeric)
          if(is.na(ventilators_available) | ventilators_available == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Maximum number of ventilarors should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = ventilators_available, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Maximum number of ventilators should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(ventilators_available) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Maximum number of ventilators cannot be 0 or less. Try again.')}")
                cat("\n")
              }
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
        cli::cli_h2("Relative percentage of regular daily contacts when hospitalised")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 15%.")
        rhos_default <- utils::menu(choices = c("Yes", "No"),
                                    title = "Should default value be used?")
        cat("\n")

        if(rhos_default == 2) {
          repeat {
            ## Relative percentage of regular daily contacts when hospitalised
            rhos <- readline(prompt = "Relative percentage of regular daily contacts when hospitalised (numeric; %): ")

            ## Check that rhos are in correct format (numeric)
            if(is.na(rhos) | rhos == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Relative percentage of regular daily contacts when hospitalised should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = rhos, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Relative percentage of regular daily contacts when hospitalised should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(rhos) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Relative percentage of regular daily contacts when hospitalised cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(rhos) >= 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Relative percentage of regular daily contacts when hospitalised cannot be 100% or more. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Scaling factor for infection hospitalisation rate")
        cat("\n")
        cli::cli_h3("This is currently set at a default value of 1.")
        ihr_scaling_default <- utils::menu(choices = c("Yes", "No"),
                                           title = "Should default value be used?")
        cat("\n")

        if(ihr_scaling_default == 2) {
          repeat {
            ## Scaling factor for infection hospitalisation rate
            ihr_scaling <- readline(prompt = "Scaling factor for infection hospitalisation rate (numeric; %): ")

            ## Check that ihr_scaling are in correct format (numeric)
            if(is.na(ihr_scaling) | ihr_scaling == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Scaling factor for infection hospitalisation rate should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = ihr_scaling, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Scaling factor for infection hospitalisation rate should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(ihr_scaling) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Scaling factor for infection hospitalisation rate cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(ihr_scaling) > 1 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Scaling factor for infection hospitalisation rate cannot be 100% or more. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Probability of dying when hospitalised")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 35%.")
        pdeath_h_default <- utils::menu(choices = c("Yes", "No"),
                                        title = "Should default value be used?")
        cat("\n")

        if(pdeath_h_default == 2) {
          repeat {
            ## Probability of dying when hospitalised
            pdeath_h <- readline(prompt = "Probability of dying when hospitalised (numeric; %): ")

            ## Check that pdeath_h are in correct format (numeric)
            if(is.na(pdeath_h) | pdeath_h == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of dying when hospitalised should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = pdeath_h, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of dying when hospitalised should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(pdeath_h) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when hospitalised cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(pdeath_h) > 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when hospitalised cannot be greater than 100%. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Probability of dying when denied hospitalisation")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 45%.")
        pdeath_hc_default <- utils::menu(choices = c("Yes", "No"),
                                         title = "Should default value be used?")
        cat("\n")

        if(pdeath_hc_default == 2) {
          repeat {
            ## Probability of dying when denied hospitalisation
            pdeath_hc <- readline(prompt = "Probability of dying when denied hospitalisation (numeric; %): ")

            ## Check that pdeath_hc are in correct format (numeric)
            if(is.na(pdeath_hc) | pdeath_hc == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of dying when denied hospitalisation should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = pdeath_hc, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of dying when denied hospitalisation should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(pdeath_hc) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when denied hospitalisation cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(pdeath_hc) > 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when denied hospitalisation cannot be greater than 100%. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Probability of dying when admitted to ICU")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 55%.")
        pdeath_icu_default <- utils::menu(choices = c("Yes", "No"),
                                          title = "Should default value be used?")
        cat("\n")

        if(pdeath_icu_default == 2) {
          repeat {
            ## Probability of dying when admitted to ICU
            pdeath_icu <- readline(prompt = "Probability of dying when admitted to ICU (numeric; %): ")

            ## Check that pdeath_icu are in correct format (numeric)
            if(is.na(pdeath_icu) | pdeath_icu == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of dying when admitted to ICU should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = pdeath_icu, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of dying when admitted to ICU should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(pdeath_icu) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when admitted to ICU cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(pdeath_icu) > 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when admitted to ICU cannot be greater than 100%. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Probability of dying when admission to ICU denied")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 55%.")
        pdeath_icuc_default <- utils::menu(choices = c("Yes", "No"),
                                           title = "Should default value be used?")
        cat("\n")

        if(pdeath_icuc_default == 2) {
          repeat {
            ## Probability of dying when admission to ICU denied
            pdeath_icuc <- readline(prompt = "Probability of dying when admission to ICU denied (numeric; %): ")

            ## Check that pdeath_icuc are in correct format (numeric)
            if(is.na(pdeath_icuc) | pdeath_icuc == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of dying when admission to ICU denied should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = pdeath_icuc, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of dying when admission to ICU denied should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(pdeath_icuc) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when admission to ICU denied cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(pdeath_icuc) > 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when admission to ICU denied cannot be greater than 100%. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Probability of dying when ventilated")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 80%.")
        pdeath_vent_default <- utils::menu(choices = c("Yes", "No"),
                                           title = "Should default value be used?")
        cat("\n")

        if(pdeath_vent_default == 2) {
          repeat {
            ## Probability of dying when ventilated
            pdeath_vent <- readline(prompt = "Probability of dying when ventilated (numeric; %): ")

            ## Check that pdeath_vent are in correct format (numeric)
            if(is.na(pdeath_vent) | pdeath_vent == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilated should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = pdeath_vent, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilated should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(pdeath_vent) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilated cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(pdeath_vent) > 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilated cannot be greater than 100%. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Probability of dying when ventilator denied")
        cat("\n")
        cli::cli_h3("Current literature suggest a default value of 95%.")
        pdeath_ventc_default <- utils::menu(choices = c("Yes", "No"),
                                            title = "Should default value be used?")
        cat("\n")

        if(pdeath_ventc_default == 2) {
          repeat {
            ## Probability of dying when ventilator denied
            pdeath_ventc <- readline(prompt = "Probability of dying when ventilator denied (numeric; %): ")

            ## Check that pdeath_ventc are in correct format (numeric)
            if(is.na(pdeath_ventc) | pdeath_ventc == "") {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilator denied should be provided. Try again.')}")
              cat("\n")
            } else {
              if(stringr::str_detect(string = pdeath_ventc, pattern = "[a-zA-Z]")) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilator denied should be numeric. Try again.')}")
                cat("\n")
              } else {
                if(as.numeric(pdeath_ventc) <= 0) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilator denied cannot be 0% or less. Try again.')}")
                  cat("\n")
                }
                if(as.numeric(pdeath_ventc) > 100 ) {
                  cat("\n")
                  cli::cli_alert_danger("{cli::col_red('Probability of dying when ventilator denied cannot be greater than 100%. Try again.')}")
                  cat("\n")
                }
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
        cli::cli_h2("Duration of hospitalised infection")
        cat("\n")

        repeat {
          ## Duration of hospitalised infection
          nus <- readline(prompt = "Duration of hospitalised infection (numeric; days): ")

          ## Check that nus are in correct format (numeric)
          if(is.na(nus) | nus == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Duration of hospitalised infection should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = nus, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Duration of hospitalised infection should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(nus) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Duration of hospitalised infection cannot be 0 or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(nus) > 30 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Duration of hospitalised infection cannot be greater than 30. Try again.')}")
                cat("\n")
              }
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = nus, pattern = "[0-9]")) {
            if(as.numeric(nus) > 0 &
              as.numeric(nus) <= 30) break
          }
        }
      }

      ## Input duration of ICU infection
      if(!is.null(nus) | !is.na(nus)) {
        cat("\n")
        cli::cli_h2("Duration of ICU infection")
        cat("\n")

        repeat {
          ## Duration of ICU infection
          nu_icu <- readline(prompt = "Duration of ICU infection (numeric; days): ")

          ## Check that nu_icu in correct format (numeric)
          if(is.na(nu_icu) | nu_icu == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Duration of ICU infection should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = nu_icu, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Duration of ICU infection should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(nu_icu) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Duration of ICU infection cannot be 0 or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(nu_icu) > 30 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Duration of ICU infection cannot be greater than 30. Try again.')}")
                cat("\n")
              }
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = nu_icu, pattern = "[0-9]")) {
            if(as.numeric(nu_icu) > 0 &
              as.numeric(nu_icu) <= 30) break
          }
        }
      }

      ## Input duration of ventilated infection
      if(!is.null(nu_icu) | !is.na(nu_icu)) {
        cat("\n")
        cli::cli_h2("Duration of ventilated infection")
        cat("\n")

        repeat {
          ## Duration of ventilated infection
          nu_vent <- readline(prompt = "Duration of ventilated infection (numeric; days): ")

          ## Check that nu_vent in correct format (numeric)
          if(is.na(nu_vent) | nu_vent == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Duration of ventilated infection should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = nu_vent, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Duration of ventilated infection should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(nu_vent) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Duration of ventilated infection cannot be 0 or less. Try again.')}")
                cat("\n")
              }
              if(as.numeric(nu_vent) > 30 ) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Duration of ventilated infection cannot be greater than 30. Try again.')}")
                cat("\n")
              }
            }
          }

          ## If in correct format, go to next
          if(stringr::str_detect(string = nu_vent, pattern = "[0-9]")) {
            if(as.numeric(nu_vent) > 0 &
              as.numeric(nu_vent) <= 30) break
          }
        }
      }
    } else {
      beds_available        <- NA
      icu_beds_available    <- NA
      ventilators_available <- NA
      rhos                  <- NA
      ihr_scaling           <- NA
      pdeath_h              <- NA
      pdeath_hc             <- NA
      pdeath_icu            <- NA
      pdeath_icuc           <- NA
      pdeath_vent           <- NA
      pdeath_ventc          <- NA
      nus                   <- NA
      nu_icu                <- NA
      nu_vent               <- NA

      cat("\n")
      cli::cli_alert_danger("{cli::col_red('HOSPITALISATION parameters have NOT been set.')}")
      cat("\n")
    }

    if(all(!is.na(list(beds_available, icu_beds_available, ventilators_available,
                       rhos, ihr_scaling, pdeath_h, pdeath_hc, pdeath_icu,
                       pdeath_icuc, pdeath_vent, pdeath_ventc, nus, nu_icu,
                       nu_vent)))) {
      cat("\n")
      cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                            {cli::col_green('HOSPITALISATION parameters have been set.')} |
                            {cli::col_blue(cli::symbol$arrow_right)}
                            {cli::col_blue('Proceed to next parameter.')}")
      cat("\n")
    }
  } else {
    cat("\n")
    cli::cli_alert_danger(text = "{cli::col_red('HOSPITALISATION parameters have NOT been set.')}")
    cli::cli_text(text = "{cli::col_red('Setting HOSPITALISATION parameters require interactive input from user. Try again.)}")

    beds_available        <- NA
    icu_beds_available    <- NA
    ventilators_available <- NA
    rhos                  <- NA
    ihr_scaling           <- NA
    pdeath_h              <- NA
    pdeath_hc             <- NA
    pdeath_icu            <- NA
    pdeath_icuc           <- NA
    pdeath_vent           <- NA
    pdeath_ventc          <- NA
    nus                   <- NA
    nu_icu                <- NA
    nu_vent               <- NA
  }

  ## Concatenate params
  params <- list(as.numeric(beds_available), as.numeric(icu_beds_available),
                 as.numeric(ventilators_available), as.numeric(rhos),
                 as.numeric(ihr_scaling), as.numeric(pdeath_h),
                 as.numeric(pdeath_hc), as.numeric(pdeath_icu),
                 as.numeric(pdeath_icuc), as.numeric(pdeath_vent),
                 as.numeric(pdeath_ventc), as.numeric(nus), as.numeric(nu_icu),
                 as.numeric(nu_vent))

  ##
  names(params) <- c("beds_available", "icu_beds_available",
                     "ventilators_available", "rhos", "ihr_scaling",
                     "pdeath_h", "pdeath_hc", "pdeath_icu", "pdeath_icuc",
                     "pdeath_vent", "pdeath_ventc", "nus", "nu_icu", "nu_vent")


  ## Return params
  return(params)
}






