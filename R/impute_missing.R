#' Replace Missing Values
#'
#' Replace missing values (NA) in a data.frame with a specified value or method (such as mean, median, mode, constant, or custom function),
#' applying imputation column-wise.
#'
#' You can remove rows that are entirely `NA` before imputation using
#' `drop_all_na`, or filter rows based on specific variables using `filter_by`.
#'
#' @param data A data frame. The dataset in which missing values should be imputed.
#' @param method A list of one-sided formulas of the form `<selector> ~ <value>`.
#' Supported `<value>` options are:
#'   \itemize{
#'      \item `"mean"`: replace with the column mean (numeric columns only).
#'      \item `"median"`: replace with the column median (numeric columns only).
#'      \item `"mode"`: replace with the most frequent value (works for numeric, character, or factor).
#'      \item A numeric constant: replace with that constant (numeric columns).
#'      \item A character constant: replace with that value (character/factor columns).
#'      \item A function: a function `function(col)` that receives the column and returns a single value to be used as replacement for NA.
#' }
#' The default is `list(dplyr::where(is.numeric) ~ "mean",dplyr::where(is.character) ~ "mode",dplyr::where(is.factor) ~ "mode")`.
#' @param filter_by Character vector of column names. If provided, only rows that have **all** specified columns non-NA are kept (applied *before* imputation).
#' @param drop_all_na Logical; if `TRUE`, rows where **all** columns are `NA` are removed *before* imputation.
#' @param verbose Logical; if `TRUE` (default) print a concise final summary of what was imputed. Set to `FALSE` to suppress messages.
#' @return A tibble with missing values replaced according to the provided specifications.
#'
#' @details
#' - The `method` argument uses **tidyselect** helpers. For example, `where(is.numeric()) ~ "median"`
#' imputes all numeric columns by their medians.
#' - `"mode"` works for numeric, character and factor columns.
#' - When imputing factors with a character constant, the constant is added as a new level if needed.
#' - When passing a custom function, it should return at least one value; if multiple values are returned, only the first is used (with a warning).
#'
#' @note
#' **Caution:** Single imputation methods may introduce bias or underestimate
#' variability in your data. For more robust handling of missing data, consider
#' multiple imputation approaches, such as those implemented in the
#' \href{https://cran.r-project.org/package=mice}{\code{mice}} package.
#'
#' @examples
#' # Impute all numeric columns by their means:
#' impute_missing(icu)
#'
#' # Impute numeric columns by median:
#' impute_missing(
#'   icu,
#'   method = list(where(is.numeric) ~ "median")
#' )
#'
#' # Keep only rows where both "vent_mec_no_inv" and "vent_mec" are non-missing:
#' impute_missing(
#'   icu,
#'   filter_by = c("vent_mec_no_inv", "vent_mec")
#' )
#' @importFrom stats na.omit setNames
#' @export
impute_missing <- function(
  data,
  method = list(
    dplyr::where(is.numeric) ~ "mean",
    dplyr::where(is.character) ~ "mode",
    dplyr::where(is.factor) ~ "mode"
  ),
  filter_by = NULL,
  drop_all_na = FALSE,
  verbose = TRUE
) {
  #-- Input validation -------------------------------------------------------
  if (!inherits(data, "data.frame")) {
    stop("`data` must be a data.frame or tibble.", call. = FALSE)
  }
  if (!is.list(method) || length(method) < 1) {
    stop("`method` must be a non-empty list of formulas.", call. = FALSE)
  }

  if (!is.null(filter_by) && !is.character(filter_by)) {
    stop(
      "`filter_by` must be NULL or a character vector of column names (e.g. c('record_id')).",
      call. = FALSE
    )
  }

  if (!is.logical(drop_all_na) || length(drop_all_na) != 1) {
    stop("`drop_all_na` must be a single logical value.", call. = FALSE)
  }

  if (!is.logical(verbose) || length(verbose) != 1) {
    stop("`verbose` must be a single logical value.", call. = FALSE)
  }

  # Helper: compute mode (returns value of same basic type or NA)
  mode_value <- function(x) {
    ux <- unique(x[!is.na(x)])
    if (length(ux) == 0) {
      return(NA)
    }
    ux[which.max(tabulate(match(x, ux)))]
  }

  # Convert to tibble for manipulation
  data <- dplyr::as_tibble(data)
  data_cols <- names(data)

  # Track last method label applied to each column (NA if none)
  methods_applied <- setNames(rep(NA_character_, length(data_cols)), data_cols)
  col_types_before <- vapply(
    data,
    function(x) {
      if (is.numeric(x)) {
        return("numeric")
      }
      if (is.factor(x)) {
        return("factor")
      }
      if (is.character(x)) {
        return("character")
      }
      class(x)[1]
    },
    character(1)
  )

  # Remove rows with all NAs if requested
  if (drop_all_na) {
    prev_rows <- nrow(data)

    data <- data |>
      dplyr::filter(!dplyr::if_all(dplyr::everything(), ~ is.na(.x)))

    remove_rows <- prev_rows - nrow(data)

    if (remove_rows > 0 && verbose) {
      message(stringr::str_glue(
        "Removed {remove_rows} rows where all values were NA"
      ))
    }
  }

  # Optionally filter rows: keep rows that have at least one non-NA among specified vars
  if (!is.null(filter_by)) {
    sel <- filter_by
    missing_cols <- setdiff(sel, data_cols)
    if (length(missing_cols) > 0) {
      stop(
        sprintf(
          "Column(s) in `filter_by` not found: %s",
          paste(missing_cols, collapse = ", ")
        ),
        call. = FALSE
      )
    }

    prev_rows <- nrow(data)
    # ✅ Keep rows where all selected vars are non-NA
    data <- data |>
      dplyr::filter(dplyr::if_all(dplyr::all_of(sel), ~ !is.na(.x)))

    removed <- prev_rows - nrow(data)
    if (removed > 0 && verbose) {
      message(sprintf(
        "Removed %d rows that had NA in at least one of the 'filter_by' variables",
        removed
      ))
    }
  }

  # Process each formula in `method`

  for (i in method) {
    if (!inherits(i, "formula")) {
      stop(
        "Each element in 'method' must be a formula of the form <selector> ~ <value>.",
        call. = FALSE
      )
    }

    # Evaluate tidyselect on current data
    arg_vars <- tryCatch(
      tidyselect::eval_select(rlang::f_lhs(i), data) |> names(),
      error = function(e) {
        stop(
          "Error evaluating selector in 'method': ",
          conditionMessage(e),
          call. = FALSE
        )
      }
    )

    arg_value <- rlang::eval_tidy(rlang::f_rhs(i))

    # Build a readable label for the arg_value (method description)  # NEW
    method_label <- if (is.function(arg_value)) {
      "custom function"
    } else if (identical(arg_value, "mean")) {
      "mean"
    } else if (identical(arg_value, "median")) {
      "median"
    } else if (identical(arg_value, "mode")) {
      "mode"
    } else if (is.numeric(arg_value)) {
      paste0("numeric constant (", arg_value, ")")
    } else if (is.character(arg_value)) {
      paste0("character constant ('", arg_value, "')")
    } else {
      "unknown"
    }

    if (length(arg_vars) > 0) {
      methods_applied[arg_vars] <- method_label
    }

    # Check column names

    check <- setdiff(arg_vars, data_cols)

    if (length(check) > 0) {
      stop(
        sprintf(
          "Column(s) not found in data: %s",
          paste(check, collapse = ", ")
        ),
        call. = FALSE
      )
    }

    # Define custom function to impute missings
    fill_na_custom <- function(x, arg_value) {
      if (!anyNA(x)) {
        return(x)
      }

      replacement <- NULL

      if (is.function(arg_value)) {
        replacement <- arg_value(x)
        if (length(replacement) < 1) {
          stop(
            "The custom function must return at least one value.",
            call. = FALSE
          )
        }
        if (length(replacement) > 1) {
          warning(
            "Custom function returned multiple values; using the first one.",
            call. = FALSE
          )
        }
        replacement <- replacement[[1]]
      } else if (identical(arg_value, "mean")) {
        if (!is.numeric(x)) {
          stop("`mean` specified but column is not numeric.", call. = FALSE)
        }
        replacement <- mean(x, na.rm = TRUE)
      } else if (identical(arg_value, "median")) {
        if (!is.numeric(x)) {
          stop("`median` specified but column is not numeric.", call. = FALSE)
        }
        replacement <- stats::median(x, na.rm = TRUE)
      } else if (identical(arg_value, "mode")) {
        replacement <- mode_value(x)
      } else if (is.numeric(arg_value) && is.numeric(x)) {
        replacement <- arg_value
      } else if (is.character(arg_value) && (is.character(x) || is.factor(x))) {
        replacement <- arg_value
      } else {
        stop(
          "Invalid `arg_value` for the column's type. Use 'mean'/'median' (numeric), 'mode', a numeric constant (numeric columns), a character constant (character/factor), or a function.",
          call. = FALSE
        )
      }

      # If factor and replacement is character, add level if needed
      if (is.factor(x) && is.character(replacement)) {
        if (!replacement %in% levels(x)) {
          levels(x) <- c(levels(x), replacement)
        }
        replacement <- factor(replacement, levels = levels(x))
      }

      # If x is factor and replacement is factor, coerce to x's levels (union if necessary)
      if (is.factor(x) && is.factor(replacement)) {
        if (!all(levels(replacement) %in% levels(x))) {
          levels(x) <- union(levels(x), levels(replacement))
        }
        replacement <- factor(as.character(replacement), levels = levels(x))
      }

      # Numeric column should receive numeric replacement (except 'mode' allowed)
      if (
        is.numeric(x) &&
          !is.numeric(replacement) &&
          !identical(arg_value, "mode")
      ) {
        stop(
          "Cannot assign a non-numeric replacement to a numeric column (except when using 'mode').",
          call. = FALSE
        )
      }

      # Expect scalar replacement; if length > 1, use first element
      if (length(replacement) > 1) {
        replacement <- replacement[[1]]
      }

      x[is.na(x)] <- replacement
      x
    }

    # Apply replacements across selected columns only if any columns selected
    if (length(arg_vars) > 0) {
      data <- data |>
        dplyr::mutate(
          dplyr::across(
            .cols = dplyr::all_of(arg_vars),
            ~ fill_na_custom(.x, arg_value)
          )
        )
    }
  }

  # Simplified reporting
  if (verbose) {
    msgs <- c()

    if (any(col_types_before == "numeric" & !is.na(methods_applied))) {
      num_method <- unique(na.omit(methods_applied[
        col_types_before == "numeric"
      ]))
      if (length(num_method) > 0) {
        msgs <- c(
          msgs,
          paste(
            "Numeric variables imputed with",
            paste(num_method, collapse = ", ")
          )
        )
      }
    }
    if (
      any(
        col_types_before %in% c("character", "factor") & !is.na(methods_applied)
      )
    ) {
      cat_method <- unique(na.omit(methods_applied[
        col_types_before %in% c("character", "factor")
      ]))
      if (length(cat_method) > 0) {
        msgs <- c(
          msgs,
          paste(
            "Categorical/Factor variables imputed with",
            paste(cat_method, collapse = ", ")
          )
        )
      }
    }

    if (length(msgs) > 0) {
      message("Imputation summary: ", paste(msgs, collapse = "; ")) # NEW
    }
  }

  return(data)
}
