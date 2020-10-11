# Low-level functions for interacting with the IntChron REST API

#' Request resources from IntChron
#'
#' Gets the requested resources from IntChron and parses them with
#' [jsonlite::fromJSON()].
#'
#' @param url Vector of addresses to IntChron resources. See [intchron_url()].
#'
#' @return
#' A list of responses.
#'
#' @export
#'
#' @examples
#' intchron_request(intchron_url("record", "oxa", "Jordan", "Dhuweila"))
intchron_request <- function(url) {
  # message(paste0("[DEBUG] Requesting <", url, ">", collapse = "\n"))
  url <- intchron_url_format(url, "json")
  url <- purrr::map_chr(url, utils::URLencode, repeated = FALSE)
  response <- purrr::map(url, jsonlite::fromJSON, flatten = FALSE)
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
