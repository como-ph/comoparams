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
#' if(interactive()) ph_set_hospital()
#'
#' @export
#'
#
################################################################################

ph_set_hospital <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modeling HOSPITALISATION parameters for the Philippines\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")


  ## Input maximum number of hospital beds
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("Maximum number of hospital beds\n")
    cat("\n")

    repeat {
      ## Maximum number of hospital beds
      beds_available <- readline(prompt = "Maximum number of hospital beds (numeric): ")

      ## Check that beds_available is in correct format (numeric)
      if(is.na(beds_available) | beds_available == "") {
        cat("\n")
        cat("Maximum number of hospital beds should be provided. Try again.\n")
        cat("\n")
      } else {
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
      }

      ## If in correct format, go to next
      if(stringr::str_detect(string = beds_available, pattern = "[0-9]")) {
        if(as.numeric(beds_available) > 0) break
      }
    }

    ## Input maximum number of ICU beds
    if(!is.null(beds_available) | !is.na(beds_available)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("Maximum number of ICU beds\n")
      cat("\n")

      repeat {
        ## Maximum number of ICU beds
        icu_beds_available <- readline(prompt = "Maximum number of ICU beds (numeric): ")

        ## Check that icu_beds_available is in correct format (numeric)
        if(is.na(icu_beds_available) | icu_beds_available == "") {
          cat("\n")
          cat("Maximum number of ICU beds should be provided. Try again.\n")
          cat("\n")
        } else {
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
      cat("Maximum number of ventilators\n")
      cat("\n")

      repeat {
        ## Maximum number of ventilators
        ventilators_available <- readline(prompt = "Maximum number of ventilators (numeric): ")

        ## Check that ventilators_available is in correct format (numeric)
        if(is.na(ventilators_available) | ventilators_available == "") {
          cat("\n")
          cat("Maximum number of ventilarors should be provided. Try again.\n")
          cat("\n")
        } else {
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
      cat("Relative percentage of regular daily contacts when hospitalised\n")
      cat("\n")
      cat("Current literature suggest a default value of 15%. ")
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
            cat("Relative percentage of regular daily contacts when hospitalised should be provided. Try again.\n")
            cat("\n")
          } else {
            if(stringr::str_detect(string = rhos, pattern = "[a-zA-Z]")) {
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
      cat("Scaling factor for infection hospitalisation rate\n")
      cat("\n")
      cat("This is currently set at a default value of 1. ")
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
            cat("Scaling factor for infection hospitalisation rate should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Probability of dying when hospitalised\n")
      cat("\n")
      cat("Current literature suggest a default value of 35%. ")
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
            cat("Probability of dying when hospitalised should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Probability of dying when denied hospitalisation\n")
      cat("\n")
      cat("Current literature suggest a default value of 45%. ")
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
            cat("Probability of dying when denied hospitalisation should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Probability of dying when admitted to ICU\n")
      cat("\n")
      cat("Current literature suggest a default value of 55%. ")
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
            cat("Probability of dying when admitted to ICU should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Probability of dying when admission to ICU denied\n")
      cat("\n")
      cat("Current literature suggest a default value of 55%. ")
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
            cat("Probability of dying when admission to ICU denied should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Probability of dying when ventilated\n")
      cat("\n")
      cat("Current literature suggest a default value of 80%. ")
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
            cat("Probability of dying when ventilated should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Probability of dying when ventilator denied\n")
      cat("\n")
      cat("Current literature suggest a default value of 95%. ")
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
            cat("Probability of dying when ventilator denied should be provided. Try again.\n")
            cat("\n")
          } else {
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
      cat("Duration of hospitalised infection\n")
      cat("\n")

      repeat {
        ## Duration of hospitalised infection
        nus <- readline(prompt = "Duration of hospitalised infection (numeric; days): ")

        ## Check that nus are in correct format (numeric)
        if(is.na(nus) | nus == "") {
          cat("\n")
          cat("Duration of hospitalised infection should be provided. Try again.\n")
          cat("\n")
        } else {
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
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nus, pattern = "[0-9]")) {
          if(as.numeric(nus) > 0 &
             as.numeric(nus) <= 30) break
        }
      }
    }

    ## Input duration of denied hospitalisation infection
    if(!is.null(nus) | !is.na(nus)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("Duration of denied hospitalisation infection\n")
      cat("\n")

      repeat {
        ## Duration of denied hospitalisation infection
        nusc <- readline(prompt = "Duration of denied hospitalisation infection (numeric; days): ")

        ## Check that nusc are in correct format (numeric)
        if(is.na(nusc) | nusc == "") {
          cat("\n")
          cat("Duration of denied hospitalisation infection should be provided. Try again.\n")
          cat("\n")
        } else {
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
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nusc, pattern = "[0-9]")) {
          if(as.numeric(nusc) > 0 &
             as.numeric(nusc) <= 30) break
        }
      }
    }

    ## Input duration of ICU infection
    if(!is.null(nusc) | !is.na(nusc)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("Duration of ICU infection\n")
      cat("\n")

      repeat {
        ## Duration of ICU infection
        nu_icu <- readline(prompt = "Duration of ICU infection (numeric; days): ")

        ## Check that nu_icu in correct format (numeric)
        if(is.na(nu_icu) | nu_icu == "") {
          cat("\n")
          cat("Duration of ICU infection should be provided. Try again.\n")
          cat("\n")
        } else {
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
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_icu, pattern = "[0-9]")) {
          if(as.numeric(nu_icu) > 0 &
             as.numeric(nu_icu) <= 30) break
        }
      }
    }

    ## Input duration of denied ICU infection
    if(!is.null(nu_icu) | !is.na(nu_icu)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("Duration of denied ICU infection\n")
      cat("\n")

      repeat {
        ## Duration of denied ICU infection
        nu_icuc <- readline(prompt = "Duration of denied ICU infection (numeric; days): ")

        ## Check that nu_icuc in correct format (numeric)
        if(is.na(nu_icuc) | nu_icuc == "") {
          cat("\n")
          cat("Duration of denied ICU infection should be provided. Try again.\n")
          cat("\n")
        } else {
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
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_icuc, pattern = "[0-9]")) {
          if(as.numeric(nu_icuc) > 0 &
             as.numeric(nu_icuc) <= 30) break
        }
      }
    }

    ## Input duration of ventilated infection
    if(!is.null(nu_icuc) | !is.na(nu_icuc)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("Duration of ventilated infection\n")
      cat("\n")

      repeat {
        ## Duration of ventilated infection
        nu_vent <- readline(prompt = "Duration of ventilated infection (numeric; days): ")

        ## Check that nu_vent in correct format (numeric)
        if(is.na(nu_vent) | nu_vent == "") {
          cat("\n")
          cat("Duration of ventilated infection should be provided. Try again.\n")
          cat("\n")
        } else {
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
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_vent, pattern = "[0-9]")) {
          if(as.numeric(nu_vent) > 0 &
             as.numeric(nu_vent) <= 30) break
        }
      }
    }

    ## Input duration of denied ventilated infection
    if(!is.null(nu_vent) | !is.na(nu_vent)) {
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("Duration of denied ventilated infection\n")
      cat("\n")

      repeat {
        ## Duration of denied ventilated infection
        nu_ventc <- readline(prompt = "Duration of denied ventilated infection (numeric; days): ")

        ## Check that nu_ventc in correct format (numeric)
        if(is.na(nu_ventc) | nu_ventc == "") {
          cat("\n")
          cat("Duration of denied ventilation infection should be provided. Try again.\n")
          cat("\n")
        } else {
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
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = nu_ventc, pattern = "[0-9]")) {
          if(as.numeric(nu_ventc) > 0 &
             as.numeric(nu_ventc) <= 30) break
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
    nusc                  <- NA
    nu_icu                <- NA
    nu_icuc               <- NA
    nu_vent               <- NA
    nu_ventc              <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("HOSPITALISATION parameters have NOT been set.\n")
    cat("\n")
  }

  if(all(!is.na(list(beds_available, icu_beds_available, ventilators_available,
                     rhos, ihr_scaling, pdeath_h, pdeath_hc, pdeath_icu,
                     pdeath_icuc, pdeath_vent, pdeath_ventc, nus, nusc, nu_icu,
                     nu_icuc, nu_vent, nu_ventc)))) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("HOSPITALISATION parameters have been set. Proceed to next parameter.\n")
    cat("\n")
  }

  ## Concatenate params
  params <- list(as.numeric(beds_available), as.numeric(icu_beds_available),
                 as.numeric(ventilators_available), as.numeric(rhos),
                 as.numeric(ihr_scaling), as.numeric(pdeath_h),
                 as.numeric(pdeath_hc), as.numeric(pdeath_icu),
                 as.numeric(pdeath_icuc), as.numeric(pdeath_vent),
                 as.numeric(pdeath_ventc), as.numeric(nus), as.numeric(nusc),
                 as.numeric(nu_icu), as.numeric(nu_icuc), as.numeric(nu_vent),
                 as.numeric(nu_ventc))

  ##
  names(params) <- c("beds_available", "icu_beds_available",
                     "ventilators_available", "rhos", "ihr_scaling",
                     "pdeath_h", "pdeath_hc", "pdeath_icu", "pdeath_icuc",
                     "pdeath_vent", "pdeath_ventc", "nus", "nusc",
                     "nu_icu", "nu_icuc", "nu_vent", "nu_ventc")


  ## Return params
  return(params)
}






