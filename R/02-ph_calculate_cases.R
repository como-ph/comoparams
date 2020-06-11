################################################################################
#
#'
#' Calculate daily cases and daily deaths from Philippines COVID-19 Data Drop
#'
#' @param df A data.frame of cases data pulled from the Philippines COVID-19
#'   Data Drop.
#'
#' @return A data.frame with calculated number of cases per day and number
#'   of deaths per day and number of recovered per day with structure consistent
#'   with CoMo model data structure requirements.
#'
#' @examples
#' ph_calculate_cases(df = ph_get_cases())
#'
#' @export
#'
#
################################################################################

ph_calculate_cases <- function(df) {
  ## Google Drive deauthorisation
  googledrive::drive_deauth()

  ## Get current data link folder information and contents
  dropDate <- googledrive::drive_ls(googledrive::drive_get(id = "1ZPPcVU4M7T-dtRyUceb0pMAd8ickYf8o")) %>%
    dplyr::select(name) %>%
    stringr::str_extract(pattern = "[0-9]{2}/[0-9]{2}") %>%
    paste("2020", sep = "/") %>%
    lubridate::mdy()

  ## Create reporting date vector
  repDate <- seq.Date(from = as.Date("2020-01-01"),
                      to = dropDate,
                      by = 1)

  ## Recode cases and deaths
  cases <- 1
  deaths <- ifelse(df$RemovalType != "Died" | is.na(df$RemovalType), 0, 1)
  recovered <- ifelse(df$RemovalType != "Recovered" | is.na(df$RemovalType), 0, 1)

  ## convert date format for confirmed cases
  x <- data.frame(df[ , "DateRepConf"], cases)

  testDateFormat <- tryCatch(expr = lubridate::dmy(x$DateRepConf),
                             warning = function(w) w)

  if(lubridate::is.Date(testDateFormat)) {
    x$DateRepConf <- testDateFormat
  } else {
    testDateFormat <- tryCatch(expr = lubridate::mdy(x$DateRepConf),
                               warning = function(w) w)

    ##
    if(lubridate::is.Date(testDateFormat)) {
      x$DateRepConf <- testDateFormat
    } else {
      x$DateRepConf <- lubridate::ymd(x$DateRepConf)
    }
  }

  ## convert date format for deaths
  y <- data.frame(df[ , "DateDied"], deaths)

  testDateFormat <- tryCatch(expr = lubridate::dmy(y$DateDied),
                             warning = function(w) w)

  if(lubridate::is.Date(testDateFormat)) {
    y$DateDied <- testDateFormat
  } else {
    testDateFormat <- tryCatch(expr = lubridate::mdy(y$DateDied),
                               warning = function(w) w)

    ##
    if(lubridate::is.Date(testDateFormat)) {
      y$DateDied <- testDateFormat
    } else {
      y$DateDied <- lubridate::ymd(y$DateDied)
    }
  }

  ## convert date format for recovered
  z <- data.frame(df[ , "DateRecover"], recovered)

  testDateFormat <- tryCatch(expr = lubridate::dmy(z$DateRecover),
                             warning = function(w) w)

  if(lubridate::is.Date(testDateFormat)) {
    z$DateRecover <- testDateFormat
  } else {
    testDateFormat <- tryCatch(expr = lubridate::mdy(z$DateRecover),
                               warning = function(w) w)

    ##
    if(lubridate::is.Date(testDateFormat)) {
      z$DateRecover <- testDateFormat
    } else {
      z$DateRecover <- lubridate::ymd(z$DateRecover)
    }
  }

  ## Create dailyCases data.frame
  dailyCases <- stats::aggregate(cases ~ DateRepConf,
                                 data = x[ , c("DateRepConf", "cases")],
                                 FUN = sum, drop = FALSE)

  dailyCases <- merge(data.frame(repDate), dailyCases,
                      by.x = "repDate", by.y = "DateRepConf", all.x = TRUE)

  dailyCases$cases <- ifelse(is.na(dailyCases$cases), 0, dailyCases$cases)

  ## Create dailyDeaths data.frame
  dailyDeaths <- stats::aggregate(deaths ~ DateDied,
                                  data = y[ , c("DateDied", "deaths")],
                                  FUN = sum, drop = FALSE)

  dailyDeaths <- merge(data.frame(repDate), dailyDeaths,
                       by.x = "repDate", by.y = "DateDied", all.x = TRUE)

  dailyDeaths$deaths <- ifelse(is.na(dailyDeaths$deaths), 0, dailyDeaths$deaths)

  ## Create dailyRecovered data.frame
  dailyRecovered <- stats::aggregate(recovered ~ DateRecover,
                                     data = z[ , c("DateRecover", "recovered")],
                                     FUN = sum, drop = FALSE)

  dailyRecovered <- merge(data.frame(repDate), dailyRecovered,
                          by.x = "repDate", by.y = "DateRecover", all.x = TRUE)

  dailyRecovered$recovered <- ifelse(is.na(dailyRecovered$recovered), 0, dailyRecovered$recovered)

  ##
  casesDeathsRecovered <- merge(dailyCases, dailyDeaths, all.x = TRUE)
  casesDeathsRecovered <- merge(casesDeathsRecovered, dailyRecovered, all.x = TRUE)

  ##
  return(casesDeathsRecovered)
}
