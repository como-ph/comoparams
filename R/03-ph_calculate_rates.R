################################################################################
#
#'
#' Calculate infection fatality rate (IFR), infection hospitalisation rate, and
#' hospitalisation fatality rate (HFR) from Philippines data
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return A data.frame with calculated IHR, IFR, and HFR by age group structure
#'   consistent with CoMo model data structure requirements.
#'
#' @examples
#' ph_calculate_rates(date = "2020-04-17")
#'
#' @export
#'
#'
#
################################################################################

ph_calculate_rates <- function(date = Sys.Date()) {
  ## Get dataset
  df <- ph_get_cases(date = date)
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
  deathsAdmitted <- ifelse(df$RemovalType != "Died" |
                             is.na(df$RemovalType) |
                             (df$RemovalType == "Died" & admissions == 0), 0, 1)
  ##
  casesDeaths <- stats::aggregate(cbind(deaths,
                                        deathsAdmitted,
                                        admissions, cases) ~ age_category,
                                  data = data.frame(age_category,
                                                    deaths,
                                                    deathsAdmitted,
                                                    cases),
                                  FUN = sum)
  ##
  ifr <- casesDeaths$deaths / casesDeaths$cases
  ihr <- casesDeaths$admissions / casesDeaths$cases
  hfr <- casesDeaths$deathsAdmitted / casesDeaths$admissions
  ##
  casesDeaths <- data.frame(casesDeaths, ifr, ihr, hfr)
  ##
  return(casesDeaths)
}


################################################################################
#
#'
#' Calculate probability of dying when hospitalised
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return Value for probability of dying when hospitalised.
#'
#' @examples
#' ph_calculate_pdeath(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_calculate_pdeath <- function(date = Sys.Date()) {
  ## Get dataset
  df <- ph_get_cases(date = date)
  ## Recode cases and deaths
  cases <- 1
  admissions <- ifelse(df$Admitted != "Yes" | is.na(df$Admitted), 0, 1)
  deaths <- ifelse(df$RemovalType != "Died" | is.na(df$RemovalType), 0, 1)
  deathsAdmitted <- ifelse(df$RemovalType != "Died" |
                             is.na(df$RemovalType) |
                             (df$RemovalType == "Died" & admissions == 0), 0, 1)
  ##
  casesDeaths <- data.frame(cases, admissions, deaths, deathsAdmitted,
                            stringsAsFactors = FALSE)
  ##
  pdeath <- stats::prop.test(x = colSums(casesDeaths)[4],
                             n = colSums(casesDeaths)[2])
  ##
  #names(pdeath) <- "Probability of death when hospitalised"
  ##
  return(pdeath)
}


################################################################################
#
#'
#' Duration of hospitalised infection
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return Value for duration of hospitalised infection.
#'
#' @examples
#' ph_calculate_nus(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_calculate_nus <- function(date = Sys.Date()) {
  ## Get dataset
  df <- ph_get_cases(date = date)
  ##
  x <- lubridate::dmy(df$DateRecover) - lubridate::dmy(df$DateRepConf)
  ##
  y <- stats::t.test(x)
  ##
  return(y)
}
