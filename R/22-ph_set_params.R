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
  ## Get cases and deaths specific to Philippines
  cases <- ph_set_cases()

  ## Get severity and mortality
  sm <- ph_set_severe()

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




