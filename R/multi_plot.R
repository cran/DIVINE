#' multi_plot: Flexible Static or Interactive Plotting of Variables
#'
#' Generate a variety of plots—histogram, density, boxplot, barplot, violin, scatter,
#' heatmap, or spider (radar)—either as static ggplot2 objects or interactive Plotly widgets.
#'
#' @param data A data frame or tibble containing your data.
#' @param x Character; name of the variable for x-axis (required for all plot types except spider).
#' @param y Character; name of the variable for y-axis (required for boxplot, violin, scatter, and heatmap).
#' @param plot_type Character; one of \code{"histogram"}, \code{"density"}, \code{"boxplot"},
#'   \code{"barplot"}, \code{"violin"}, \code{"scatter"}, \code{"heatmap"}, or \code{"spider"}.
#' @param interactive Logical; if \code{TRUE}, returns a Plotly interactive plot
#'   (not available for spider/radar charts). Default: \code{FALSE}.
#' @param fill_color Character; fill color for non-grouped geoms (default \code{"steelblue"}).
#' @param color Character; outline/line color (default \code{"black"}).
#' @param bin_width Numeric; bin width for histograms. If \code{NULL}, computed automatically.
#' @param group Character; name of grouping variable (optional).
#' @param facet Character; name of variable to facet by (optional).
#' @param radar Character vector; names of exactly 5 variables for spider plot (only for \code{"spider"}).
#' @param radar_color Character or vector; border/fill color for spider chart (only for \code{"spider"}).
#' @param radar_labels Character or vector; names of the variables for spider chart (only for \code{"spider"}).
#' @param radar_cex Numeric; font size for variable labels in the spider chart (only for \code{"spider"}).
#' @param radar_ref_lev Character; reference level for factors included in the spider chart (only for \code{"spider"}).
#' @param title Character; plot title (optional).
#' @param x_lab Character; x-axis label (defaults to \code{x}).
#' @param y_lab Character; y-axis label (defaults to \code{y} or \code{"Count"}).
#' @param legend_position Character; one of \code{"right","left","top","bottom","none"} (default \code{"right"}).
#' @param axis_text_angle Numeric; rotation angle (degrees) for x-axis tick labels (default \code{0}).
#' @param axis_text_size Numeric; size of axis text in pts (default \code{12}).
#' @param title_size Numeric; size of plot title text in pts (default \code{14}).
#' @param theme_custom A ggplot2 theme object (default \code{theme_minimal()}).
#'
#' @return A \code{ggplot} object (if \code{interactive = FALSE} or \code{plot_type = "spider"})
#'   or a \code{plotly} object (if \code{interactive = TRUE}).
#'
#' @details
#' - \strong{Histogram:} requires \code{x}; uses \code{geom_histogram()}. Use for continuous numeric variables only.
#' - \strong{Density:} requires \code{x}; uses \code{geom_density()}. It should be numeric.
#' - \strong{Boxplot/Violin:} require both \code{x} and \code{y}; automatically groups by \code{x} or by \code{group} if provided, with dynamic dodge width.
#' - \strong{Barplot:} requires \code{x}; counts occurrences. Use for categorical variables only.
#' - \strong{Scatter:} requires both \code{x} and \code{y}; uses \code{geom_point()}. Both variables must be numeric.
#' - \strong{Heatmap:} requires both \code{x} and \code{y}. Both variables must be categorical.
#' - \strong{Spider:} requires \code{radar} (vector of variables); uses \code{fmsb::radarchart()}, static only.
#'
#' @examples
#'
#' multi_plot(icu,
#'   x = "icu_enter_days",
#'   y = "vent_mec_start_days",
#'   plot_type = "scatter",
#'   color = "darkred",
#'   title = "ICU exit vs MV days"
#' )
#'
#' multi_plot(
#'   comorbidities,
#'   radar = c("hypertension", "dyslipidemia", "depression", "mild_kidney_disease", "dm"),
#'   radar_color = "steelblue",
#'   radar_ref_lev = "Yes",
#'   plot_type = "spider"
#' )
#'
#' @importFrom rlang .data
#' @export

multi_plot <- function(data,
                       x = NULL,
                       y = NULL,
                       plot_type = NULL,
                       interactive = FALSE,
                       fill_color = "steelblue",
                       color = "black",
                       bin_width = NULL,
                       group = NULL,
                       facet = NULL,
                       radar = NULL,
                       radar_color = "steelblue",
                       radar_labels = NULL,
                       radar_cex = 1,
                       radar_ref_lev = "Yes",
                       title = NULL,
                       x_lab = NULL,
                       y_lab = NULL,
                       legend_position = "right",
                       axis_text_angle = 0,
                       axis_text_size = 12,
                       title_size = 14,
                       theme_custom = ggplot2::theme_minimal()) {
  # Keep compatibility: internal names used elsewhere
  x_var <- x
  y_var <- y

  # Input validation
  if (is.null(plot_type)) stop("Please specify the desired type of plot via 'plot_type' (no default).", call. = FALSE)
  if (!inherits(data, "data.frame")) stop("The data must be a data.frame or tibble.", call. = FALSE)
  if ("grouped_df" %in% class(data)) data <- dplyr::ungroup(data)

  valid_plot_types <- c(
    "histogram", "density", "boxplot", "barplot",
    "violin", "scatter", "heatmap", "spider"
  )
  if (!plot_type %in% valid_plot_types) {
    stop("plot_type must be one of: ", paste(valid_plot_types, collapse = ", "), call. = FALSE)
  }

  # Only allow radar for spider
  if (!is.null(radar) & plot_type != "spider") {
    stop("'radar' is only used with plot_type = 'spider'. Ignoring 'radar'.")
  }

  # For spider: require radar (exactly 5) and do NOT require x_var or y_var
  if (plot_type == "spider") {
    if (is.null(radar)) {
      stop("For spider charts you must provide 'radar' as a character vector of 5 variable names.", call. = FALSE)
    }
    if (!is.character(radar) || length(radar) != 5) {
      stop("'radar' must be a character vector of exactly 5 variable names.", call. = FALSE)
    }
    # ensure variables exist in data
    missing_vars <- radar[!radar %in% names(data)]
    if (length(missing_vars) > 0) {
      stop(sprintf("The following radar were not found in data: %s", paste(missing_vars, collapse = ", ")), call. = FALSE)
    }
  }

  for (v in c(x_var, y_var, group, facet)) {
    if (!is.null(v) && !v %in% names(data)) {
      stop(sprintf("Variable '%s' not found in data.", v), call. = FALSE)
    }
  }

  # Helper checks
  is_categorical <- function(x) {
    is.factor(x) || is.character(x)
  }
  n_unique_small <- function(x, n = 20) length(unique(stats::na.omit(x))) <= n

  # Type checks for specific plot types (informative errors)
  if (plot_type == "histogram") {
    if (is.null(x_var)) stop("x_var is required for histogram.", call. = FALSE)
    if (!is.numeric(data[[x_var]])) {
      stop(sprintf("Histogram requires a numeric x_var. '%s' is not numeric. Consider using 'barplot' for categorical variables or convert '%s' to numeric.", x_var, x_var), call. = FALSE)
    }
    if (!is.null(y_var)) warning("y_var is ignored for histograms; only x_var is used.")
  }

  if (plot_type == "density") {
    if (is.null(x_var)) stop("x_var is required for density.", call. = FALSE)
    if (!is.numeric(data[[x_var]])) stop(sprintf("Density requires a numeric x_var. '%s' is not numeric.", x_var), call. = FALSE)
    if (!is.null(y_var)) warning("y_var is ignored for density plots; only x_var is used.")
  }

  if (plot_type == "barplot") {
    if (is.null(x_var)) stop("x_var is required for barplot.", call. = FALSE)
    if (!is_categorical(data[[x_var]])) {
      stop(sprintf("Barplot requires a categorical x_var (factor/character). '%s' is not categorical. Consider converting it with factor(%s) or use 'histogram' for numeric variables.", x_var, x_var), call. = FALSE)
    }
    if (!is.null(y_var)) warning("y_var is ignored for barplots; counts of x_var are plotted.")
  }

  if (plot_type %in% c("boxplot", "violin")) {
    if (is.null(x_var) || is.null(y_var)) stop("x_var and y_var are required for boxplot/violin.", call. = FALSE)
    if (!is_categorical(data[[x_var]])) stop(sprintf("For %s, x_var must be categorical/factor. '%s' is not categorical.", plot_type, x_var), call. = FALSE)
    if (!is.numeric(data[[y_var]])) stop(sprintf("For %s, y_var must be numeric. '%s' is not numeric.", plot_type, y_var), call. = FALSE)
  }

  if (plot_type == "scatter") {
    if (is.null(x_var) || is.null(y_var)) stop("x_var and y_var are required for scatter.", call. = FALSE)
    if (!is.numeric(data[[x_var]]) || !is.numeric(data[[y_var]])) stop("Scatter requires both x_var and y_var to be numeric.", call. = FALSE)
  }

  if (plot_type == "heatmap") {
    if (is.null(x_var) || is.null(y_var)) stop("x_var and y_var are required for heatmap.", call. = FALSE)
    # Force categorical x and y for heatmap
    if (!is_categorical(data[[x_var]]) || !is_categorical(data[[y_var]])) {
      stop(sprintf("Heatmap (in this function) requires both x_var and y_var to be categorical (factor/character). If you have numeric x and y consider using 'scatter' or another numeric-heatmap approach."), call. = FALSE)
    }
  }

  # Tidy eval
  x_sym <- if (!is.null(x_var)) rlang::sym(x_var) else NULL
  y_sym <- if (!is.null(y_var)) rlang::sym(y_var) else NULL
  group_sym <- if (!is.null(group)) rlang::sym(group) else NULL
  facet_sym <- if (!is.null(facet)) rlang::sym(facet) else NULL

  # Base plot
  p <- ggplot2::ggplot(data) +
    theme_custom +
    ggplot2::theme(
      legend.position = legend_position,
      axis.text.x     = ggplot2::element_text(angle = axis_text_angle, size = axis_text_size),
      axis.text.y     = ggplot2::element_text(size = axis_text_size),
      plot.title      = ggplot2::element_text(size = title_size)
    )

  # Plot types
  if (plot_type == "histogram") {

    bw <- bin_width %||% diff(range(data[[x_var]], na.rm = TRUE)) / 30
    aes_hist <- ggplot2::aes(x = !!x_sym)
    if (!is.null(group_sym)) aes_hist <- ggplot2::aes(x = !!x_sym, fill = !!group_sym)
    p <- p + ggplot2::geom_histogram(aes_hist,
                                     binwidth = bw,
                                     fill     = fill_color,
                                     color    = color,
                                     alpha    = 0.7,
                                     position = if (is.null(group_sym)) "identity" else "dodge"
    )
    y_lab <- y_lab %||% "Count"
  } else if (plot_type == "density") {

    aes_den <- if (is.null(group_sym)) {
      ggplot2::aes(x = !!x_sym)
    } else {
      ggplot2::aes(x = !!x_sym, fill = !!group_sym, group = !!group_sym)
    }
    p <- p + ggplot2::geom_density(aes_den,
                                   fill  = fill_color,
                                   color = color,
                                   alpha = 0.7
    )
  } else if (plot_type %in% c("boxplot", "violin")) {
    if (is.null(x_sym) || is.null(y_sym)) {
      stop("x_var and y_var are required for boxplot/violin.", call. = FALSE)
    }
    geom_fn <- if (plot_type == "boxplot") ggplot2::geom_boxplot else ggplot2::geom_violin

    if (is.null(group_sym)) {
      p <- p + geom_fn(ggplot2::aes(x = !!x_sym, y = !!y_sym),
                       fill  = fill_color,
                       color = color,
                       alpha = 0.7,
                       width = 0.7
      ) +
        ggplot2::scale_x_discrete()
    } else {
      p <- p + geom_fn(
        ggplot2::aes(
          x = !!x_sym,
          y = !!y_sym,
          fill = !!group_sym,
          group = !!group_sym
        ),
        color = color,
        alpha = 0.7,
        width = 0.7
      ) +
        ggplot2::scale_x_discrete()
    }
  } else if (plot_type == "barplot") {
    if (is.null(x_sym)) stop("x_var is required for barplot.", call. = FALSE)
    aes_bar <- if (is.null(group_sym)) {
      ggplot2::aes(x = !!x_sym)
    } else {
      ggplot2::aes(x = !!x_sym, fill = !!group_sym)
    }
    p <- p + ggplot2::geom_bar(aes_bar,
                               fill     = fill_color,
                               color    = color,
                               alpha    = 0.7,
                               position = if (is.null(group_sym)) "identity" else ggplot2::position_dodge2(preserve = "single")
    )
    y_lab <- y_lab %||% "Count"
  } else if (plot_type == "scatter") {

    aes_pt <- ggplot2::aes(x = !!x_sym, y = !!y_sym)

    p <- p + ggplot2::geom_point(aes_pt, color = color, alpha = 0.7)
  } else if (plot_type == "heatmap") {
    counts <- data |> dplyr::count(!!x_sym, !!y_sym)

    p <- p + ggplot2::geom_tile(
      data = counts,
      ggplot2::aes(x = !!x_sym, y = !!y_sym, fill = .data$n),
      color = color,
      alpha = 0.7
    ) +
      ggplot2::scale_fill_continuous(name = "Count")
  } else if (plot_type == "spider") {
    # radar must be provided (validated earlier)

    # Error: length of labels and variables differ
    if (!is.null(radar_labels) & length(radar_labels) != length(radar)) {
      stop(sprintf(
        "You provided %d radar values but %d labels. Make sure each value has a corresponding label.",
        length(radar), length(radar_labels)
      ), call. = FALSE)
    }

    rd <- data |>
      dplyr::select(dplyr::all_of(radar)) |>
      stats::na.omit()

    vlabels <- radar_labels %||% radar

    # Error: there is a character variable among the selected variables (we prefer factors for two-level)
    if (any(purrr::map_lgl(rd, is.character))) {
      stop("Please convert any character variable into two-level factors (e.g. 'No'/'Yes') or numeric before proceeding.", call. = FALSE)
    }

    # Error: there are different types of variables
    if (!all(purrr::map_lgl(rd, is.numeric)) & !all(purrr::map_lgl(rd, is.factor))) {
      stop("The selected variables must be either all numeric or all factors with exactly two levels.", call. = FALSE)
    }

    # Numeric variables -> rescale and create chart_df with max/min/mean
    if (all(purrr::map_lgl(rd, is.numeric))) {
      rd_scaled <- rd |>
        purrr::modify(scales::rescale) |>
        purrr::modify(round, 2)

      max_vals <- rd_scaled |> purrr::map_dbl(max, na.rm = TRUE)
      min_vals <- rd_scaled |> purrr::map_dbl(min, na.rm = TRUE)
      mean_vals <- rd_scaled |> purrr::map_dbl(mean, na.rm = TRUE)

      chart_df <- rbind(max_vals, min_vals, mean_vals) |> as.data.frame(stringsAsFactors = FALSE)
      colnames(chart_df) <- radar

      fmsb::radarchart(
        chart_df,
        axistype = 4,
        # Customize the polygon
        pcol = radar_color[1], pfcol = scales::alpha(radar_color[1], 0.1), plwd = 2, plty = 1,
        # Customize the grid
        cglcol = "darkgrey", cglty = 1, cglwd = 0.8,
        # Customize the axis
        axislabcol = "darkgrey",
        # Variable labels
        vlcex = radar_cex, vlabels = vlabels
      )
    }

    # Factor variables -> compute percent of radar_ref_lev
    if (all(purrr::map_lgl(rd, is.factor))) {
      if (any(purrr::map_lgl(rd, ~ nlevels(.x) != 2))) {
        stop("All factors must have exactly two levels. The function expects 'No' and 'Yes'(reference) by default.\nIf you use other labels, use radar_ref_level = '<your_level>' to indicate the reference level.", call. = FALSE)
      }

      perc_vals <- rd |>
        dplyr::summarise(dplyr::across(dplyr::everything(), ~ ((100 * sum(.x == radar_ref_lev)) / nrow(rd)) |> round(2))) |>
        as.numeric()

      chart_df <- rbind(rep(100, length(perc_vals)), rep(0, length(perc_vals)), perc_vals) |>
        as.data.frame(stringsAsFactors = FALSE)

      colnames(chart_df) <- radar

      fmsb::radarchart(
        chart_df,
        axistype = 1,
        # Customize the polygon
        pcol = radar_color[1], pfcol = scales::alpha(radar_color[1], 0.1), plwd = 2, plty = 1,
        # Customize the grid
        cglcol = "#5c5c5c", cglty = 1, cglwd = 0.8,
        # Customize the axis
        axislabcol = "#5c5c5c",
        # Variable labels
        vlcex = radar_cex, vlabels = vlabels
      )
    }

    return(invisible(NULL))
  }

  # Labels & facets
  p <- p + ggplot2::labs(
    title = title,
    x = x_lab %||% x_var,
    y = y_lab %||% y_var
  )
  if (!is.null(facet) && plot_type != "spider") {
    p <- p + ggplot2::facet_wrap(stats::as.formula(paste("~", facet)))
  }

  # Interactive
  if (interactive && plot_type != "spider") {

    g <- plotly::ggplotly(p) |>
      plotly::layout(
        autosize = TRUE,
        hoverlabel = list(
          bgcolor = "lightyellow",
          bordercolor = "black",
          font = list(color = "black", size = 12)
        )
      )

    if (plot_type == "histogram") {
      for (i in seq_along(g$x$data)) {
        g$x$data[[i]]$hovertemplate <- paste0("count: %{y:.0f}<br>",
          x_var, ": %{x:.2f}<extra></extra>"
        )
      }
    }

    return(g)
  }

  return(p)
}
