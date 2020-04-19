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
#' ph_get_pop2015(file = system.file("population/popcen2015.xlsx",
#'                                   package = "comoparams"))
#'
#' @export
#'
#
################################################################################

ph_get_pop2015 <- function(file) {
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
  ##
  df <- tibble::tibble(df)
  ##
  return(df)
}

