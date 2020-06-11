################################################################################
#
#'
#' Calculate infection fatality rate (IFR), infection hospitalisation rate, and
#' hospitalisation fatality rate (HFR) from Philippines data
#'
#' @param df A data.frame of cases data pulled from the Philippines COVID-19
#'   Data Drop.
#'
#' @return A data.frame with calculated IHR, IFR, and HFR by age group structure
#'   consistent with CoMo model data structure requirements.
#'
#' @examples
#' df <- ph_get_cases()
#' ph_calculate_rates(df = df)
#'
#' @export
#'
#'
#
################################################################################

ph_calculate_rates <- function(df) {
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
#' @param df A data.frame of cases data pulled from the Philippines COVID-19
#'   Data Drop.
#'
#' @return Value for probability of dying when hospitalised.
#'
#' @examples
#' df <- ph_get_cases()
#' ph_calculate_pdeath(df = df)
#'
#' @export
#'
#
################################################################################

ph_calculate_pdeath <- function(df) {
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
#' @param df A data.frame of cases data pulled from the Philippines COVID-19
#'   Data Drop.
#'
#' @return Value for duration of hospitalised infection.
#'
#' @examples
#' df <- ph_get_cases()
#' ph_calculate_nus(df = df)
#'
#' @export
#'
#
################################################################################

ph_calculate_nus <- function(df) {
  x <- tryCatch(lubridate::dmy(df$DateRecover) - lubridate::dmy(df$DateRepConf),
                warning = function(e) e)
  ##
  if(any(class(x) == "warning")) {
    x <- lubridate::ymd(df$DateRecover) - lubridate::ymd(df$DateRepConf)
  }
  ##
  y <- stats::t.test(x)
  ##
  return(y)
}
