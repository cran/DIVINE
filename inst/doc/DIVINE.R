## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  warning = FALSE,
  message = FALSE
)

## ----setup, include = FALSE---------------------------------------------------
rm(list = ls())
library("DIVINE")

## ----eval=FALSE---------------------------------------------------------------
# install.packages("DIVINE")

## ----eval=FALSE---------------------------------------------------------------
# # install.packages("devtools")
# devtools::install_github("bruigtp/DIVINE")
# 
# pak::pak("bruigtp/DIVINE") # Alternative

## ----eval=FALSE---------------------------------------------------------------
# library(DIVINE)

## ----eval=FALSE---------------------------------------------------------------
# data(package = "DIVINE")

## ----eval=FALSE---------------------------------------------------------------
# ?demographic

## -----------------------------------------------------------------------------
data("demographic")
head(demographic)

## -----------------------------------------------------------------------------
# Overview of your data frame
ov <- data_overview(demographic)

# Print the entire overview
ov

## -----------------------------------------------------------------------------
# Each of the elements
ov$dimensions      # number of rows and columns
ov$variable_types  # data types of each variable
ov$missing_values  # count of missing values per column
ov$preview         # a small preview of the data

## -----------------------------------------------------------------------------
# 1) Default: replace all numeric NAs with column means
cleaned_default <- impute_missing(icu)

# 2) Single column strategies:
#    - Mean for vent_mec_start_days
#    - Zero for icu_enter_days
cleaned_mix <- impute_missing(
  icu,
  method = list(
    vent_mec_start_days ~ "mean",
    icu_enter_days ~ 0
  )
)

# 3) Multiple columns at once:
#    - Medians for any column ending in "_days"
cleaned_days_median <- impute_missing(
  icu,
  method = list(starts_with(".*_days$") ~ "median")
)

# 4) Factor/character imputation:
#    - Fill gender with its most common level
#    - Fill status with "Unknown"
cleaned_char <- impute_missing(
  icu,
  method = list(
    covid_wave ~ "mode",
    icu ~ "Unknown"
  )
)

# 5) Drop all-NA rows first, then impute numeric means
cleaned_no_empty <- impute_missing(
  icu,
  method    = list(where(is.numeric) ~ "mean"),
  drop_all_na = TRUE
)
# ▶ message: Removed X rows where all values were NA

## -----------------------------------------------------------------------------
data("vital_signs")
data("scores")

joined <- multi_join(
  list(demographic, vital_signs, scores),
  key = c("record_id", "covid_wave", "center"),
  join_type = "left"
)

## -----------------------------------------------------------------------------
# Mean (SD) by group (e.g., by gender or cohort)
tbl1 <- stats_table(
  demographic,
  vars = c("age", "smoker", "alcohol"),
  by = "sex",
  statistic_type = "mean_sd",
  pvalue = TRUE
)

# Median [Q1; Q3] for all observations (no grouping)
tbl2 <- stats_table(
  demographic,
  statistic_type = "median_iqr"
)

# Both mean (SD) and median [IQR] combined
tbl3 <- stats_table(
  demographic,
  statistic_type = "both"
)

## -----------------------------------------------------------------------------
# Histogram of age
multi_plot(
  demographic,
  x = "age",
  plot_type = "histogram",
  fill_color = "skyblue",
  title = "Distribution of Age"
)

# Boxplot of age by sex
multi_plot(
  demographic,
  x = "sex",
  y = "age",
  plot_type = "boxplot",
  group = "sex",
  title = "Age by Sex"
)

# Spider plot of numeric variables (e.g., compare age, weight, height distributions)
multi_plot(
  comorbidities,
  radar = c("hypertension", "dyslipidemia", "depression", "mild_kidney_disease", "dm"),
  radar_labels = stringr::str_to_sentence(c("hypertension", "dyslipidemia", "depression", "mild_kidney_disease", "dm")),
  radar_color = "blue",
  radar_ref_lev = "Yes",
  plot_type = "spider"
)

