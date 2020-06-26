################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for severity of
#' cases and mortality
#'
#' @return A data.frame of Philippines-specific CoMo model parameters for
#'   severity of cases and mortality
#'
#' @examples
#' ph_set_severe()
#'
#' @export
#'
#
################################################################################

ph_set_severe <- function() {
  ## Header
  cli::cli_h1(text = "Setting CoMo modelling SEVERITY and MORTALITY parameters for the Philippines")
  cat("\n")

  ## Check if interctive
  if(interactive()) {
    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Check user answer
    if(set_params == 1) {
      cat("\n")
      cli::cli_text("Calculating severity and mortality...")
      cat("\n")

      ## Calculate rates
      sm <- ph_get_cases() %>% ph_calculate_rates()

      ## Calculation completed
      cat("\n")
      cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                          {cli::col_green('SEVERITY and MORTALITY parameters have been set.')} |
                          {cli::col_blue(cli::symbol$arrow_right)}
                          {cli::col_blue('Proceed to next parameter.')}")
      cat("\n")
    } else {
      sm <- NA
      cat("\n")
      cli::cli_alert_warning(text = "{cli::col_yellow('SEVERITY and MORTALITY parameters have NOT been set.')}")
      cat("\n")
    }
  } else {
    cat("\n")
    cli::cli_text("Calculating severity and mortality...")
    cat("\n")

    ## Calculate rates
    sm <- ph_get_cases() %>% ph_calculate_rates()

    ## Calculation completed
    cat("\n")
    cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                          {cli::col_green('SEVERITY and MORTALITY parameters have been set.')} |
                          {cli::col_blue(cli::symbol$arrow_right)}
                          {cli::col_blue('Proceed to next parameter.')}")
    cat("\n")
  }

  ##
  return(sm)
}
