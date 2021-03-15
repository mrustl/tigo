library(magrittr)

tigo_api_list <- list(base_url = "https://api2.tigoenergy.com/api/v3",
                 login = "<base_url>/users/login",
                 systems = "<base_url>/systems",
                 sources = "<base_url>/sources/system?system_id=",
                 objects =  "<base_url>/objects/system?system_id=")

tigo_api <- kwb.utils::resolveAll(tigo_api_list)


get_token <- function() {

user <- httr::GET(url = tigo_api$login,
          httr::authenticate(user = Sys.getenv("TIGO_EMAIL"),
                             password = Sys.getenv("TIGO_PW"),
                             type = "basic")
) %>% httr::content()

user$user

}

tigo_oauth <- function(endpoint, token = get_token()$auth) {
  httr::GET(url = endpoint,
            httr::add_headers(Authorization = paste("Bearer",
                                                    token))) %>%
    httr::content()

}


systems <- tigo_oauth(endpoint = tigo_api$systems)

system_id <- tigo_systems$systems[[1]]$system_id

sources <- tigo_oauth(endpoint = sprintf("%s%d",
                                         tigo_api$sources, system_id))

objects <- tigo_oauth(endpoint = sprintf("%s%d",
                                         tigo_api$objects, system_id))
