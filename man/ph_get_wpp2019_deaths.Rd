% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/04-ph_get_population.R
\name{ph_get_wpp2019_deaths}
\alias{ph_get_wpp2019_deaths}
\title{Get Philippines number of deaths estimates or projections by 5-year periods
given a year or range of years from the World Population Prospects 2019}
\usage{
ph_get_wpp2019_deaths(
  file,
  location = "Philippines",
  period = lubridate::year(Sys.Date())
)
}
\arguments{
\item{file}{Either a path or a URL to the World Population Prospects 2019
file containing population estimates and projections in 5-year age groups}

\item{location}{Location to get population estimates/projections for;
Default to the "Philippines"}

\item{period}{A year (numeric) or range of years (YYYY:YYYY) in 5 year
intervals starting from 1950 to get population estimates/projections for;
Default is current year corresponding to the five year period that
contains the current year}
}
\value{
A tibble in tidy format containing age-specific number of deaths
  for the entire Philippines from 1950 to 2100
}
\description{
Get Philippines number of deaths estimates or projections by 5-year periods
given a year or range of years from the World Population Prospects 2019
}
\examples{
\dontrun{
link <- with(dataSources,
             link[source == "WPP" & parameter == "deaths"])
ph_get_wpp2019_deaths(file = link, period = 2019)
}

}
