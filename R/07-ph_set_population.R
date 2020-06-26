################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation parameters for population
#'
#' @return A data.frame of Philippines-specific CoMo model parameters for
#'   population
#'
#' @examples
#' ph_set_population()
#'
#' @export
#'
#
################################################################################

ph_set_population <- function() {
  ## Header
  cli::cli_h1(text = "Setting CoMo modelling POPULATION parameters for the Philippines")
  cat("\n")

  ## Check if interactive
  if(interactive()) {
    ## Confirm if ready to proceed
    set_params <- utils::menu(choices = c("Yes", "No"),
                              title = "Are you ready to proceed?")

    ## Check user response
    if(set_params == 1) {
      cat("\n")
      cli::cli_text(text = "Reading demographic data...")
      cat("\n")

      ## Read population data
      pop <- population_wpp_2019

      ## Read births data
      birth <- births_wpp_2019

      ## Read deaths data
      death <- deaths_wpp_2019

      ## Concatenate demographics
      pop <- data.frame(pop[ , c("area", "year", "age_category", "total")],
                        birth[ , "birth"],
                        death[ , "death"],
                        stringsAsFactors = FALSE)

      ##
      cat("\n")
      cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                            {cli::col_green('POPULATION parameters have been set.')} |
                            {cli::col_blue(cli::symbol$arrow_right)}
                            {cli::col_blue('Proceed to next parameter.')}")
      cat("\n")
    } else {
      pop <- NA
      cli_alert_warning("{cli::col_yellow('POPULATION parameters have NOT been set.')}")
      cat("\n")
    }
  } else {
    cat("\n")
    cli::cli_text(text = "Reading demographic data...")
    cat("\n")

    ## Read population data
    pop <- population_wpp_2019

    ## Read births data
    birth <- births_wpp_2019

    ## Read deaths data
    death <- deaths_wpp_2019

    ## Concatenate demographics
    pop <- data.frame(pop[ , c("area", "year", "age_category", "total")],
                      birth[ , "birth"],
                      death[ , "death"],
                      stringsAsFactors = FALSE)

    ##
    cat("\n")
    cli::cli_text(text = "{cli::col_green(cli::symbol$tick)}
                          {cli::col_green('POPULATION parameters have been set.')} |
                          {cli::col_blue(cli::symbol$arrow_right)}
                          {cli::col_blue('Proceed to next parameter.')}")
    cat("\n")
  }

  ## Return demographic parameters
  return(pop)
}
