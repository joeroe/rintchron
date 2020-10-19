# Read functions

#' Read a delimited file exported from IntChron
#'
#' @description
#' Reads records in the CSV and TXT (TSV) formats exported by by IntChron. These
#' are regular comma- and tab-delimited files with a few elements of
#' non-standard formatting that mean they cannot be directly parsed by generic
#' functions such as [read.delim()] or [readr::read_delim()] (see details).
#'
#' `read_intchron_csv()` and `read_intchron_tsv()`/`read_intchron_txt()` are
#' convenience aliases for `read_intchron_delim(file, delim = ",")` and
#' `read_intchron_delim(file, delim = "\t")` respectively.
#'
#' It is usually more robust to retrieve data from IntChron in JSON format using
#' [intchron()] or [intchron_request()].
#'
#' @param file Records from IntChron in .csv or .txt format. Can be either a
#'  path to a downloaded file or a URL (with or without the file extension).
#' @param delim Character used separate columns in the record data. Either `","`
#'  for CSV or `"\t"` (a tab character) for TXT/TSV.
#'
#' @details
#' Delimited files exported from IntChron have the following non-standard
#' formatting:
#'
#' * Comment lines are denoted with '#' and contain metadata before and after
#'   the table of data itself.
#' * The comment line immediately above the data contains the column headings
#' * A variable number of empty columns occur at the beginning of rows
#' * A trailing delimiter occurs at the end of every row except the header
#' * Missing values may be coded as: "", "-"
#'
#' Beyond this, some data tables are malformed (e.g. they contain unmatched
#' quotes) and cannot be parsed.
#'
#' @return
#' A `tibble` containing the data from the record.
#'
#' Associated metadata is discarded.
#'
#' @family read and write functions
#'
#' @export
read_intchron_delim <- function(file, delim = c(",", "\t")) {
  delim <- rlang::arg_match(delim)

  # Format URLs
  if (stringr::str_starts(file, stringr::coll("http"))) {
    if (delim == ",") fileext <- "csv"
    else if (delim == "\t") fileext <- "txt"
    file <- intchron_url_format(file, fileext)
  }

  lines <- readr::read_lines(file)

  # Check whether there's actually any non-comment lines
  if (all(grepl("^#", lines) | grepl("^$", lines))) {
    return(data.frame(NA))
  }

  # Reformat the header row
  nheader <- grep("^[^#].+$", lines)[1] - 1
  lines[nheader] <- sub("#", "", lines[nheader])
  lines[nheader] <- paste0(lines[nheader], delim)

  # Read data table
  data <- utils::read.delim(text = lines, sep = delim, stringsAsFactors = FALSE,
                            comment.char = "#", na.strings = c("", "-"))

  # Drop unnamed columns (assumed to be empty)
  data <- data[!grepl("^X(\\.[0-9]+)?$", names(data))]

  data <- tibble::as_tibble(data)
  return(data)
}

#' @rdname read_intchron_delim
#' @export
read_intchron_csv <- function(file) {
  read_intchron_delim(file, delim = ",")
}

#' @rdname read_intchron_delim
#' @export
read_intchron_tsv <- function(file) {
  read_intchron_delim(file, delim = "\t")
}

#' @rdname read_intchron_delim
#' @export
read_intchron_txt <- function(file) {
  read_intchron_delim(file, delim = "\t")
}
