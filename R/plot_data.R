#' Plot Tigo data
#'
#' @param data as returned by \code{\link{get_data_aggregate}}
#' @param param parameter to plot, one of: "Pin", "Vin", "Iin", "RSSI"
#' (default: "RSSI")
#' @param interactive if FALSE (ggplot2), if TRUE (interactive plot),
#' (default: FALSE)
#' @return plot selected parameter
#' @export
#' @import ggplot2
#' @importFrom plotly ggplotly
#'
plot_data <- function(data,
                      param = "RSSI",
                      interactive = FALSE) {

  g <- tigo_data %>%
    dplyr::filter(param == param) %>%
    ggplot2::ggplot(ggplot2::aes_string(x = "DATETIME",
                                        y = "value",
                                        col = "position")) +
    ggplot2::facet_wrap(~ string, ncol = 1) +
    ggplot2::geom_line() +
    ggplot2::labs(title = param) +
    ggplot2::theme_bw()

  if(interactive) {
    plotly::ggplotly(g)
  } else {
    print(g)
  }
}
