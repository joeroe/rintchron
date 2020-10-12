# High-level interface to IntChron

#' Get data from IntChron
#'
#' IntChron is an indexing service for chronological data from multiple sources.
#' This function queries IntChron to retrieve data from the specified database
#' ('host'), countries and sites.
#'
#' @param hosts Databases to be retrieved. See details.
#' @param countries Vector of countries to be retrieved. See details.
#' @param sites Vector of sites to be retrieved. See details.
#' @param tabulate If `TRUE` (the default), the data retrieved will be combined
#'  into a data frame. Set `FALSE` to get the raw data from IntChron.
#'
#' @details
#' See `vignette("intchron")`.
#'
#' @return
#' At least `hosts` must be specified. Use `intchron_hosts()` to get a list of
#' currently available hosts, or "all" to retrieve data from any database.
#'
#' A data frame, or if `tabulate = FALSE`, a list of IntChron responses.
#'
#' @export
#'
#' @examples
#' # List available databases
#' intchron_hosts()
#'
#' # Get all data from Jordan
#' intchron("all", countries = "Jordan")
intchron <- function(hosts,
                     countries = NA,
                     sites = NA,
                     tabulate = TRUE) {

  # Validate hosts
  if(any(hosts == "all")) {
    hosts <- "all"
  }
  else {
    available_hosts <- intchron_hosts()$host
    if (!all(hosts %in% available_hosts)) {
      bad_hosts <- hosts[!hosts %in% available_hosts]
      stop("Hosts not available on IntChron: ",
           paste0(bad_hosts, collapse = ", "))
    }
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

#' @rdname intchron
#' @export
intchron_hosts <- function() {
  hosts <- intchron_request(intchron_url("host"))
  hosts <- intchron_extract(hosts, "records")
  hosts <- hosts$host
  names(hosts) <- c("database", "host")
  hosts <- hosts[,2:1]
  hosts$host <- intchron_url_to_name(hosts$host)
  hosts$host <- stringr::str_remove(hosts$host, stringr::coll("host/"))
  return(hosts)
}
