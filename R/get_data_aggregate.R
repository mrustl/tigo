
#' Get data aggregate
#'
#' @param system_id ID of the system (integer)
#' @param datetime_min Start datetime of data (default: Sys.time() - 7*24*3600)
#' @param datetime_max End datetime of data (default: Sys.time())
#' @param level "min" (minute ) or "day" (aggregates), default: "min"
#' @param sensors Whether to include sensor data TRUE/FALSE (default: TRUE)
#' @param params Type of data to return (default: c("Pin", "Vin", "Iin", "RSSI"))
#' @param header either "id" or "key" header (default: "key")
#' @return list with data
#' @export
#' @importFrom stringr str_to_lower
#'
get_data_aggregate <- function(system_id,
                               datetime_min = Sys.time() - 7*24*3600,
                               datetime_max = Sys.time(),
                               level = "min",
                               sensors = TRUE,
                               params = c("Pin", "Vin", "Iin", "RSSI"),
                               header = "key") {



  lapply(params, function(param) {


    endpoint <- sprintf("%s?system_id=%d&start=%s&end=%s&level=%s&sensors=%s&param=%s&header=%s",
                        tigo_api$data_aggregate,
                        system_id,
                        to_iso_datetime(datetime_min),
                        to_iso_datetime(datetime_max),
                        level,
                        stringr::str_to_lower(as.character(sensors)),
                        param,
                        header)
    tigo_oauth(endpoint) })

}
