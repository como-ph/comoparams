################################################################################
#
#'
#' Get Philippines population estimates for 2015 and projections for 2016-2025
#' based on the results of the Philippines 2015 POPCEN
#'
#' @param file Either a path or a URL to the 2015 POPCEN XLSX file containing
#'   population projections
#'
#' @return A tibble in tidy format containing population data by 5-year age
#'   groups for the entire Philippines and by region from 2015 (estimates) to
#'   2025 (projections)
#'
#' @examples
#' \dontrun{
#' link <- with(dataSources,
#'              link[source == "PSA" & parameter == "population"])
#' ph_get_psa2015_pop(file = link)
#' }
#'
#' @export
#'
#
################################################################################

ph_get_psa2015_pop <- function(file) {
  ## Create a concatenating data.frame
  df <- data.frame()
  ## Loop through the different years up to 2024
  for(i in seq(from = 1, to = 35, by = 7)) {
    x <- openxlsx::read.xlsx(xlsxFile = file,
                             rows = 6:2026, cols = i:(i + 6))
    ## Create concatenating data.frame
    temp <- data.frame()
    ## Loop through all areas
    for(j in seq(from = 2, to = nrow(x), by = 19)) {
      ## Get current area
      y <- x[j:(j + 17), ]
      y1 <- data.frame()
      y2 <- data.frame()
      y3 <- data.frame()
      ## Loop through current 2 year period
      for(k in seq(from = 2015, to = 2024, by = 2)) {
        y1 <- rbind(y1, data.frame(Year = rep(k, nrow(y)), y[ , 1:4]))
        y2 <- rbind(y2, data.frame(Year = rep(k + 1, nrow(y)), y[ , 1:4]))
      }
      ## Concatenate all data.frame for all areas for 2 year periods
      y3 <- rbind(y3, rbind(y1, y2))
      ## Create Area variable
      y <- data.frame(Area = rep(x[j - 1, 1], nrow(y)), y3)
      ## Concatenate all data.frames for all areas for 2 year periods
      temp <- rbind(temp, y)
    }
    ## Concatenate all data.frames for 2015 to 2024 for all areas
    df <- rbind(df, temp)
  }
  ## Read data from 2025 projections
  x <- openxlsx::read.xlsx(xlsxFile = file,
                           rows = 6:2026, cols = 36:39)
  ## Create concatenating data.frame for 2025 projections
  temp <- data.frame()
  ## Loop through 2025 projections for each area
  for(j in seq(from = 2, to = nrow(x), by = 19)) {
    y <- x[j:(j + 17), ]
    y <- data.frame(Year = rep(2015, nrow(y)), y)
    y <- data.frame(Area = rep(x[j - 1, 1], nrow(y)), y)
    temp <- rbind(temp, y)
  }
  ## Concatenate all data.frames for all years and for all areas
  df <- rbind(df, temp)
  ## Adjust area names for consistency
  df$Area <- stringr::str_to_title(string = df$Area)
  ## Remove total rows
  df <- df[df$X1 != "Total", ]
  ## Rename df
  names(df) <- c("area", "year", "age_category", "total", "male", "female")
  ## Convert df to tibble
  df <- tibble::tibble(df)
  ##
  return(df)
}


################################################################################
#
#'
#' Get Philippines population estimates or projections by 5-year age groups
#' given a year or range of years from the World Population Prospects 2019
#'
#' @param file Either a path or a URL to the World Population Prospects 2019
#'   file containing population estimates and projections in 5-year age groups
#' @param location Location to get population estimates/projections for;
#'   Default to the "Philippines"
#' @param period A year (numeric) or range of years (YYYY:YYYY) to get population
#'   estimates/projections for; Default to current year.
#'
#' @return A tibble in tidy format containing population data by 5-year age
#'   groups for the entire Philippines and by region from 2015 (estimates) to
#'   2025 (projections)
#'
#' @examples
#' \dontrun{
#' link <- with(dataSources,
#'              link[source == "WPP" & parameter == "population"])
#' ph_get_wpp2019_pop(file = link)
#' }
#'
#' @export
#'
#
################################################################################

ph_get_wpp2019_pop <- function(file,
                               location = "Philippines",
                               period = lubridate::year(Sys.Date())) {
  ## Read file
  x <- utils::read.csv(file = file, stringsAsFactors = FALSE)
  ## Extract the specific location and year and only the needed columns
  df <- x[x$Location == location & x$Time %in% period,
          c("Location", "Time", "AgeGrp", "PopTotal", "PopMale", "PopFemale")]
  ## Rename df compatible to CoMo requirements
  names(df) <- c("area", "year", "age_category", "total", "male", "female")
  ## Make age_category compatible with CoMo template
  df$age_category <- paste(df$age_category, "y.o.", sep = " ")
  ## Report exact population estimates (multiple by 1000)
  df[ , c("total", "male", "female")] <- df[ , c("total", "male", "female")] * 1000
  ## Conver df to tibble
  df <- tibble::tibble(df)
  ## Return df
  return(df)
}


################################################################################
#
#'
#' Get Philippines age-specific number of births estimates or projections
#' by 5-year periods given a year or range of years from the World Population
#' Prospects 2019
#'
#' @param file Either a path or a URL to the World Population Prospects 2019
#'   file containing population estimates and projections in 5-year age groups
#' @param location Location to get population estimates/projections for;
#'   Default to the "Philippines"
#' @param period A year (numeric) or range of years (YYYY:YYYY) in 5 year
#'   intervals starting from 1950 to get population estimates/projections for;
#'   Default is current year corresponding to the five year period that
#'   contains the current year
#'
#' @return A tibble in tidy format containing age-specific number of births
#'   for the entire Philippines from 1950 to 2100
#'
#' @examples
#' \dontrun{
#' link <- with(dataSources,
#'              link[source == "WPP" & parameter == "births"])
#' ph_get_wpp2019_births(file = link, period = 2019)
#' }
#'
#' @export
#'
#
################################################################################

ph_get_wpp2019_births <- function(file,
                                  location = "Philippines",
                                  period = lubridate::year(Sys.Date())) {
  df <- openxlsx::read.xlsx(xlsxFile = file, sheet = 1, startRow = 17)
  df <- df[ , c(3, 8:15)]
  df <- tidyr::pivot_longer(data = df,
                            cols = "15-19":"45-49",
                            names_to = "age_category",
                            values_to = "birth")
  ## Rename df
  names(df) <- c("area", "year", "age_category", "birth")
  ## Make age_category compatible with CoMo template
  df$age_category <- paste(df$age_category, "y.o.", sep = " ")
  ## Check if period is a range of years
  if(length(period) > 1) {
    period <- paste(period[1], utils::tail(period, 1), sep = "-")
    df <- df[df$area == location & df$year == period, ]
  } else {
    ## Create 5-year group vector
    yrGrp <- levels(cut(1950:2100,
                        breaks = seq(from = 1950, to = 2100, by = 5),
                        right = FALSE,
                        include.lowest = TRUE))
    yrGrp <- stringr::str_remove_all(string = yrGrp, pattern = "\\[|\\)|]")
    yrGrp <- stringr::str_replace_all(string = yrGrp, pattern = ",", replacement = "-")
    ## Convert single year to 5-year group
    t <- stringr::str_replace_all(string = yrGrp, pattern = "-", replacement = ":")
    u <- NULL
    ## Cycle through various year groups
    for(i in seq_len(length(t))) {
      u[i] <- period %in% eval(parse(text = t[i]))[1:5]
    }
    ## Convert single year to 5-year groups
    period <- yrGrp[u]
    ## Get df specific to location and time
    df <- df[df$area == location & df$year == period, ]
  }
  ##
  df$birth <- as.numeric(df$birth) * 1000
  ## Fill empty rows
  xx <- data.frame(area = rep("Philippines", 3),
                   year = period,
                   age_category = c("0-4 y.o.", "5-9 y.o", "10-14 y.o."),
                   birth = NA)
  yy <- data.frame(area = rep("Philippines", 11),
                   year = period,
                   age_category = c("50-54 y.o.", "55-59 y.o.",
                                    "60-64 y.o.", "65-69 y.o.",
                                    "70-74 y.o.", "75-79 y.o.",
                                    "80-84 y.o.", "85-89 y.o.",
                                    "90-94 y.o.", "95-99 y.o.", "100+ y.o."),
                   birth = NA)
  ## Rename
  names(xx) <- names(yy) <- c("area", "year", "age_category", "birth")
  ## Concatenate data.frames
  df <- rbind(xx, df, yy)
  ## Convert df to tibble
  df <- tibble::tibble(df)
  ## Return df
  return(df)
}


################################################################################
#
#'
#' Get Philippines number of deaths estimates or projections by 5-year periods
#' given a year or range of years from the World Population Prospects 2019
#'
#' @param file Either a path or a URL to the World Population Prospects 2019
#'   file containing population estimates and projections in 5-year age groups
#' @param location Location to get population estimates/projections for;
#'   Default to the "Philippines"
#' @param period A year (numeric) or range of years (YYYY:YYYY) in 5 year
#'   intervals starting from 1950 to get population estimates/projections for;
#'   Default is current year corresponding to the five year period that
#'   contains the current year
#'
#' @return A tibble in tidy format containing age-specific number of deaths
#'   for the entire Philippines from 1950 to 2100
#'
#' @examples
#' \dontrun{
#' link <- with(dataSources,
#'              link[source == "WPP" & parameter == "deaths"])
#' ph_get_wpp2019_deaths(file = link, period = 2019)
#' }
#'
#' @export
#'
#
################################################################################

ph_get_wpp2019_deaths <- function(file,
                                  location = "Philippines",
                                  period = lubridate::year(Sys.Date())) {
  df <- openxlsx::read.xlsx(xlsxFile = file, sheet = 1, startRow = 17)
  df <- df[ , c(3, 8:28)]
  df$`95-99` <- df$`95+`
  df$`100+` <- df$`95+`
  df <- df[ , c(1:21, 23:24)] %>%
    tidyr::pivot_longer(cols = "0-4":"100+",
                        names_to = "age_category",
                        values_to = "death")
  ## Rename df
  names(df) <- c("area", "year", "age_category", "death")
  ## Make age_category compatible with CoMo template
  df$age_category <- paste(df$age_category, "y.o.", sep = " ")
  ##
  if(length(period) > 1) {
    period <- paste(period[1], utils::tail(period, 1), sep = "-")
    df <- df[df$area == location & df$year == period, ]
  } else {
    ## Create 5-year group vector
    yrGrp <- levels(cut(1950:2020,
                        breaks = seq(from = 1950, to = 2020, by = 5),
                        right = FALSE,
                        include.lowest = TRUE))
    yrGrp <- stringr::str_remove_all(string = yrGrp, pattern = "\\[|\\)|]")
    yrGrp <- stringr::str_replace_all(string = yrGrp, pattern = ",", replacement = "-")
    ## Convert single year to 5-year group
    t <- stringr::str_replace_all(string = yrGrp, pattern = "-", replacement = ":")
    u <- NULL
    ## Cycle through various year groups
    for(i in seq_len(length(t))) {
      u[i] <- period %in% eval(parse(text = t[i]))[1:5]
    }
    ## Convert single year to 5-year groups
    period <- yrGrp[u]
    ## Get df specific to location and time
    df <- df[df$area == location & df$year == period, ]
  }
  ## Convert deaths to 1000
  df$death <- as.numeric(df$death) * 1000
  ## Convert df to tibble
  df <- tibble::tibble(df)
  ## Return df
  return(df)
}






