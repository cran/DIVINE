#' Create Summary Table
#'
#' This function generates a summary table using the `gtsummary` package.
#' It allows customization of the reported statistics for continuous variables and categorical variables.
#' Users can optionally include p-values for group comparisons and manage
#' the reporting of missing values.
#'
#' @param data A data frame containing the dataset.
#' @param vars A character vector of variable names to include in the summary. If NULL (default), all variables are included.
#' @param var_labels A list of labels to replace variable names in the table.
#' @param by A character string specifying a grouping variable. If NULL (default), no grouping is applied.
#' @param statistic_type A character string specifying the type of statistic to report **for continuous variables**. Options are:
#'   - "mean_sd": Mean (SD) for continuous variables.
#'   - "median_iqr": Median (Q1; Q3) for continuous variables.
#'   - "both": Both Mean (SD) and Median (Q1; Q3).
#' @param pvalue A logical value indicating whether to include p-values in the summary. Defaults to FALSE.
#' @param test_method Optional. Only used if `pvalue = TRUE`. A list specifying custom statistical tests for each variable. If NULL, `gtsummary` will choose default tests based on variable type.
#' @param include_na A logical value indicating whether to include rows with missing values in the output. Defaults to TRUE.
#'
#' @return A gtsummary table object.
#' @importFrom gtsummary tbl_summary add_p modify_table_body all_continuous all_stat_cols
#' @examples
#' # Mean ± SD summary
#' stats_table(
#'   vital_signs,
#'   vars = c("temperature", "saturation"),
#'   by = "supporto2",
#'   statistic_type = "mean_sd"
#' )
#'
#' # Both mean ± SD and median [Q1; Q3]
#' stats_table(
#'  vital_signs,
#'  statistic_type = "both",
#'  include_na = FALSE
#' )
#'
#' # Add p-value with default tests
#' stats_table(
#'  vital_signs,
#'  vars = c("temperature", "saturation"),
#'  by = "supporto2",
#'  pvalue = TRUE
#' )
#'
#' # Add p-value and define method
#' stats_table(
#'  vital_signs,
#'  vars = c("temperature", "saturation"),
#'  by = "supporto2",
#'  pvalue = TRUE,
#'  test_method = list(temperature ~ "t.test")
#' )
#'
#' @export
#'
stats_table <- function(data, vars = NULL, var_labels = NULL, by = NULL, statistic_type = "mean_sd", pvalue = FALSE, test_method = NULL, include_na = TRUE) {
  # Check if the specified variables exist in the dataset
  if (!is.null(vars) && !all(vars %in% names(data))) {
    stop("Some variables specified in 'vars' are not present in the dataset.")
  }

  # Subset data if vars are provided
  if (!is.null(vars)) {
    if (!is.null(by)) {
      data <- data |>
        dplyr::select(dplyr::all_of(c(vars, by)))
    } else {
      data <- data |>
        dplyr::select(dplyr::all_of(vars))
    }
  }

  # Define type based on the chosen statistic_type
  if (statistic_type == "both") {
    type <- list(gtsummary::all_continuous() ~ "continuous2")
  } else {
    type <- NULL
  }

  # Define statistics based on the chosen statistic_type
  if (statistic_type == "mean_sd") {
    statistic <- list(
      gtsummary::all_continuous() ~ "{mean} ({sd})",
      gtsummary::all_categorical() ~ "{n} ({p}%)"
    )
  } else if (statistic_type == "median_iqr") {
    statistic <- list(
      gtsummary::all_continuous() ~ "{median} [{p25};{p75}]",
      gtsummary::all_categorical() ~ "{n} ({p}%)"
    )
  } else if (statistic_type == "both") {
    statistic <- list(
      gtsummary::all_continuous() ~ c("{mean} ({sd})", "{median} [{p25};{p75}]"),
      gtsummary::all_categorical() ~ "{n} ({p}%)"
    )
  } else {
    stop("Invalid statistic_type. Choose 'mean_sd', 'median_iqr', or 'both'.")
  }

  # Create summary table
  tbl <- gtsummary::tbl_summary(
    data = data,
    by = by,
    statistic = statistic,
    digits = list(
      gtsummary::all_continuous() ~ 2,
      gtsummary::all_categorical() ~ c(0, 2),
      gtsummary::all_dichotomous() ~ c(0, 2)
    ),
    missing = ifelse(include_na, "ifany", "no"),
    type = type,
    label = var_labels
  )

  # Add p-value if a grouping variable is specified
  if (!is.null(by) & pvalue & is.null(test_method)) {
    tbl <- tbl |> gtsummary::add_p()
  }

  if (!is.null(by) & pvalue & !is.null(test_method)) {
    tbl <- tbl |> gtsummary::add_p(test = test_method)
  }

  # Modify label header
  tbl <- tbl |>
    gtsummary::modify_header(label = "**Variables**")

  # Add stat_label
  if (statistic_type == "both") {
    tbl <- tbl |>
      gtsummary::add_stat_label()
  }

  # Eliminate NA values of the output
  tbl <- tbl |>
    gtsummary::modify_table_body(~ .x |>
      dplyr::mutate(
        dplyr::across(
          gtsummary::all_stat_cols(), ~ dplyr::case_when(
            stringr::str_detect(.x, "NA ?") ~ "-",
            TRUE ~ .x
          )
        )
      ))

  # Return the summary table
  return(tbl)
}
