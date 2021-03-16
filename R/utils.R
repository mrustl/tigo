#' Helper function: convert to ISO datetime
#'
#' @param datetime date time string as returned by Sys.time()
#'
#' @return reformats to ISO datetime
#' @export
#'
#' @examples
#' to_iso_datetime(Sys.time())
#'
to_iso_datetime <- function(datetime) {
  format(datetime, format = "%Y-%m-%dT%H:%M:%S")
}

