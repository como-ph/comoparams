# comoparams 0.2.1.9000

* removed dependency to `curl` in data drop functions which were causing **HTML 404 and 403 errors consistently**

* replaced `curl` with `googledrive::drive_download` which sorts out the proper way of downloading from Google Drive

* added unit tests using `testthat`

* updated set parameter functions based on new CoMo Model template (v13)

* updated set parameter functions to use `cli`

# comoparams 0.2.0.9000

* updated pull functions for population

* added datasets for population

* added dataset for mapping of data sources

* updated README to describe new function specifications

* added pattern to recognise variant dates on filename of README which changed in format for 2020-06-18 (from MM/DD to MM_DD) which caused an error

* added check for bit.ly links to include http (not https) for getURL

* added codefactor checks [![CodeFactor](https://www.codefactor.io/repository/github/como-ph/comoparams/badge)](https://www.codefactor.io/repository/github/como-ph/comoparams)

# comoparams 0.1.3.9000

* Re-configured functions for pulling data from Data Drop by separating get functions from calculate functions

* Adjusted get functions to be more universal to allow for capture of new data for new months considering how Data Drop Google Drive folder/directory is organised

* Added main functionality for get functions to pull the latest release data using the dynamic link sent everyday via a PDF document

* Added GitHub actions ![R-CMD-check](https://github.com/como-ph/comoparams/workflows/R-CMD-check/badge.svg)


# comoparams 0.1.1.9000

* Revised README using tables

* Updated vignette on CoMo model

* Created new package hex sticker

* Updated pull data functions to adapt to changes made by the Department of Health on the COVID-19 DataDrop Google Drive directory structure after 27 April 2020

* Created new calculate functions for certain rates needed for model parameters: `ph_calcualte_pdeath()` for calculating probability of dying when hospitalised; `ph_calculate_nus()` for calculating duration of hospitalised infection

* Updated pull functions for COVID-19 Data Drop to account for non-standard naming of directories in the Google Drive archives

# comoparams 0.1.0.9000

* Created pull data functions for the Department of Health COVID-19 Data Drop initially using a Google Sheets interface and then shifting to a Google Drive interface

* Updated pull data functions to adapt to changes made by the Department of Health on the COVID-19 DataDrop Google Drive directory structure

* Updated pull data functions to adapt to a shift in date value specifications starting from datasets published on 2020-05-05

* Created a calculate rates function to organise and structure data on case information into format compatible with CoMo model parameters requirement and for calculating infection fatality rate (IFR), infection hospitalisation rate (IHR), and hospitalisation fatality rate (HFR)

* Created parameter setting functions to provide interactive assistance in putting together the informaiton needed for the model parameters

* Added a `NEWS.md` file to track changes to the package.

* Created `pkgdown` site using `flatly` bootstrap template consistent with stylesheet used for the CoMo app.

* Created CI/CD setup using Travis [![Travis build status](https://travis-ci.org/como-ph/comoparams.svg?branch=master)](https://travis-ci.org/como-ph/comoparams) and Appveyor [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/como-ph/comoparams?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comoparams)

