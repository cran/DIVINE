#' Data Overview Function
#'
#' This function provides a comprehensive overview of a data frame, including its
#' dimensions, variable types, missing values count and a preview of the first few rows.
#'
#' @param data A data frame. The dataset for which you want an overview.
#' @param preview_rows Integer. The number of rows to display in the preview. Default is 6.
#'
#' @return A list containing the following components:
#'   \item{dimensions}{A vector of two elements: the number of rows and columns in the data.}
#'   \item{variable_types}{A named vector with the class of each variable (column) in the data.}
#'   \item{missing_values}{A named vector with the count of missing values (NA) for each variable.}
#'   \item{preview}{A data frame showing the first `preview_rows` rows of the dataset.}
#'
#' @details
#' The function is useful for quickly inspecting the structure of a data frame and
#' identifying any missing values or general characteristics of the data. It also allows
#' users to customize how many rows they want to preview from the dataset.
#'
#' @examples
#' # Example usage with a simple data frame
#' data <- data.frame(
#'   Age = c(25, 30, NA, 22, 35),
#'   Height = c(175, 160, 180, NA, 165),
#'   Gender = c("Male", "Female", "Female", "Male", "Male")
#' )
#' overview <- data_overview(data, preview_rows = 4)
#' print(overview)
#'
#' # Example usage with the default preview size (6 rows)
#' overview_default <- data_overview(data)
#' print(overview_default)
#'
#' @export
data_overview <- function(data, preview_rows = 6) {

  # Data with no rows
  if (nrow(data) == 0) {
    return("The data frame has no rows.")
  }

  # Data with no columns
  if (ncol(data) == 0) {
    return("The data frame has no columns.")
  }

  # Overview of the data
  overview <- list(
    # Dimensions
    dimensions = dim(data),
    # Class
    variable_types = sapply(data, class),
    # Missing values
    missing_values = sapply(data, function(x) sum(is.na(x))),
    # Preview
    preview = utils::head(data, n = preview_rows)
  )

  return(overview)
}
