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
  cat("Setting CoMo modelling parameters for the Philippines")
  cat("\n")
  cat("\n")
  cat("================================================================================")
  cat("\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")
  ##
  country <- ifelse(set_params == 1, "Philippines", NULL)
  ## Input mean household size
  if(!is.null(country)) {
    cat("\n")
    cat("================================================================================")
    cat("\n")
    cat("\n")
    ## Household size
    household_size <- readline(prompt = paste("2. What is the mean household size in ", country, "/area of ", country, " where simulation is for? ", sep = ""))
  }
  ## Input mean number of infectious migrants per day
  if(!is.null(household_size)) {
    cat("\n")
    cat("================================================================================")
    cat("\n")
    cat("\n")
    ## Mean infectious migrants
    mean_imports <- readline(prompt = paste("3. What is the mean number of infectious migrants per day in ", country, "/area of ", country, "? ", sep = ""))
  }
  ## Input start date of simulation
  if(!is.null(mean_imports)) {
    cat("\n")
    cat("================================================================================")
    cat("\n")
    cat("\n")
    ## Start date of simulation
    date_range_simul_start <- readline(prompt = "4. Starting date of simulation (DD/MM/YYYY format): ")
  }
}




