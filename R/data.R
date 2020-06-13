################################################################################
#
#' Table of data sources used for parameters
#'
#' @format A tibble with 5 columns and 8 rows:
#' \describe{
#'   \item{\code{description}}{Description of data source}
#'   \item{\code{parameter}}{Model parameter data source addresses}
#'   \item{\code{source}}{Issuing authority or body of the data source}
#'   \item{\code{scode}}{Source code}
#'   \item{\code{format}}{Format of the data available from the data source}
#'   \item{\code{link}}{URL for data source}
#' }
#'
#' @examples
#' dataSources
#'
#'
#
################################################################################
"dataSources"


################################################################################
#
#' The Philippines 2015 Census of Population (POPCEN 2015)
#'
#' @format A tibble with 6 columns and 87567 rows:
#' \describe{
#'   \item{\code{area}}{Area (i.e., country, region, municipality, city) in
#'     the Philippines}
#'   \item{\code{year}}{Year (2015 to 2024)}
#'   \item{\code{age_category}}{Five-year age groups}
#'   \item{\code{total}}{Total population}
#'   \item{\code{male}}{Male population}
#'   \item{\code{female}}{Female population}
#' }
#'
#' @source Philippines Statistics Authority
#'
#' @examples
#' population_psa_2015
#'
#'
#
################################################################################
"population_psa_2015"


################################################################################
#
#' The Philippines population for 2020 from the World Population Prospects 2019
#'
#' @format A tibble with 6 columns and 21 rows:
#' \describe{
#'   \item{\code{area}}{Area i.e., country}
#'   \item{\code{year}}{Year i.e., 2020}
#'   \item{\code{age_category}}{Five-year age groups}
#'   \item{\code{total}}{Total population}
#'   \item{\code{male}}{Male population}
#'   \item{\code{female}}{Female population}
#' }
#'
#' @source World Population Prospects 2019
#'
#' @examples
#' population_wpp_2019
#'
#'
#
################################################################################
"population_wpp_2019"


################################################################################
#
#' The Philippines births by age group of mother for 2020 from the World
#' Population Prospects 2019
#'
#' @format A tibble with 4 columns and 21 rows:
#' \describe{
#'   \item{\code{area}}{Area i.e., country}
#'   \item{\code{year}}{Year i.e., 2015-2020}
#'   \item{\code{age_category}}{Five-year age groups}
#'   \item{\code{birth}}{Number of births}
#' }
#'
#' @source World Population Prospects 2019
#'
#' @examples
#' births_wpp_2019
#'
#'
#
################################################################################
"births_wpp_2019"


################################################################################
#
#' The Philippines deaths by age group for 2020 from the World
#' Population Prospects 2019
#'
#' @format A tibble with 4 columns and 21 rows:
#' \describe{
#'   \item{\code{area}}{Area i.e., country}
#'   \item{\code{year}}{Year i.e., 2015-2020}
#'   \item{\code{age_category}}{Five-year age groups}
#'   \item{\code{death}}{Number of deaths}
#' }
#'
#' @source World Population Prospects 2019
#'
#' @examples
#' deaths_wpp_2019
#'
#'
#
################################################################################
"deaths_wpp_2019"
