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
  ## Check current date and time to see what date is the most recently
  ## available cases data
  if(!lubridate::now(tzone = "UTC") %within%
     lubridate::interval(lubridate::ymd_hms(paste(Sys.Date(),
                                                  "12:00:00 UTC",
                                                  sep = "")),
                         lubridate::ymd_hms(paste(Sys.Date(),
                                                  "23:59:59 UTC",
                                                  sep = "")))) {
    refDate <- Sys.Date()
  } else {
    refDate <- lubridate::ymd(Sys.Date()) - lubridate::days(1)
  }

  ## Get cases and deaths specific to Philippines
  cases <- ph_calculate_cases(date = refDate)

  ## Get severity and mortality
  sm <- ph_calculate_rates(date = refDate)

  ## Set population parameters
  pop <- ph_set_population()

  ## Set general parameters
  general <- ph_set_general()

  ## Set virus parameters
  virus <- ph_set_virus()

  ## Set hospital parameters
  hospital <- ph_set_hospital()

  ## Set interventions parameters
  interventions <- ph_set_interventions()

  ## Concatenate params
  params <- list(cases, sm, pop, general, virus, hospital, interventions)

  ## Return params
  return(params)
}




