# Functions for traversing the tree of IntChron resources

#' Recursively retrieve IntChron records
#'
#' @description
#' Given an index record as a start point, this function recursively crawls the
#' tree of linked records and returns all the data records it finds.
#'
#' The ignore parameter can be used to refine the search.
#'
#' @param url Address of the record to start crawling from.
#' @param ignore Vector of names of branches that should be ignored.
#'
#' @details
#' See `vignette("intchron-api")` for a detailed explanation of the structure of
#' the IntChron record tree and the crawling algorithm used.
#'
#' @return
#' A list of responses from IntChron.
#'
#' @export
intchron_crawl <- function(url, ignore = NA) {
  response <- intchron_request(url)
  records <- purrr::flatten(intchron_extract(response, "records"))

  # If this is a data record, treat it as a terminal node
  if ("file_data" %in% names(records)) {
    return(response)
  }
  # Otherwise, look for links to other records
  else {
    links <- records$file
    links <- links[!basename(intchron_url_base(links)) %in% ignore]
    if (length(links) > 0) {
      links <- intchron_url_format(records$file, "json")
      responses <- purrr::map(links, intchron_crawl, ignore = ignore)
      responses <- do.call(c, responses)
      return(responses)
    }
    else {
      # Dead end
      return(NULL)
    }
  }
}
