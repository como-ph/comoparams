# comoparams 0.1.1.9000

* Revised README using tables

* Updated vignette on CoMo model

* Created new package hex sticker




# comoparams 0.1.0.9000

* Created pull data functions for the Department of Health COVID-19 Data Drop initially using a Google Sheets interface and then shifting to a Google Drive interface

* Updated pull data functions to adapt to changes made by the Department of Health on the COVID-19 DataDrop Google Drive directory structure

* Updated pull data functions to adapt to a shift in date value specifications starting from datasets published on 2020-05-05

* Created a calculate rates function to organise and structure data on case information into format compatible with CoMo model parameters requirement and for calculating infection fatality rate (IFR), infection hospitalisation rate (IHR), and hospitalisation fatality rate (HFR)

* Created parameter setting functions to provide interactive assistance in putting together the informaiton needed for the model parameters

* Added a `NEWS.md` file to track changes to the package.

* Created `pkgdown` site using `flatly` bootstrap template consistent with stylesheet used for the CoMo app.

* Created CI/CD setup using Travis [![Travis build status](https://travis-ci.org/como-ph/comoparams.svg?branch=master)](https://travis-ci.org/como-ph/comoparams) and Appveyor [![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/como-ph/comoparams?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comoparams)

