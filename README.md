
<!-- README.md is generated from README.Rmd. Please edit that file -->

# comoparams: R utility tool to extract, process and structure Philippines-specific datasets for use in the CoMo Consortium Model <img src="man/figures/comoparams.png" width="200px" align="right" />

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![Travis build
status](https://travis-ci.org/como-ph/comoparams.svg?branch=master)](https://travis-ci.org/como-ph/comoparams)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/como-ph/comoparams?branch=master&svg=true)](https://ci.appveyor.com/project/como-ph/comoparams)
[![R-CMD-check](https://github.com/como-ph/comoparams/workflows/R-CMD-check/badge.svg)](https://github.com/como-ph/comoparams/actions)
[![CodeFactor](https://www.codefactor.io/repository/github/como-ph/comoparams/badge)](https://www.codefactor.io/repository/github/como-ph/comoparams)
[![DOI](https://zenodo.org/badge/255850150.svg)](https://zenodo.org/badge/latestdoi/255850150)
<!-- badges: end -->

The **Oxford Modelling Group for Global Health (OMGH)** is developing
model structures to estimate the impact of potential mitigation
strategies. By changing the input data and parameter values, the models
can be adjusted to represent a national or subnational setting. In
addition, a user friendly application and interface is being developed
to enable widespread utility.

The CoMo-PH group is the Philippines country team that is supporting the
use of the model specific to the Philippines as part of the **COVID-19
International Modeling Consortium (CoMo Consortium)**.

This R package has been developed by the **CoMo-PH** group to support
its efforts in the collection of Philippines-specific and
Philippines-appropriate data that will define the parameters used in the
**CoMo Consortium Model** as applied to the Philippines. This package
facilitates the processing of Philippines national and/or subnational
input data and parameter values into data structures appropriate for use
with the modelling application and/or other packages developed for the
**CoMo Consortium Model**.

## Installation

`comoparams` is in active development and is currently only available to
install via [GitHub](https://github.com/como-ph/comoparams):

``` r
if(!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("como-ph/comoparams")
```

To use, load the package:

``` r
library(comoparams)
```

## Usage

`comoparams` currently has three main function sets: 1) **pull data**
functions; 2) **calculate** values functions; and, 3) **parameter**
setting functions.

### Pull data

`comoparams` incorporates functions that support the extraction of data
relevant to the **CoMo Model** parameters and specific to the
Philippines. Currently, these functions allow for 1) pulling of data
from the Philippines [Department of Health’s official COVID-19
DataDrop](https://drive.google.com/drive/folders/10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP)
repository; 2) pulling of data from the [Philippines Statistics
Authority (PSA)](http://www.psa.gov.ph) [2015 Population Census (2015
POPCEN)](http://www.psa.gov.ph/content/highlights-philippine-population-2015-census-population);
and 3) pulling of population, births and deaths data from the [World
Population Prospects 2019](https://population.un.org/wpp/).

#### Pulling data from the Philippines Department of Health COVID-19 DataDrop

On the 14th of April 2020, the [Philippines Department of
Health](https://www.doh.gov.ph) released publicly its data related to
COVID-19 initially in Google Sheets format and subsequently as
comma-separated value (CSV) files stored in Google Drive. There are 4
functions in `comoparams` that interacts with the [Philippines COVID-19
DataDrop](https://drive.google.com/drive/folders/10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP).
These functions are wrapper functions utilising the `googledrive`
package functions in R. Each of these functions pulls a specific type of
data from the [COVID-19
DataDrop](https://drive.google.com/drive/folders/10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP)
repository.

  - `fields` - data describing the various fields or variables in the
    different datasets found in [COVID-19
    DataDrop](https://drive.google.com/drive/folders/10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP).

  - `cases` - data on all COVID-19 cases recorded up to the date the
    specific dataset has been released.

  - `tests` - data on tests performed and recorded up to the date the
    specific dataset has been released.

  - `daily` - data on health facilities’ daily COVID-19 specific
    equipment status.

The syntax for this set of pull functions has a common prefix of
`ph_get_` followed by the short name of the specific dataset listed
above.

All four functions in this set has two arguments - `version` and `date`.
The `version` argument is used to specify whether to pull the most
recent or current data (specified as `current`) or to pull previous data
(specified as `archive`). The default is `current`. The `date` argument
is ignored if `version` is set to current. However, if `version` is set
to `archive`, the `date` argument needs to be specified (in <YYYY-MM-DD>
format) which will determine up to which exacted data reports to. This
argument will only accept dates starting from 14 April 2020 when
[COVID-19
DataDrop](https://drive.google.com/drive/folders/10VkiUA8x7TS2jkibhSZK1gmWxFM-EoZP)
was launched.

The output of these functions is a `tibble`.

To pull the most current data on `cases`, we use the function
`ph_get_cases()` as follows:

``` r
ph_get_cases()
#> # A tibble: 29,400 x 21
#>    CaseCode   Age AgeGroup Sex   DateSpecimen DateResultRelea… DateRepConf
#>    <chr>    <dbl> <chr>    <chr> <chr>        <chr>            <chr>      
#>  1 C299320     39 35 to 39 Male  2020-06-14   2020-06-15       2020-06-19 
#>  2 C724193     47 45 to 49 Male  2020-06-15   2020-06-17       2020-06-19 
#>  3 C183117     80 80+      Fema… 2020-06-16   2020-06-17       2020-06-19 
#>  4 C225853     36 35 to 39 Fema… 2020-06-15   2020-06-16       2020-06-19 
#>  5 C424197     50 50 to 54 Male  2020-06-15   2020-06-17       2020-06-19 
#>  6 C570945     33 30 to 34 Fema… 2020-06-10   2020-06-12       2020-06-19 
#>  7 C974300     48 45 to 49 Male  2020-06-15   2020-06-16       2020-06-19 
#>  8 C876001     31 30 to 34 Male  2020-06-15   2020-06-16       2020-06-19 
#>  9 C734349     37 35 to 39 Male  2020-06-15   2020-06-16       2020-06-19 
#> 10 C455443     28 25 to 29 Male  2020-06-15   2020-06-17       2020-06-19 
#> # … with 29,390 more rows, and 14 more variables: DateDied <chr>,
#> #   DateRecover <chr>, RemovalType <chr>, DateRepRem <chr>, Admitted <chr>,
#> #   RegionRes <chr>, ProvRes <chr>, CityMunRes <chr>, CityMuniPSGC <chr>,
#> #   HealthStatus <chr>, Quarantined <chr>, DateOnset <chr>, Pregnanttab <chr>,
#> #   ValidationStatus <chr>
```

To pull the data on `cases` for up to 5 May 2020, we use the function
`ph_get_cases()` as follows:

``` r
ph_get_cases(version = "archive", date = "2020-05-05")
#> # A tibble: 9,684 x 18
#>    CaseCode   Age AgeGroup Sex   DateRepConf DateDied DateRecover RemovalType
#>    <chr>    <int> <chr>    <chr> <chr>       <chr>    <chr>       <chr>      
#>  1 C100119     31 30 to 34 Male  2020-04-12  ""       ""          ""         
#>  2 C100264     58 55 to 59 Male  2020-03-29  ""       ""          ""         
#>  3 C100648     34 30 to 34 Fema… 2020-04-16  ""       ""          ""         
#>  4 C100660     43 40 to 44 Fema… 2020-04-02  ""       "2020-04-2… ""         
#>  5 C100776     43 40 to 44 Male  2020-04-01  ""       ""          ""         
#>  6 C101015     79 75 to 79 Male  2020-04-03  ""       ""          ""         
#>  7 C101097     33 30 to 34 Male  2020-03-27  ""       ""          ""         
#>  8 C101232     31 30 to 34 Male  2020-03-21  ""       "2020-03-2… "Recovered"
#>  9 C101376     30 30 to 34 Male  2020-04-11  ""       ""          ""         
#> 10 C101483     40 40 to 44 Fema… 2020-04-14  ""       ""          ""         
#> # … with 9,674 more rows, and 10 more variables: DateRepRem <chr>,
#> #   Admitted <chr>, RegionRes <chr>, ProvRes <chr>, CityMunRes <chr>,
#> #   RegionPSGC <chr>, ProvPSGC <chr>, CityMuniPSGC <chr>, HealthStatus <chr>,
#> #   Quarantined <chr>
```

To pull the data on `cases` for up to 1 May 2020, we use the function
`ph_get_cases()` as follows:

``` r
ph_get_cases(version = "archive", date = "2020-05-01")
#> # A tibble: 8,772 x 18
#>    CaseCode   Age AgeGroup Sex   DateRepConf DateRecover DateDied RemovalType
#>    <chr>    <int> <chr>    <chr> <chr>       <chr>       <chr>    <chr>      
#>  1 C100119     30 30 to 34 Male  12-Apr-20   ""          ""       ""         
#>  2 C100264     57 55 to 59 Male  29-Mar-20   ""          ""       ""         
#>  3 C100648     33 30 to 34 Fema… 16-Apr-20   ""          ""       ""         
#>  4 C100660     42 40 to 44 Fema… 02-Apr-20   ""          ""       ""         
#>  5 C100776     42 40 to 44 Male  01-Apr-20   ""          ""       ""         
#>  6 C101015     79 75 to 79 Male  03-Apr-20   ""          ""       ""         
#>  7 C101097     33 30 to 34 Male  27-Mar-20   ""          ""       ""         
#>  8 C101232     30 30 to 34 Male  21-Mar-20   "25-Mar-20" ""       "Recovered"
#>  9 C101376     29 25 to 29 Male  11-Apr-20   ""          ""       ""         
#> 10 C101483     40 40 to 44 Fema… 14-Apr-20   ""          ""       ""         
#> # … with 8,762 more rows, and 10 more variables: DateRepRem <chr>,
#> #   Admitted <chr>, RegionRes <chr>, ProvRes <chr>, CityMunRes <chr>,
#> #   RegionPSGC <chr>, ProvPSGC <chr>, CityMuniPSGC <chr>, HealthStatus <chr>,
#> #   Quarantined <chr>
```

#### Pulling data from the Philippines Statistics Authority (PSA) 2015 Population Census (2015 POPCEN)

The last Philippines census was in 2015. A 2020 census was planned but
due to the COVID-19 pandemic, this is most likely going to be put on
hold. The [Philippines Statistics Authority
(PSA)](http://www.psa.gov.ph) provides an XLSX file for its updated 2020
population projections based on the 2015 POPCEN. This file is
downloadable from the [PSA](http://www.psa.gov.ph) website via this
[link](https://psa.gov.ph/sites/default/files/attachments/hsd/pressrelease/Updated%20Population%20Projections%20based%20on%202015%20POPCEN_0.xlsx).

A helper function with the same `ph_get_` prefix is provided by the
`comoparams` package - `ph_get_psa2015_pop()` - which downloads the XLSX
file from the [PSA](http://www.psa.gov.ph) website, reads the file and
then extracts and re-structures the population data in the file to long
format (tidy format).

The function can be called as follows:

``` r
linkToFile <- "https://psa.gov.ph/sites/default/files/attachments/hsd/pressrelease/Updated%20Population%20Projections%20based%20on%202015%20POPCEN_0.xlsx"

ph_get_psa2015_pop(file = linkToFile)
```

    #> # A tibble: 87,567 x 6
    #>    area         year age_category    total    male  female
    #>    <chr>       <dbl> <chr>           <dbl>   <dbl>   <dbl>
    #>  1 Philippines  2015 0-4          10803297 5582405 5220892
    #>  2 Philippines  2015 5-9          10827294 5588769 5238525
    #>  3 Philippines  2015 10-14        10478834 5397638 5081196
    #>  4 Philippines  2015 15-19        10176450 5194725 4981725
    #>  5 Philippines  2015 20-24         9453737 4788812 4664925
    #>  6 Philippines  2015 25-29         8348285 4246632 4101653
    #>  7 Philippines  2015 30-34         7331213 3750503 3580710
    #>  8 Philippines  2015 35-39         6732896 3442349 3290547
    #>  9 Philippines  2015 40-44         5840861 2991059 2849802
    #> 10 Philippines  2015 45-49         5276700 2676602 2600098
    #> # … with 87,557 more rows

The main limitation of the PSA population projections based on the 2015
POPCEN is that the age grouping only goes up 85+ whilst the **CoMo
Consortium Model** requires population data with an age-structure that
goes up to 95+. However, this can potentially be imputed to create the
additional older age groupings if needed/wanted.

#### Pulling population, births and deaths data from the World Population Prospects 2019

The [United Nations World Population
Prospects 2019](https://population.un.org/wpp/) provides population
projections for 152 countries with a 5-year age grouping structure
required by the **CoMo Consortium Model** which are available either as
XLSX or as CSV files. The `comoparams` package provides three functions
to extract these datasets. These functions follow the same prefix syntax
of `ph_get_` as the other pull data functions followed by a descriptor
of the data that is being pulled. The descriptors used are:

  - `wpp2019_pop` - Five-year age group structured population by male
    and female

  - `wpp2019_births` - Number of births by age of mother in 5-year age
    groups

  - `wpp2019_deaths` - Number of deaths by 5-year age groups and by male
    and female

To pull the five-year age group structured population, we make a call
for the following:

``` r
linkToFile <- "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/CSV_FILES/WPP2019_PopulationByAgeSex_Medium.csv"

ph_get_wpp2019_pop(file = linkToFile, location = "Philippines")
```

    #> # A tibble: 21 x 6
    #>    area         year age_category    total     male  female
    #>    <chr>       <int> <chr>           <dbl>    <dbl>   <dbl>
    #>  1 Philippines  2020 0-4 y.o.     10616342 5450633  5165709
    #>  2 Philippines  2020 5-9 y.o.     11397952 5846072  5551880
    #>  3 Philippines  2020 10-14 y.o.   10906801 5578251  5328550
    #>  4 Philippines  2020 15-19 y.o.   10462894 5407659  5055235
    #>  5 Philippines  2020 20-24 y.o.   10104334 5191755  4912579
    #>  6 Philippines  2020 25-29 y.o.    9479780 4807611  4672169
    #>  7 Philippines  2020 30-34 y.o.    8247197 4166778. 4080419
    #>  8 Philippines  2020 35-39 y.o.    7254730 3644549  3610181
    #>  9 Philippines  2020 40-44 y.o.    6551963 3297341  3254622
    #> 10 Philippines  2020 45-49 y.o.    5759264 2883722  2875542
    #> # … with 11 more rows

To pull the number of births by age of mother in 5-year age groups, we
make a call for the following:

``` r
linkToFile <- "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/EXCEL_FILES/2_Fertility/WPP2019_FERT_F06_BIRTHS_BY_AGE_OF_MOTHER.xlsx"

ph_get_wpp2019_births(file = linkToFile, period = 2019)
```

    #> # A tibble: 21 x 4
    #>    area        year      age_category   birth
    #>    <fct>       <fct>     <fct>          <dbl>
    #>  1 Philippines 2015-2020 0-4 y.o.          NA
    #>  2 Philippines 2015-2020 5-9 y.o           NA
    #>  3 Philippines 2015-2020 10-14 y.o.        NA
    #>  4 Philippines 2015-2020 15-19 y.o.   1358136
    #>  5 Philippines 2015-2020 20-24 y.o.   2986917
    #>  6 Philippines 2015-2020 25-29 y.o.   2594038
    #>  7 Philippines 2015-2020 30-34 y.o.   2121630
    #>  8 Philippines 2015-2020 35-39 y.o.   1239266
    #>  9 Philippines 2015-2020 40-44 y.o.    488424
    #> 10 Philippines 2015-2020 45-49 y.o.    100986
    #> # … with 11 more rows

To pull the number of deaths by 5-year age groups and by male and
female, we make a call for the following:

``` r
linkToFile <- "https://population.un.org/wpp/Download/Files/1_Indicators%20(Standard)/EXCEL_FILES/3_Mortality/WPP2019_MORT_F04_1_DEATHS_BY_AGE_BOTH_SEXES.xlsx"

ph_get_wpp2019_deaths(file = linkToFile, period = 2019)
```

    #> # A tibble: 21 x 4
    #>    area        year      age_category  death
    #>    <chr>       <chr>     <chr>         <dbl>
    #>  1 Philippines 2015-2020 0-4 y.o.     306206
    #>  2 Philippines 2015-2020 5-9 y.o.      34260
    #>  3 Philippines 2015-2020 10-14 y.o.    28539
    #>  4 Philippines 2015-2020 15-19 y.o.    59008
    #>  5 Philippines 2015-2020 20-24 y.o.    78740
    #>  6 Philippines 2015-2020 25-29 y.o.    77908
    #>  7 Philippines 2015-2020 30-34 y.o.    81415
    #>  8 Philippines 2015-2020 35-39 y.o.    96548
    #>  9 Philippines 2015-2020 40-44 y.o.   121537
    #> 10 Philippines 2015-2020 45-49 y.o.   160660
    #> # … with 11 more rows

### Calculate values

For some of the required parameters, further calculation and processing
of data is required. Specifically, the cases data needs to be processed
into number of cases and number of deaths per day since the start of the
COVID-19 pandemic in the Philippines. The cases data also needs to be
processed to calculate the infection fatality rate (IFR) and the
infection hospitalisation rate (IHR) by 5-year age groups. Two calculate
functions are available in `comoparams` for this purpose. Both functions
have the same prefix syntax of `ph_calculate_` followed by a descriptor
for the type of output calculation it will produce - `cases` for daily
cases and deaths since the first reported case in the Philippines and
`rates` for the IFR and IHR output.

The daily cases, deaths and recoveries output can be produced as
follows:

``` r
ph_get_cases() %>% ph_calculate_cases()
#> # A tibble: 172 x 4
#>    repDate    cases deaths recovered
#>    <date>     <dbl>  <dbl>     <dbl>
#>  1 2020-01-01     0      0         0
#>  2 2020-01-02     0      0         0
#>  3 2020-01-03     0      0         0
#>  4 2020-01-04     0      0         0
#>  5 2020-01-05     0      0         0
#>  6 2020-01-06     0      0         0
#>  7 2020-01-07     0      0         0
#>  8 2020-01-08     0      0         0
#>  9 2020-01-09     0      0         0
#> 10 2020-01-10     0      0         0
#> # … with 162 more rows
```

The IFR and IHR output can be produced as follows:

``` r
ph_get_cases() %>% ph_calculate_rates()
#> # A tibble: 21 x 8
#>    age_category deaths deathsAdmitted admissions cases     ifr    ihr     hfr
#>    <fct>         <dbl>          <dbl>      <dbl> <dbl>   <dbl>  <dbl>   <dbl>
#>  1 0-5 y.o.         13              6         83   402 0.0323  0.206  0.0723 
#>  2 5-10 y.o.         3              2         29   331 0.00906 0.0876 0.0690 
#>  3 10-15 y.o.        2              2         35   510 0.00392 0.0686 0.0571 
#>  4 15-20 y.o.        9              9         96   829 0.0109  0.116  0.0938 
#>  5 20-25 y.o.        3              3        323  2386 0.00126 0.135  0.00929
#>  6 25-30 y.o.       20              6        553  3721 0.00537 0.149  0.0108 
#>  7 30-35 y.o.       13              7        641  3830 0.00339 0.167  0.0109 
#>  8 35-40 y.o.       31             18        460  2896 0.0107  0.159  0.0391 
#>  9 40-45 y.o.       50             35        432  2615 0.0191  0.165  0.0810 
#> 10 45-50 y.o.       54             34        488  2497 0.0216  0.195  0.0697 
#> # … with 11 more rows
```

### Parameters setting

The final set of functions in the `comoparams` package is the
**parameters setting** functions. This set contains majority of the
functions within `comoparams` (a total of 19 functions).

The **parameter settings** functions again uses a common prefix syntax
of `ph_set_` followed by the descriptor of the parameter that is being
defined or set. This syntax applies to 18 of the 19 functions in the
set. The descriptors are:

| **Descriptor**  | **Definition**                                                                                                                                                          |
| :-------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `cases`         | Set the *cases parameters* using the `ph_calculate_cases()` function to process, calculate and output the cases data in the appropriate parameters format.              |
| `severe`        | Set the *severity-mortality parameters* using the `ph_calculate_rates()` function to process, calculate and output the cases data in the appropriate parameters format. |
| `population`    | Set the *populations parameters* using the `ph_get_population()` function to process and output the population data in the appropriate parameters format.               |
| `general`       | Set the *general* and *country parameters*                                                                                                                              |
| `virus`         | Set the *virus parameters*                                                                                                                                              |
| `hospital`      | Set the *hospitalisation parameters*                                                                                                                                    |
| `lockdown`      | Set the *lockdown intervention parameters*                                                                                                                              |
| `isolation`     | Set the *self-isolation intervention parameters*                                                                                                                        |
| `distancing`    | Set the *social distancing intervention parameters*                                                                                                                     |
| `handwashing`   | Set the *handwashing intervention parameters*                                                                                                                           |
| `work`          | Set the *work from home intervention parameters*                                                                                                                        |
| `school`        | Set the *schools closure intervention parameters*                                                                                                                       |
| `elderly`       | Set the *shielding the elderly intervention parameters*                                                                                                                 |
| `travel`        | Set the *travel ban intervention parameters*                                                                                                                            |
| `quarantine`    | Set the *voluntary home quarantine parameters*                                                                                                                          |
| `vaccination`   | Set the *vaccination intervention parameters*                                                                                                                           |
| `interventions` | Set all the *intervention parameters* using all the single intervention parameter setting functions                                                                     |

The functions with this syntax are interactive command line functions
that guide the user through the various parameters required and
facilitates the user to input values for the needed parameters. In this
set, there is a summary function (`ph_set_params`) that pulls together
all the interactive command line functions and guides the user in
specifying all the parameters.

Finally, the 19th function in the parameter setting function set is a
function that takes the output of `ph_set_params()` and then converts it
into the **CoMo Consortium Model** parameters template format in an XLSX
workbook and saves it as an XLSX file in the specified directory.

``` r
ph_create_params(params = ph_set_params(), path = ".")
```
