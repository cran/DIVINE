#' Export Data to Various Formats
#'
#' Export a dataframe or tibble to multiple file formats. If `format` is NULL (default),
#' the format will be inferred from the file extension of `path`. If `format` is provided
#' and the extension in `path` does not match, the function will update the path to
#' use the extension that corresponds to `format` and warn the user.
#'
#' @param data A dataframe or tibble to export.
#' @param path A character string specifying the file path for the exported file.
#' @param format Optional character string specifying the export format. Supported formats:
#'   "xlsx", "csv", "rds", "txt", "sav", "dta", "sas7bdat" (alias "xpt"). If NULL (default),
#'   the function infers the format from the `path` extension.
#'
#' @return This function does not return a value. It writes the data to the specified file path and displays a success message upon completion.
#'
#' @details
#' Supported formats and their functionality are provided via the package dependencies:
#' - **xlsx**: Uses `openxlsx` for Excel exports.
#' - **csv**: Base R functionality.
#' - **rds**: Base R functionality.
#' - **txt**: Base R functionality with tab-separated values.
#' - **sav**: Uses `haven` for SPSS exports.
#' - **dta**: Uses `haven` for Stata exports.
#' - **sas7bdat**: Uses `haven` for SAS exports.
#'
#' @examples
#' \dontrun{
#' df <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
#'
#' # Infer format from path extension (no format argument)
#' export_data(df, path = "example.xlsx")
#' export_data(df, path = "example.csv")
#'
#' # Explicit format (function will ensure path extension matches)
#' export_data(df, format = "csv", path = "example")         # adds .csv
#' export_data(df, format = "rds", path = "example.rds")
#' }
#'
#' @export
export_data <- function(data = NULL, path = NULL, format = NULL) {
  # Check if data is provided
  if (is.null(data)) {
    stop("Please specify an R object to export.", call. = FALSE)
  }

  # Check if data is a dataframe or tibble
  if (!is.data.frame(data) && !tibble::is_tibble(data)) {
    stop("The R object to export must be a dataframe or a tibble.", call. = FALSE)
  }

  # Check if path is provided
  if (is.null(path) || !nzchar(path)) {
    stop("Please specify the file path where the data should be exported.", call. = FALSE)
  }

  # Supported formats (internal canonical names)
  supported <- c("xlsx", "csv", "rds", "txt", "sav", "dta", "xpt")
  # Aliases mapping (user-friendly)
  alias_map <- list(sas7bdat = "xpt", xpt = "xpt")

  # Extract extension from path (without dot), lower-case
  ext <- tolower(tools::file_ext(path))

  # If user provided format, normalize it
  if (!is.null(format)) {
    format <- tolower(as.character(format))
    if (format %in% names(alias_map)) format <- alias_map[[format]]
    if (!(format %in% supported)) {
      stop("Unsupported format. Use one of: 'xlsx', 'csv', 'rds', 'txt', 'sav', 'dta', 'sas7bdat'.", call. = FALSE)
    }
  }

  # If no extension in path and format provided -> add extension to path
  if (!is.null(format) && ext == "") {
    path <- paste0(path, ".", format)
    ext <- format
    message("Added file extension '", ext, "' to the path.")
  }

  # If format is NULL -> infer from extension
  if (is.null(format)) {
    if (ext == "") {
      stop("Cannot infer format because 'path' has no extension. Either supply 'format' or add an extension to 'path'.", call. = FALSE)
    }
    if (ext %in% names(alias_map)) ext <- alias_map[[ext]]
    if (!(ext %in% supported)) {
      stop("Unsupported extension in 'path'. Use one of: 'xlsx', 'csv', 'rds', 'txt', 'sav', 'dta', 'sas7bdat'.", call. = FALSE)
    }
    format <- ext
  } else {
    # If both format and ext exist and do not match -> correct path to match format
    if (ext != "" && ext != format) {
      base <- tools::file_path_sans_ext(path)
      new_path <- paste0(base, ".", format)
      message(
        "Warning: path extension (.", ext, ") did not match 'format' (", format, ").\n",
        "         Adjusting path to: ", new_path
      )
      path <- new_path
      ext <- format
    }
  }

  # Ensure target directory exists (try to create if missing)
  target_dir <- dirname(path)
  if (!dir.exists(target_dir) && nzchar(target_dir) && target_dir != ".") {
    tryCatch({
      dir.create(target_dir, recursive = TRUE)
      message("Created directory: ", target_dir)
    }, error = function(e) {
      stop("Could not create directory '", target_dir, "': ", e$message, call. = FALSE)
    })
  }


  # Perform export according to format, checking required packages
  tryCatch({
    if (format == "xlsx") {
      if (!requireNamespace("openxlsx", quietly = TRUE)) {
        stop("Package 'openxlsx' is required to export xlsx. Install it with install.packages('openxlsx').", call. = FALSE)
      }
      header_style <- openxlsx::createStyle(
        textDecoration = "BOLD",
        fontColour = "#FFFFFF",
        fontSize = 12,
        fontName = "Arial Narrow",
        fgFill = "#4F80BD",
        halign = "center"
      )
      openxlsx::write.xlsx(x = data, file = path, overwrite = TRUE, colNames = TRUE, borders = "rows", headerStyle = header_style)
    } else if (format == "csv") {
      utils::write.csv(data, file = path, row.names = FALSE)
    } else if (format == "rds") {
      saveRDS(data, file = path)
    } else if (format == "txt") {
      utils::write.table(data, file = path, row.names = FALSE, quote = FALSE, sep = "\t")
    } else if (format == "sav") {
      if (!requireNamespace("haven", quietly = TRUE)) {
        stop("Package 'haven' is required to export SPSS files. Install it with install.packages('haven').", call. = FALSE)
      }
      haven::write_sav(data, path)
    } else if (format == "dta") {
      if (!requireNamespace("haven", quietly = TRUE)) {
        stop("Package 'haven' is required to export Stata files. Install it with install.packages('haven').", call. = FALSE)
      }
      haven::write_dta(data, path)
    } else if (format == "xpt") {
      if (!requireNamespace("haven", quietly = TRUE)) {
        stop("Package 'haven' is required to export SAS XPT files. Install it with install.packages('haven').", call. = FALSE)
      }
      # write_xpt writes a SAS transport (XPT) file
      haven::write_xpt(data, path)
    } else {
      stop("Internal error: unrecognized format '", format, "'.", call. = FALSE)
    }
  }, error = function(e) {
    stop("Error while exporting: ", e$message, call. = FALSE)
  })

  message("Data successfully exported to: ", normalizePath(path, mustWork = FALSE))
  invisible(path)
}
