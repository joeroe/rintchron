# Functions for working with responses from IntChron

#' Extract an element from an IntChron record
#'
#' Requests to IntChron return JSON responses that are mapped to a complex
#' nested list by [jsonlite::fromJSON()]. This convenience function provides
#' access to specific named elements of those objects.
#'
#' @param x    List of IntChron records from [intchron_request()].
#' @param what Element to extract: 'data_url', 'records', or 'file_data'.
#'
#' @return
#' `what` from `x`.
#'
#' @family functions for interacting with the IntChron API
#'
#' @export
#'
#' @examples
#' khiv <- intchron_request(intchron_url("record", c("oxa", "nrcf"), "Jordan", "Kharaneh IV"))
#' intchron_extract(khiv, "data_url")
intchron_extract <- function(x, what) {
  switch(what,
    data_url = purrr::map(x, "data_url"),
    records = purrr::map(x, "records"),
    file_data = purrr::map(x, list("records", "file_data")),
    series_list = purrr::map(x, list("records", "file_data", "series_list")),
    stop("No method for extracting '", what, "' from an IntChron response.")
  )
}

#' Extract a data frame from IntChron responses
#'
#' Takes a list of responses from an IntChron request and extracts the data
#' series and associated metadata as a data frame.
#'
#' @param x A list of IntChron responses.
#'
#' @return
#' A `tibble` combining the data from all responses.
#'
#' @family functions for interacting with the IntChron API
#'
#' @export
#'
#' @examples
#' khiv <- intchron_request(intchron_url("record", c("oxa", "nrcf"), "Jordan", "Kharaneh IV"))
#' intchron_tabulate(khiv)
intchron_tabulate <- function(x) {
  data <- intchron_extract(x, "file_data")
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
#' A data frame.
#'
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
  # TODO

  data <- tibble::as_tibble(data)
  return(data)
}
