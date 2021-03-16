#' Plot string sum
#'
#' @param data as returned by \code{\link{get_data_aggregate}}
#' @param para parameter to plot (default: "Vin")
#' @param ypara either "sum" (for parameter selected in argument para
#' or "n" (number of panels), (default: "param")
#' @param interactive TRUE/FALSE
#'
#' @return string sum plot
#' @export
#'
plot_string_sum <- function(data,
                        para = "Vin",
                        ypara = "sum",
                        interactive = TRUE) {

  label <- sprintf("%s_%s", para, ypara)

  g <- data %>%
  dplyr::filter(.data$param == para) %>%
  dplyr::group_by(.data$DATETIME, .data$string) %>%
  dplyr::summarise(sum = sum(.data$value),
                   n = dplyr::n()) %>%
  ggplot2::ggplot(ggplot2::aes_string(x = "DATETIME",
                                      y = ypara,
                                      col = "string")) +
  ggplot2::geom_line() +
  ggplot2::labs(title = label) +
  ggplot2::theme_bw()

if(interactive) {
  plotly::ggplotly(g)
} else {
  print(g)
}
}

