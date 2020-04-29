################################################################################
#
#'
#' Calculate daily cases and daily deaths from Philippines COVID-19 Data Drop
#'
#' @param date Date in <YYYY-MM-DD> format; This is the date up to which
#'   extracted data reports to. Default is current date (\code{Sys.Date()})
#'
#' @return A data.frame with calculated number of cases per and number of deaths
#'   per day with structure consistent with CoMo model data structure
#'   requirements.
#'
#' @examples
#' ph_calculate_cases(date = "2020-04-17")
#'
#' @export
#'
#
################################################################################

ph_calculate_cases <- function(date = Sys.Date()) {
  ## Get dataset
  df <- ph_get_cases(date = date)
  ## Create reporting date vector
  repDate <- seq.Date(from = as.Date("2020-01-01"), to = Sys.Date(), by = 1)
  ## Recode cases and deaths
  cases <- 1
  deaths <- ifelse(df$RemovalType != "Died" | is.na(df$RemovalType), 0, 1)
  ##
  x <- data.frame(df[ , "DateRepConf"], cases)
  #x$DateRepConf <- lubridate::mdy(x$DateRepConf)
  x$DateRepConf <- lubridate::dmy(x$DateRepConf)
  ##
  y <- data.frame(df[ , "DateDied"], deaths)
  #y$DateDied <- lubridate::mdy(y$DateDied)
  y$DateDied <- lubridate::dmy(y$DateDied)
  ##
  dailyCases <- stats::aggregate(cases ~ DateRepConf,
                                 data = x[ , c("DateRepConf", "cases")],
                                 FUN = sum, drop = FALSE)
  dailyCases <- merge(data.frame(repDate), dailyCases,
                      by.x = "repDate", by.y = "DateRepConf", all.x = TRUE)
  dailyCases$cases <- ifelse(is.na(dailyCases$cases), 0, dailyCases$cases)
  ##
  dailyDeaths <- stats::aggregate(deaths ~ DateDied,
                                  data = y[ , c("DateDied", "deaths")],
                                  FUN = sum, drop = FALSE)
  dailyDeaths <- merge(data.frame(repDate), dailyDeaths,
                       by.x = "repDate", by.y = "DateDied", all.x = TRUE)
  dailyDeaths$deaths <- ifelse(is.na(dailyDeaths$deaths), 0, dailyDeaths$deaths)
  ##
  casesDeaths <- merge(dailyCases, dailyDeaths, all.x = TRUE)
  ##
  return(casesDeaths)
}
