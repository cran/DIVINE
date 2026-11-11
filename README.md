# DIVINE <a href="https://bruigtp.github.io/DIVINE/"><img src="man/figures/logo.png" align="right" height="138" alt="DIVINE website" /></a>

[![CRAN status](https://www.r-pkg.org/badges/version/DIVINE)](https://cran.r-project.org/package=DIVINE) &#160;&#160;
[![](https://cranlogs.r-pkg.org/badges/DIVINE)](https://CRAN.R-project.org/package=DIVINE) &#160;&#160; [![](https://cranlogs.r-pkg.org/badges/grand-total/DIVINE)](https://CRAN.R-project.org/package=DIVINE)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19130825.svg)](https://doi.org/10.5281/zenodo.19130825)

<br>

DIVINE is an R package that provides 14 curated datasets and 6 intuitive data management functions to streamline epidemiological data workflows.

It is designed to support researchers in quickly accessing clean, structured data and applying essential cleaning, summarizing, visualization, and export operations with minimal effort.

Whether you're preparing a cohort for analysis or creating reports, DIVINE makes the process more efficient, transparent, and reproducible.

<br>

## 📦 Installation
<hr>

Install the **development** version from [GitHub](https://github.com/bruigtp/DIVINE) with:

``` r
# install.packages("pak")
pak::pak("bruigtp/DIVINE")
```

<br>

## 🗂️ Included Datasets
<hr>

DIVINE includes 14 real-world structured datasets, commonly used in longitudinal and hospital-based research:

- analytics
- end_followup
- complications
- comorbidities
- demographic
- symptoms
- scores
- vital_signs
- concomitant_medicat
- inhosp_other_treatments
- icu
- vaccine
- inhosp_antivirals
- inhosp_antibiotics

To list them inside R:

``` r
data(package = "DIVINE")
```

To load one:

``` r
data("demographic")
head(demographic)
```

<br>

## ⚙️ Core Functions
<hr>

DIVINE includes 6 functions that follow a typical data preparation pipeline:

| Step                  | Function          | Description                                                       |
| --------------------- | ----------------- | ----------------------------------------------------------------- |
| Inspect data          | `data_overview()` | Get a high-level summary (structure, missingness, preview)        |
| Handle missing values | `impute_missing()` | Replace `NA`s using mean, median, mode, or a fixed value          |
| Merge datasets        | `multi_join()`    | Join multiple datasets by a common key                            |
| Summarize tables      | `stats_table()`   | Create descriptive tables with gtsummary (mean/median + p-values) |
| Visualize data        | `multi_plot()`    | Plot histograms, boxplots, densities, radar charts, etc.          |
| Export results        | `export_data()`   | Export to CSV, Excel, RDS, SPSS, Stata, or SAS                    |

<br>
<br>

## 📖 Vignette
<hr>

Read the full walkthrough with all examples:

```r
vignette("DIVINE")
```

Or view online: https://bruigtp.github.io/DIVINE/articles/DIVINE.html

<br>

## Citation
<hr>

If you use these data, please cite the DIVINE study and the relevant publication:

Pallarès N., Carmezim J., Rodríguez-Molinero A., Coloma A., Izquierdo E., Díaz-Brito V., Videla S., Carratalà J., Gómez-Melis G., & Tebé C. (2026). *A multicenter COVID-19 database from four waves in the south metropolitan area of Barcelona, Catalonia.* Scientific Data, 13(1), 1228. https://doi.org/10.1038/s41597-026-07479-7

## 🤝 Contributing
<hr>

If you encounter a bug, please file an issue with a minimal reproducible example on [GitHub](https://github.com/bruigtp/DIVINE/issues).

<br>

## About
<hr>

Package: DIVINE

Authors: Natàlia Pallarès, João Carmezim, Pau Satorra, Cristian Tebé.

Maintainer: João Carmezim

License: GPL (>= 3)

Encoding: UTF-8

Depends: R (>= 4.1.0)
