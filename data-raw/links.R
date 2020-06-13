## Create a dataset of all pointers to links

dataSources <- read.csv("data-raw/dataSources.csv", stringsAsFactors = FALSE)

dataSources <- tibble::tibble(dataSources)

usethis::use_data(dataSources, overwrite = TRUE)
