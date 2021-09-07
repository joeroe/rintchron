# Low-level functions for interacting with the IntChron REST API

#' Request records from IntChron
#'
#' Gets the requested records from IntChron in JSON format and parses them to a
#' named list.
#'
#' @param url Vector of addresses to IntChron records. See [intchron_url()].
#' @param strict If `TRUE`, will treat non-success HTTP status codes as fatal
#'  errors. If `FALSE` (the default), will attempt to recover from them. See
#'  details.
#'
#' @return
#' A list of parsed responses.
#'
#' @details
#' This function is intended to make batch requests to IntChron, so by default
#' it tries to recover from HTTP errors wherever possible. Requests for records
#' that don't exist or which produce a server error return `NA` with a warning.
#' To disable this behaviour and stop execution when HTTP errors occur, set
#' `strict = TRUE`.
#'
#' @family functions for interacting with the IntChron API
#'
#' @export
#'
#' @examples
#' intchron_request(intchron_url("record", "oxa", "Jordan", "Dhuweila"))
intchron_request <- function(url, strict = FALSE) {
  # message(paste0("[DEBUG] Requesting <", url, ">", collapse = "\n"))
  url <- intchron_url_format(url, "json")
  url <- purrr::map_chr(url, utils::URLencode, repeated = FALSE)

  response <- purrr::map(
    url, function(url) {
      res <- httr::RETRY("GET", url,
                         httr::user_agent("https://github.com/joeroe/rintchron"))

      httr::stop_for_status(res, paste0("get record from <", url, ">"))
      stop_for_content(res)

      jsonlite::parse_json(httr::content(res, "text"), simplifyVector = TRUE)
    }
  )

  names(response) <- intchron_url_to_name(url)
  return(response)
}

#' Construct the address of IntChron resources
#'
#' Combines a series of vectors describing the location of an IntChron resource
#' or resources into a properly encoded URL.
#'
#' @param ... Character vectors describing the path to the resource or resources.
#' @param intchron_root Root address of IntChron.
#'
#' @return
#' Character vector of URLs.
#'
#' @family functions for interacting with the IntChron API
#'
#' @export
#'
#' @examples
#' # One resource
#' intchron_url("record", "oxa", "Jordan", "Dhuweila")
#'
#' # Multiple resources
#' intchron_url("record", c("oxa", "nrcf"), "Jordan", "Kharaneh IV")
intchron_url <- function(..., intchron_root = "https://intchron.org") {
  url <- paste(intchron_root, ..., sep = "/")
  return(url)
}

# URL helper functions (unexported) ----------------------------------------

#' Specify the format of an IntChron request
#'
#' Appends desired file extension to IntChron URLs, or replaces the extension
#' where there already is one.
#'
#' @param url    Vector of IntChron URLs (see [intchron_url()]).
#' @param format One of 'json', 'csv', 'txt', 'oxcal' or 'html'.
#'
#' @return
#' Character vector of URLs with the format appended.
#'
#' @noRd
intchron_url_format <- function(url, format = c("json", "csv", "txt", "oxcal", "html")) {
  format <- rlang::arg_match(format)
  url <- intchron_url_base(url)
  url <- paste0(url, ".", format)
  return(url)
}

intchron_url_to_name <- function(url) {
  url <- intchron_url_base(url)
  url <- stringr::str_remove(url, intchron_url(""))
  return(url)
}

#' Base name of an IntChron URL
#'
#' @param url A URL.
#'
#' @return
#' `url`, without any file extensions or trailing slashes.
#'
#' @noRd
intchron_url_base <- function(url) {
  # Decode special characters
  url <- purrr::map_chr(url, utils::URLdecode)

  # Strip trailing slashes
  url <- stringr::str_remove(url, "/$")
  # Strip format
  url <- tools::file_path_sans_ext(url)
  return(url)
}
