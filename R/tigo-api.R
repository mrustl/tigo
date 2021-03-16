
#' Tigo API
#'
#' @return paths to API endpoints
#' @export
#' @importFrom kwb.utils resolveAll
#' @examples
#' tigo_api()
tigo_api <- function() {
tigo_api_list <- list(base_url = "https://api2.tigoenergy.com/api/v3",
                 login = "<base_url>/users/login",
                 systems = "<base_url>/systems",
                 sources = "<base_url>/sources/system?system_id=",
                 objects =  "<base_url>/objects/system?system_id=",
                 data_aggregate = "<base_url>/data/aggregate",
                 data_combined = "<base_url>/data/combined")

kwb.utils::resolveAll(tigo_api_list)
}

#' Get token
#'
#' @return Oauth token ()
#' @export
#' @importFrom httr authenticate content GET
#' @examples
#' \dontrun{
#' Sys.setenv(TIGO_EMAIL = "myemail")
#' Sys.setenv(TIGO_PW = "mypw")
#' get_token()
#' }
get_token <- function() {

user <- httr::GET(url = tigo_api()$login,
          httr::authenticate(user = Sys.getenv("TIGO_EMAIL"),
                             password = Sys.getenv("TIGO_PW"),
                             type = "basic")
) %>% httr::content()

user$user

}

#' Tigo oauth endpoints
#'
#' @param endpoint Tigo endpoint
#' @param token Tigo token \code{\link{get_token}}
#'
#' @return data returned from endpoint
#' @export
#' @importFrom httr add_headers content GET
#' @importFrom readr read_csv read_tsv
#' @examples
#' \dontrun{
#' systems <- tigo_oauth(endpoint = tigo_api()$systems)
#' system_id <- systems$systems[[1]]$system_id
#' sources <- tigo_oauth(endpoint = sprintf("%s%d", tigo_api()$sources, system_id))
#' objects <- tigo_oauth(endpoint = sprintf("%s%d", tigo_api()$objects, system_id))
#' }
tigo_oauth <- function(endpoint, token = get_token()$auth) {
  httr::GET(url = endpoint,
            httr::add_headers(Authorization = paste("Bearer",
                                                    token))) %>%
    httr::content()

}





