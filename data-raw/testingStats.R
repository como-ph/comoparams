library(magrittr)
library(dplyr)
library(lubridate)
library(ggplot2)

x <- ph_get_cases()

## Fix dates
y <- x %>%
  mutate(DateSpecimen = lubridate::ymd(DateSpecimen),
         DateResultRelease = lubridate::ymd(DateResultRelease),
         DateRepConf = lubridate::ymd(DateRepConf),
         DateDied = lubridate::ymd(DateDied),
         DateRecover = lubridate::ymd(DateRecover),
         DateOnset = lubridate::ymd(DateOnset),
         OnsetToTest = DateSpecimen - DateOnset,
         TestToConfirm = DateRepConf - DateSpecimen,
         MonthTested = lubridate::month(DateSpecimen))

## Number of days from onset to test -------------------------------------------

## Histogram of time in days between onset to test by month of test
y %>%
  filter(MonthTested %in% 3:8) %>%
  ggplot(mapping = aes(x = as.numeric(OnsetToTest))) +
  geom_histogram() +
  facet_wrap(~ MonthTested, ncol = 3, scales = "free")

## Histogram of time in days between onset to test by health status
y %>%
  ggplot(mapping = aes(x = as.numeric(OnsetToTest))) +
  geom_histogram() +
  facet_wrap(~ HealthStatus, ncol = 3, scales = "free")

## Calculate median days by month tested
aggregate(x = y[ , c("MonthTested", "OnsetToTest")],
          by = list(y$MonthTested), FUN = median, na.rm = TRUE)

aggregate(x = y[ , c("HealthStatus", "OnsetToTest")],
          by = list(y$HealthStatus), FUN = median, na.rm = TRUE)





## Number of days from test to confirmed results -------------------------------

## Histogram of time in days between test to confirmed results by month of test
y %>%
  filter(MonthTested %in% 3:8) %>%
  ggplot(mapping = aes(x = as.numeric(TestToConfirm))) +
  geom_histogram() +
  facet_wrap(~ MonthTested, ncol = 3, scales = "free")

## Histogram of time in days between test to confirmed results by health status
y %>%
  ggplot(mapping = aes(x = as.numeric(TestToConfirm))) +
  geom_histogram() +
  facet_wrap(~ HealthStatus, ncol = 3, scales = "free")

##
aggregate(x = y[ , c("MonthTested", "TestToConfirm")],
          by = list(y$MonthTested), FUN = median, na.rm = TRUE)

aggregate(x = y[ , c("HealthStatus", "TestToConfirm")],
          by = list(y$HealthStatus), FUN = median, na.rm = TRUE)


##
