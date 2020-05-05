################################################################################
#
#'
#' Set Philippines-specific CoMo model simulation social distancing intervention
#' parameters
#'
#' @return A list of Philippines-specific CoMo model social distancing
#' intervention parameters
#'
#' @examples
#' if(interactive()) ph_set_distancing()
#'
#' @export
#'
#
################################################################################

ph_set_distancing <- function() {
  ## Header
  cat("================================================================================\n")
  cat("\n")
  cat("Setting CoMo modelling SOCIAL DISTANCING intervention parameters for the Philippines\n")
  cat("\n")
  cat("================================================================================\n")
  cat("\n")
  ## Confirm if ready to proceed
  set_params <- utils::menu(choices = c("Yes", "No"),
                            title = "Are you ready to proceed?")

  ## Input social distancing intervention parameters
  if(set_params == 1) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    dist <- menu(choices = c("Yes", "No"),
                     title = "Has social distancing intervention been implemented?")
    cat("\n")

    if(dist == 1) {
      ## Set dist variable as TRUE
      dist <- TRUE

      ## Calculate comparison values for dates
      intStart <- lubridate::ymd("2019-12-01")
      intEnd <- lubridate::ymd(Sys.Date()) - lubridate::weeks(4)
      startEnd <- interval(start = intStart, end = intEnd)

      ## Input social distancing parameters
      cat("\n")
      cat("When was social distancing intervention started?\n")
      cat("\n")
      repeat {
        ## Start date of self-isolation
        date_dist_on <- readline(prompt = "Start date (DD/MM/YYY): ")

        ## Check if date provided is in correct format
        if(is.na(lubridate::dmy(date_dist_on, quiet = TRUE))){
          cat("\n")
          cat("Social distancing starting date is not in DD/MM/YYYY format. Try again.\n")
          cat("\n")
        } else {
          ## Check if date is within plausible range of dates
          if(!lubridate::dmy(date_dist_on) %within% startEnd) {
            cat("\n")
            cat("Social distancing starting date is not within plausible dates. Try again.\n")
            cat("\n")
          }
        }

        ## Check if date is in correct format and plausible
        if(!is.na(lubridate::dmy(date_dist_on, quiet = TRUE))) {
          if(lubridate::dmy(date_dist_on) %within% startEnd) break
        }
      }

      ## Input duration of social distancing
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("How long is the social distancing intervention for?\n")
      cat("\n")
      repeat {
        ## Social distancing duration
        dist_dur <- readline(prompt = "Duration (weeks): ")

        ## Check that social distancing duration is in correct format
        if(is.na(dist_dur) | dist_dur == "") {
          cat("\n")
          cat("Duration of social distancing should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = dist_dur, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Duration of social distancing should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(dist_dur) <= 0) {
              cat("\n")
              cat("Duration of social distancing cannot be 0 weeks or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(dist_dur) > 52) {
              cat("\n")
              cat("Duration of social distancing cannot be greater than 52 weeks. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = dist_dur, pattern = "[0-9]")) {
          if(as.numeric(dist_dur) > 0 &
             as.numeric(dist_dur) <= 52) break
        }
      }

      ## Input social distancing coverage
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of social distancing coverage?\n")
      cat("\n")
      repeat {
        ## Social distancing coverage
        dist_cov <- readline(prompt = "Coverage of social distancing (numeric; %): ")

        ## Check that social distancing coverage is in correct format
        if(is.na(dist_cov) | dist_cov == "") {
          cat("\n")
          cat("Social distancing coverage should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = dist_cov, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Coverage of social distancing should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(dist_cov) <= 0) {
              cat("\n")
              cat("Coverage of social distancing cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(dist_cov) > 100) {
              cat("\n")
              cat("Coverage of social distancing cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = dist_cov, pattern = "[0-9]")) {
          if(as.numeric(dist_cov) > 0 &
             as.numeric(dist_cov) <= 100) break
        }
      }

      ## Input social distancing adherence
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("What is the level of social distancing adherence?\n")
      cat("\n")
      repeat {
        ## Social distancing adherence
        dist_eff <- readline(prompt = "Adherence to social distancing (numeric; %): ")

        ## Check that social distancing adherence is in correct format
        if(is.na(dist_eff) | dist_eff == "") {
          cat("\n")
          cat("Social distancing adherence should be provided. Try again.\n")
          cat("\n")
        } else {
          if(stringr::str_detect(string = dist_eff, pattern = "[a-zA-Z]")) {
            cat("\n")
            cat("Adherence to social distancing should be numeric. Try again.\n")
            cat("\n")
          } else {
            if(as.numeric(dist_eff) <= 0) {
              cat("\n")
              cat("Adherence to social distancing cannot be 0% or less. Try again.\n")
              cat("/n")
            }
            if(as.numeric(dist_eff) > 100) {
              cat("\n")
              cat("Adherence to social distancing cannot be greater than 100%. Try again.\n")
              cat("\n")
            }
          }
        }

        ## If in correct format, go to next
        if(stringr::str_detect(string = dist_eff, pattern = "[0-9]")) {
          if(as.numeric(dist_eff) > 0 &
             as.numeric(dist_eff) <= 100) break
        }
      }
    } else {
      ## Set params to NA
      dist         <- FALSE
      date_dist_on <- NA
      dist_dur     <- NA
      dist_cov     <- NA
      dist_eff     <- NA
      cat("\n")
      cat("================================================================================\n")
      cat("\n")
      cat("SOCIAL DISTANCING intervention has not been implemented yet. Proceed to next intervention.\n")
      cat("\n")
    }
  } else {
    ## Set params to NA
    dist         <- FALSE
    date_dist_on <- NA
    dist_dur     <- NA
    dist_cov     <- NA
    dist_eff     <- NA
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("SOCIAL DISTANCING intervention parameters have NOT been set.\n")
    cat("\n")
  }

  if(all(!is.na(list(dist, date_dist_on, dist_dur, dist_cov, dist_eff)))) {
    cat("\n")
    cat("================================================================================\n")
    cat("\n")
    cat("SOCIAL DISTANCING intervention parameters have been set. Proceed to next intervention.\n")
    cat("\n")
  }

  ## Concatenate params
  params <- list(dist, date_dist_on,
                 as.numeric(dist_dur),
                 as.numeric(dist_cov),
                 as.numeric(dist_eff))

  ##
  names(params) <- c("dist", "date_dist_on", "dist_dur", "dist_cov", "dist_eff")

  ## Return params
  return(params)
}




