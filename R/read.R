# Read functions

#' Read a CSV file from IntChron
#'
#' @description
#' Reads records in the CSV format exported by by IntChron. These are regular
#' CSV files with a few elements of non-standard formatting that mean they can't
#' be directly parsed by e.g. [read.csv()] or [readr::read_csv()] (see details).
#'
#' It is usually more robust to retrieve data from IntChron in JSON format using
#' [intchron()] or [intchron_request()].
#'
#' @param file CSV records exported from IntChron; either a path to a downloaded
#'  file, a URL, or literal data. Use [readr::clipboard()] to read from the
#'  system clipboard.
#'
#' @details
#' CSV files exported from IntChron have the following non-standard formatting:
#'
#' * Comment lines are denoted with '#' and contain metadata before and after
#'   the table of data itself.
#' * The comment line immediately above the data contains the column headings
#' * A variable number of empty columns occur at the beginning of rows
#' * A trailing comma occurs at the end of every row except the header
#' * Missing values may be coded as: "", "-"
#'
#' Beyond this, some data tables are malformed (e.g. they contain unmatched
#' quotes) and cannot be parsed without an error.
#'
#' @return
#' A `tibble` containing the data from the record. Associated metadata is
#' discarded.
#'
#' @family read and write functions
#'
#' @export
read_intchron_csv <- function(file) {
  lines <- readr::read_lines(file)

  # Check whether there's actually any non-comment lines
  if (all(grepl("^#", lines) | grepl("^$", lines))) {
    return(data.frame(NA))
  }

  # Reformat the header row
  nheader <- grep("^,", lines)[1] - 1
  lines[nheader] <- sub("#", "", lines[nheader])
  lines[nheader] <- paste0(lines[nheader], ",")

  # Read data table
  data <- utils::read.csv(text = lines, stringsAsFactors = FALSE,
                          comment.char = "#", na.strings = c("", "-"))

  # Drop unnamed columns (assumed to be empty)
  data <- data[!grepl("^X(\\.[0-9]+)?$", names(data))]

  data <- tibble::as_tibble(data)
  return(data)
}
