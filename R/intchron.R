# High-level interface to IntChron

#' Query IntChron
#'
#' IntChron is an indexing service for chronological data from multiple sources.
#' This function gets records from databases ('hosts') indexed by IntChron,
#' optionally filtering by country and/or site.
#'
#' @param hosts Vector of databases to be retrieved, or "all".
#' @param countries (Optional) Vector of countries to be retrieved.
#' @param sites (Optional) Vector of sites to be retrieved.
#' @param tabulate If `TRUE` (the default), the data retrieved will be combined
#'  into a data frame. Set `FALSE` to get the raw data from IntChron.
#'
#' @details
#' At least `hosts` must be specified. Use `intchron_hosts()` to get a list of
#' currently available hosts, or "all" to retrieve data from any database.
#'
#' See `vignette("rintchron")` for further details.
#'
#' @return
#' A `tibble`, or if `tabulate = FALSE`, a list, of IntChron responses.
#'
#' @family functions for querying IntChron
#'
#' @export
#'
#' @examples
#' # Get data from Jordan from the ORAU and NERC databases
#' intchron(c("oxa", "nrcf"), countries = "Jordan")
intchron <- function(hosts,
                     countries = NA,
                     sites = NA,
                     tabulate = TRUE) {

  # Validate hosts
  if(any(hosts == "all")) {
    hosts <- "all"
  }
  else {
    intchron_assert_host(hosts)
  }

  # Determine entry record(s) for crawling
  entry <- data.frame(record = "record")
  if (!any(hosts == "all")) {
    entry <- cbind(entry, host = hosts)
  }
  if (!all(is.na(countries))) {
    entry <- cbind(entry, country = rep(countries, each = nrow(entry)))
  }
  if (!all(is.na(sites))) {
    warning("Filtering by sites not yet implemented.")
  }
  entry <- purrr::pmap(entry, intchron_url)

  # Start crawling
  responses <- purrr::map(entry, intchron_crawl)
  # First level of nesting is by entry point, which we don't need.
  responses <- purrr::flatten(responses)

  if (!tabulate) {
    return(responses)
  }
  else {
    return(intchron_tabulate(responses))
  }
}


# Helper functions --------------------------------------------------------

#' List available databases and countries on IntChron
#'
#' These functions query IntChron to list the available databases ('hosts') or
#' countries (optionally filtering by host).
#'
#' @param hosts Vector of databases to query (for list of available countries).
#'  Leave `NA` to list countries from all hosts.
#'
#' @return
#' A `tibble` of available hosts or countries.
#'
#' @family functions for querying IntChron
#'
#' @export
#'
#' @examples
#' # List available hosts
#' intchron_hosts()
#'
#' # List available countries
#' intchron_countries()
#'
#' # List available countries for specific hosts
#' intchron_countries(c("intimate", "egyptdb"))
intchron_hosts <- function() {
  hosts <- intchron_request(intchron_url("host"))
  hosts <- intchron_extract(hosts, "records")
  hosts <- hosts$host
  names(hosts) <- c("database", "host")
  hosts <- hosts[,2:1]
  hosts$host <- intchron_url_to_name(hosts$host)
  hosts$host <- stringr::str_remove(hosts$host, stringr::coll("host/"))
  hosts <- tibble::as_tibble(hosts)
  return(hosts)
}

#' @rdname intchron_hosts
#' @export
intchron_countries <- function(hosts = NA) {
  if (all(is.na(hosts))) {
    countries <- intchron_request(intchron_url("record"))
  }
  else {
    intchron_assert_host(hosts)
    urls <- purrr::map_chr(hosts, ~intchron_url(.x, "record"))
    countries <- intchron_request(urls)
  }

  countries <- intchron_extract(countries, "records")
  countries <- purrr::map(countries, "country")
  countries <- purrr::map_dfr(countries, ~data.frame(country = .x), .id = "host")

  if (all(is.na(hosts))) {
    countries$host <- NULL
  }
  else {
    countries$host <- stringr::str_remove(countries$host, stringr::coll("/record"))
  }

  countries <- tibble::as_tibble(countries)
  return(countries)
}


# Utility functions (unexported) ------------------------------------------

#' @noRd
intchron_assert_host <- function(hosts) {
  available_hosts <- intchron_hosts()$host
  if (!all(hosts %in% available_hosts)) {
    bad_hosts <- hosts[!hosts %in% available_hosts]
    stop("Hosts not available on IntChron: ",
         paste0(bad_hosts, collapse = ", "),
         call. = FALSE)
  }
  invisible(hosts)
}
