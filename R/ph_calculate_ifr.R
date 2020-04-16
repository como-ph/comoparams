################################################################################
#
#'
#' Calculate infection fatality rate (IFR) and infection hospitalisation rate
#' from Philippines data
#'
#' @param df Data.frame containing data on cases and deaths by age group.
#'   Default is data.frame pulled from DoH DataDrop pulled using
#'   \code{ph_get_cases()}
#'
#' @return A data.frame with calculated IHR and IFR by age group
#'
#' @examples
#' ph_calculate_rates()
#'
#' @export
#'
#'
#
################################################################################

ph_calculate_rates <- function(df = ph_get_cases()) {
  ## Create age group and express as factor
  labs <- cut(x = 0:100,
              breaks = seq(from = 0, to = 105, by = 5),
              right = FALSE)
  labs <- levels(labs) %>%
    stringr::str_remove_all(pattern = "\\[") %>%
    stringr::str_replace_all(pattern = ",", replacement = "-") %>%
    stringr::str_replace_all(pattern = "-105\\)", replacement = "+ y.o.") %>%
    stringr::str_replace_all(pattern = "\\)", replacement = " y.o.")
  age_category <- cut(x = df$Age,
                      breaks = seq(from = 0, to = 100, by = 5),
                      labels = labs[1:20],
                      right = FALSE)
  age_category <- as.character(age_category)
  age_category <- ifelse(is.na(age_category), labs[21], age_category)
  age_category <- factor(x = age_category, levels = labs)
  ## Recode cases and deaths
  cases <- 1
  admissions <- ifelse(df$Admitted != "Yes" | is.na(df$Admitted), 0, 1)
  deaths <- ifelse(df$RemovalType != "Died" | is.na(df$RemovalType), 0, 1)
  ##
  casesDeaths <- aggregate(cbind(deaths, admissions, cases) ~ age_category,
                           data = data.frame(age_category, deaths, cases),
                           FUN = sum)
  ##
  ifr <- casesDeaths$deaths / casesDeaths$cases
  ihr <- casesDeaths$admissions / casesDeaths$cases
  ##
  casesDeaths <- data.frame(casesDeaths, ifr, ihr)
  ##
  return(casesDeaths)
}
