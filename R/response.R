# Functions for working with responses from IntChron

#' Extract an element from an IntChron record
#'
#' Requests to IntChron return JSON responses that are mapped to a complex
#' nested list by [jsonlite::fromJSON()]. This convenience function provides
#' access to specific named elements of those objects.
#'
#' @param x    List of IntChron records from [intchron_request()].
#' @param what Element to extract: `"data_url"`, `"records"`, `"file_data"`, or
#'  `"series_file_data"`
#'
#' @return
#' `what` from `x`.
#'
#' @family functions for interacting with the IntChron API
#'
#' @references
#' * IntChron Data Schema <http://intchron.org/schema>
#'
#' @export
#'
#' @examples
#' khiv <- intchron_request(intchron_url("record", c("oxa", "nrcf"), "Jordan", "Kharaneh IV"))
#' intchron_extract(khiv, "data_url")
intchron_extract <- function(x, what) {
  y <- switch(what,
    data_url = purrr::map(x, "data_url"),
    records = purrr::map(x, "records"),
    file_data = purrr::map(x, list("records", "file_data")),
    series_file_data = purrr::map(x, list("project_series_list", "file_data")),
    series_list = purrr::map(x, list("records", "file_data", "series_list")),
    stop('No method for extracting "', what, '" from an IntChron response.')
  )

  if (any(purrr::map_lgl(y, is.null))) {
    stop('"', what, '" not found in IntChron response `x`')
  }

  return(y)
}


# Parse -------------------------------------------------------------------

intchron_parse_response <- function(response) {

}

# S3 response object ------------------------------------------------------

intchron_resource <- function(request, response, content) {
  structure(
    list(
      request = request,
      response = response,
      content = content
    ),
    class = "intchron_resource"
  )
}

print.intchron_resource <- function(x, ...) {
  cat("<IntChron ", x$request, ">\n", sep = "")
  str(x$content, max.level = 1)
  invisible(x)
}

#' Extract a data frame from IntChron responses
#'
#' Takes a list of responses from an IntChron request and extracts the data
#' series and associated metadata as a data frame.
#'
#' @param x A list of IntChron responses.
#' @param series Logical. Are records stored in a "project_series_list" instead
#'  of an array of records? Default: `FALSE`.
#'
#' @return
#' A `tibble` combining the data from all responses. Bibliographic references
#' are returned as a list-column containing a vector of citation keys (ref: or
#' doi:) for each record.
#'
#' @family functions for interacting with the IntChron API
#'
#' @references
#' * IntChron Data Schema <http://intchron.org/schema>
#'
#' @export
#'
#' @examples
#' khiv <- intchron_request(intchron_url("record", c("oxa", "nrcf"), "Jordan", "Kharaneh IV"))
#' intchron_tabulate(khiv)
intchron_tabulate <- function(x, series = FALSE) {
  if (series) {
    data <- intchron_extract(x, "series_file_data")
  }
  else {
    data <- intchron_extract(x, "file_data")
  }
  data <- purrr::map_dfr(data,
                         ~intchron_tabulate_series(.x$series_list, .x$header))
  return(data)
}

#' Tabulate a series list
#'
#' @param series_list List of data series from IntChron.
#' @param header List of metadata from IntChron.
#'
#' @return
#' A tibble.
#'
#' @keywords internal
#' @noRd
intchron_tabulate_series <- function(series_list, header) {
  # Pull out series data as a data frame
  data <- purrr::map_dfr(series_list,
                         ~data.frame(series_type = .x$series_type,
                                     purrr::map_dfc(.x$data, unlist)))

  # Format and append 'header' metadata
  names(header) <- paste0("record_", names(header))
  names(header)[names(header) == "record_record"] <- "record_name"
  rownames(header) <- NULL
  data <- cbind(header, data)

  # Append references
  refs <- purrr::pluck(series_list, 1, "refs")
  refs <- paste0(refs)
  data <- cbind(data, refs = refs)

  # Make NAs explicit
  data <- tibble::as_tibble(data)
  data <- dplyr::mutate(
    data,
    dplyr::across(
      dplyr::everything(),
      ~ .x %>%
        dplyr::na_if("") %>%
        dplyr::na_if("-")
    )
  )

  return(data)
}


# Validate ----------------------------------------------------------------

#' Validate the content type of an IntChron response
#'
#' Causes an error if the content type is not "text/plain" or if it has no
#' content.
#'
#' @param response A [httr::response] object.
#'
#' @return
#' `response` invisibly, or an error if invalid.
#'
#' @noRd
#' @keywords internal
stop_for_content <- function(response) {
  if (isFALSE(httr::has_content(response))) {
    rlang::abort(c(
      paste0("invalid response from <", response$url, ">."),
      x = "Content is empty."
    ))
  }

  if (httr::http_type(response) != "text/plain") {
    rlang::abort(c(
      paste0("invalid response from <", response$url, ">."),
      x = paste0("Content type is ", httr::http_type(response),
                 " (expected text/plain).")
    ))
  }

  invisible(response)
}
