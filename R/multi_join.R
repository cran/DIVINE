#' Multi-Dataset Join Utility
#'
#' This function performs a sequential join of multiple datasets by a specified key column.
#'
#' @param datasets A list of data frames to be joined.
#' @param key A character string representing the key column to join by. Defaults to "record_id".
#' @param join_type A character string specifying the type of join. Options are "left", "right", "inner", or "full".
#'
#' @return A single data frame containing the joined datasets.
#' @importFrom dplyr left_join right_join inner_join full_join
#' @importFrom purrr map
#' @examples
#' multi_join(
#'   list(analytics, comorbidities),
#'   join_type = "left"
#' )
#'
#' multi_join(
#'   list(analytics, comorbidities),
#'   key = c("record_id", "covid_wave", "center"),
#'   join_type = "left"
#' )
#'
#' @export
multi_join <- function(datasets, key = c("record_id", "covid_wave", "center"), join_type = "left") {
  # Validate that datasets is a list of data frames
  if (!is.list(datasets) | !all(sapply(datasets, is.data.frame) | sapply(datasets, tibble::is_tibble))) {
    stop("The 'datasets' parameter must be a list of data frames.")
  }

  # Check if there is more than one dataframe specified
  if (length(datasets) == 1) {
    stop("Please specify more than one dataset to join.")
  }

  # Check if the key exists in all datasets
  if (!all(sapply(datasets, function(df) key %in% names(df)))) {
    stop(paste("The key column", key, "must exist in all datasets."))
  }

  # Validate the join type
  valid_join_types <- c("left", "right", "inner", "full")

  if (!(join_type %in% valid_join_types)) {
    stop(paste("Invalid join_type. Choose one of:", paste(valid_join_types, collapse = ", ")))
  }

  # Explaining joining method
  if (join_type %in% c("left", "right") & length(datasets) > 2) {
    if (join_type == "left") {
      message(sprintf(
        "Performing a LEFT join on %d datasets: the first dataset defines the rows to keep, and subsequent datasets are joined sequentially.",
        length(datasets)
      ))
    } else {
      message(sprintf(
        "Performing a RIGHT join on %d datasets: the last dataset defines the rows to keep, and previous datasets are joined sequentially.",
        length(datasets)
      ))
    }
  }

  # Select the appropriate join function
  join_fun <- switch(join_type,
    left = dplyr::left_join,
    right = dplyr::right_join,
    inner = dplyr::inner_join,
    full = dplyr::full_join
  )

  # Perform the joins sequentially using Reduce
  result <- Reduce(function(x, y) {
    # Join each pair of data frames using the specified join function
    join_fun(x, y, by = key)
  }, datasets)

  return(result)
}
