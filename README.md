
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comoparams: R utility tool to extract, process and structure Philippines-specific datasets for use in CoMo Consortium model

<!-- badges: start -->

[![Travis build
status](https://travis-ci.com/como-ph/comoparams.svg?branch=master)](https://travis-ci.com/como-ph/comoparams)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/como-ph/comoparams?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comoparams)
<!-- badges: end -->

The Oxford Modelling Group for Global Health (OMGH) is developing model
structures to estimate the impact of potential mitigation strategies. By
changing the input data and parameter values, the models can be adjusted
to represent a national or subnational setting. In addition, a user
friendly application and interface is being developed to enable
widespread utility.

The CoMo-PH group is the Philippines country team that is supporting the
use of the model specific to the Philppines as part of the COVID-19
International Modeling Consortium (CoMo Consortium).

This package has been developed by the CoMo-PH group to support its
efforts in the collection of Philippines-specific and
Philppines-appropriate data that will define the parameters used in the
CoMo model as applied to the Philippines. This package facilitates the
processing of Philippines national and/or subnational input data and
parameter values into data structures appropriate for use with the
modelling application and/or other packages developed for the CoMo
Consortium model.

## Installation

`comoparams` is available to install via
[GitHub](https://github.com/como-ph/comoparams):

``` r
if(!requireNamespace(remotes)) install.packages("remotes")
remotes::install_github("como-ph/comoparams")
```
