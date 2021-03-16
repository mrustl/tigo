
#' Get data aggregate
#'
#' @param system_id ID of the system (integer), (default: as.numeric(Sys.getenv("TIGO_ID")))
#' @param datetime_min Start datetime of data (default: Sys.time() - 7*24*3600)
#' @param datetime_max End datetime of data (default: Sys.time())
#' @param level "min" (minute ) or "day" (aggregates), default: "min"
#' @param sensors Whether to include sensor data TRUE/FALSE (default: TRUE)
#' @param params Type of data to return (default: c("Pin", "Vin", "Iin", "RSSI"))
#' @param header either "id" or "key" header (default: "key")
#' @param tz time zone of system (default: "")
#' @return list with data
#' @export
#' @importFrom data.table rbindlist
#' @importFrom stringr str_to_lower str_extract
#' @importFrom dplyr across filter mutate
#' @importFrom tidyr separate pivot_longer
#' @import tidyselect
#' @importFrom rlang .data
#' @importFrom tibble as_tibble
get_data_aggregate <- function(system_id = as.numeric(Sys.getenv("TIGO_ID")),
                               datetime_min = Sys.time() - 7*24*3600,
                               datetime_max = Sys.time(),
                               level = "min",
                               sensors = TRUE,
                               params = c("Pin", "Vin", "Iin", "RSSI"),
                               header = "key",
                               tz = "") {



  data.table::rbindlist(
    setNames(lapply(params, FUN = function(param) {


    endpoint <- sprintf("%s?system_id=%d&start=%s&end=%s&level=%s&sensors=%s&param=%s&header=%s",
                        tigo_api()$data_aggregate,
                        as.numeric(system_id),
                        to_iso_datetime(datetime_min),
                        to_iso_datetime(datetime_max),
                        level,
                        stringr::str_to_lower(as.character(sensors)),
                        param,
                        header)
    tigo_oauth(endpoint) %>%
      dplyr::filter(DATETIME != "DATETIME") %>%
      dplyr::mutate(DATETIME = as.POSIXct(DATETIME, tz = tz)) %>%
      dplyr::mutate(dplyr::across(tidyselect:::where(is.character), function(x){as.numeric(x)})) %>%
      tidyr::pivot_longer(cols = -tidyselect::any_of("DATETIME"),
                          names_to = c("cca_mac", "type", "id_paramheader"),
                          names_sep = "\\.") %>%
      tidyr::separate(col = "id_paramheader", into = c("id", "paramheader")) %>%
      dplyr::mutate(string = stringr::str_extract(id, "^[A-Z]"),
                    position = stringr::str_extract(id, "[0-9]+?$"))
  }),
  nm = params),
  idcol = "param"
  ) %>%
  tibble::as_tibble() %>%
  dplyr::filter(!is.na(value))

}
