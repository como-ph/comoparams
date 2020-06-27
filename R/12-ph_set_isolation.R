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
#' ph_set_isolation()
#'
#' @export
#'
#
################################################################################

ph_set_isolation <- function() {
  ## Header
  cli_h1("Setting CoMo modelling SELF-ISOLATION intervention parameters for the Philippines")
  cat("\n")

  ## Check if interactive
  if(interactive()) {

    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Input self-isolation information
    if(set_params == 1) {
      cat("\n")
      cli::cli_h2("Self-isolation of symptomatics")
      cat("\n")
      selfis <- menu(choices = c("Yes", "No"),
                     title = "Has self-isolation of symptomatics been implemented?")

      if(selfis == 1) {

        ## Input self-isolation coverage
        cat("\n")
        cli::cli_h3("What is the level of self-isolation coverage?")
        cat("\n")
        repeat {
          ## Self-isolation coverage
          selfis_cov <- readline(prompt = "Coverage of self-isolation (numeric; %): ")

          ## Check that self-isolation coverage is in correct format
          if(is.na(selfis_cov) | selfis_cov == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Coverage of self-isolation should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = selfis_cov, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Coverage of self-isolation should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(selfis_cov) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Coverage of self-isolation cannot be 0% or less. Try again.')}")
                cat("/n")
              }
              if(as.numeric(selfis_cov) > 100) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Coverage of self-isolation cannot be greater than 100%. Try again.')}")
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
        cli::cli_h3("What is the level of self-isolation adherence?")
        cat("\n")
        repeat {
          ## Self-isolation adherence
          selfis_eff <- readline(prompt = "Adherence to self-isolation (numeric; %): ")

          ## Check that self-isolation adherence is in correct format
          if(is.na(selfis_eff) | selfis_eff == "") {
            cat("\n")
            cli::cli_alert_danger("{cli::col_red('Adherence of self-isolation should be provided. Try again.')}")
            cat("\n")
          } else {
            if(stringr::str_detect(string = selfis_eff, pattern = "[a-zA-Z]")) {
              cat("\n")
              cli::cli_alert_danger("{cli::col_red('Adherence to self-isolation should be numeric. Try again.')}")
              cat("\n")
            } else {
              if(as.numeric(selfis_eff) <= 0) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Adherence to self-isolation cannot be 0% or less. Try again.')}")
                cat("/n")
              }
              if(as.numeric(selfis_eff) > 100) {
                cat("\n")
                cli::cli_alert_danger("{cli::col_red('Adherence to self-isolation cannot be greater than 100%. Try again.')}")
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
      } else {
        cat("\n")
        cli::cli_alert_danger("{cli::col_red('SELF-ISOLATION intervention parameters have NOT been set.')}")
        cat("\n")
        ## set params to NA
        selfis                <- FALSE
        selfis_cov            <- NA
        selfis_eff            <- NA
      }
    } else {
      cat("\n")
      cli::cli_alert_warning("{cli::col_yellow('SELF-ISOLATION intervention has NOT been implemented yet. Proceed to next intervention.')}")
      cat("\n")
      ## set params to NA
      selfis                <- FALSE
      selfis_cov            <- NA
      selfis_eff            <- NA
    }

    if(all(!is.na(c(selfis, date_selfis_on, selfis_dur, selfis_cov, selfis_eff,
                    screen_switch, date_screen_on, screen_cov, screen_dur,
                    screen_overdispersion, screen_contacts)))) {
      cat("\n")
      cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                            {cli::col_green('SELF-ISOLATION intervention parameters have been set.')} |
                            {cli::col_blue(cli::symbol$arrow_right)}
                            {cli::col_blue('Proceed to next parameter.')}")
      cat("\n")
    }
  } else {
    cat("\n")
    cli::cli_alert_danger(text = "{cli::col_red('SELF-ISOLATION parameters have NOT been set.')}")
    cli::cli_text(text = "{cli::col_red('Setting SELF-ISOLATION parameters require interactive input from user. Try again.)}")

    ## set params to NA
    selfis                <- FALSE
    selfis_cov            <- NA
    selfis_eff            <- NA
  }

  ## Concatenate params
  params <- list(selfis,
                 as.numeric(selfis_cov),
                 as.numeric(selfis_eff))

  ##
  names(params) <- list("selfis",
                        "selfis_cov",
                        "selfis_eff")

  ## Return params
  return(params)
}

