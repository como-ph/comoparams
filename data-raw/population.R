library(comoparams)

## Population PSA 2015
link <- with(dataSources, link[source == "Philippines Statistics Authority" & parameter == "population"])

population_psa_2015 <- ph_get_psa2015_pop(file = link)

usethis::use_data(population_psa_2015, overwrite = TRUE, compress = "xz")

## Population World Prospects 2019 - population
link <- with(dataSources, link[scode == "WPP" & parameter == "population"])

population_wpp_2019 <- ph_get_wpp2019_pop(file = link)

usethis::use_data(population_wpp_2019, overwrite = TRUE, compress = "xz")

## Population World Prospects 2019 - births
link <- with(dataSources, link[scode == "WPP" & parameter == "births"])

births_wpp_2019 <- ph_get_wpp2019_births(file = link, period = 2019)

usethis::use_data(births_wpp_2019, overwrite = TRUE, compress = "xz")

## Population World Prospects 2019 - deaths
link <- with(dataSources, link[scode == "WPP" & parameter == "deaths"])

deaths_wpp_2019 <- ph_get_wpp2019_deaths(file = link, period = 2019)

usethis::use_data(deaths_wpp_2019, overwrite = TRUE, compress = "xz")



