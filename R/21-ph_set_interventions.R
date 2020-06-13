################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation intervention parameters
#'
#' @return A list of Philippines-specific CoMo model intervention parameters
#'
#' @examples
#' if(interactive()) ph_set_interventions()
#'
#' @export
#'
#
################################################################################

ph_set_interventions <- function() {
  ## Lockdown
  lockdown <- ph_set_lockdown()

  ## Self-isolation
  isolation <- ph_set_isolation()

  ## Social distancing
  distancing <- ph_set_distancing()

  ## Handwashing
  handwashing <- ph_set_handwashing()

  ## Work from home
  work <- ph_set_work()

  ## Schools closure
  school <- ph_set_school()

  ## Shielding the elderly
  cocoon <- ph_set_cocoon()

  ## Travel ban
  travel <- ph_set_travel()

  ## Voluntary home auarantine
  quarantine <- ph_set_quarantine()

  ## Vaccination
  vaccination <- ph_set_vaccination()

  ## Concatenate params
  params <- list(lockdown, isolation, distancing, handwashing, work, school,
                 cocoon, travel, quarantine, vaccination)

  names(params) <- c("lockdown", "isolation", "distancing", "handwashing",
                     "work", "school", "cocoon", "travel", "quarantine",
                     "vaccination")

  ## Return params
  return(params)
}




