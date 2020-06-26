################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for COVID-19 cases
#'
#' @return A data.frame of Philippines-specific CoMo model parameters for
#'   COVID-19 cases
#'
#' @examples
#' ph_set_cases()
#'
#' @export
#'
#
################################################################################

ph_set_cases <- function() {
  ## Header
  cli::cli_h1(text = "Setting CoMo modelling CASES parameters for the Philippines")
  cat("\n")

  ## Check if interactive
  if(interactive()) {

    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Check user answer
    if(set_params == 1) {
      cat("\n")
      cli::cli_text(text = "Calculating cases...")
      cat("\n")

      ## Calculate cases
      cases <- ph_get_cases() %>% ph_calculate_cases()

      ## Calculation completed
      cat("\n")
      cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                            {cli::col_green('CASES parameters have been set.')} |
                            {cli::col_blue(cli::symbol$arrow_right)}
                            {cli::col_blue('Proceed to next parameter.')}")
      cat("\n")
    } else {
      cases <- NA
      cat("\n")
      cli::cli_alert_warning("{cli::col_yellow('CASES parameters have NOT been set.')}")
      cat("\n")
    }
  } else {
    cat("\n")
    cli::cli_text(text = "Calculating cases...")
    cat("\n")

    ## Calculate cases
    cases <- ph_get_cases() %>% ph_calculate_cases()

    ## Calculation completed
    cat("\n")
    cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                          {cli::col_green('CASES parameters have been set.')} |
                          {cli::col_blue(cli::symbol$arrow_right)}
                          {cli::col_blue('Proceed to next parameter.')}")
    cat("\n")
  }

  ## Return results
  return(cases)
}
