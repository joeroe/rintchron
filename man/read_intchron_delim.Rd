% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read.R
\name{read_intchron_delim}
\alias{read_intchron_delim}
\alias{read_intchron_csv}
\alias{read_intchron_tsv}
\alias{read_intchron_txt}
\title{Read a delimited file exported from IntChron}
\usage{
read_intchron_delim(file, delim = c(",", "\\t"))

read_intchron_csv(file)

read_intchron_tsv(file)

read_intchron_txt(file)
}
\arguments{
\item{file}{Records from IntChron in .csv or .txt format. Can be either a
path to a downloaded file or a URL (with or without the file extension).}

\item{delim}{Character used separate columns in the record data. Either \code{","}
for CSV or \code{"\\t"} (a tab character) for TXT/TSV.}
}
\value{
A \code{tibble} containing the data from the record.

Associated metadata is discarded.
}
\description{
Reads records in the CSV and TXT (TSV) formats exported by by IntChron. These
are regular comma- and tab-delimited files with a few elements of
non-standard formatting that mean they cannot be directly parsed by generic
functions such as \code{\link[=read.delim]{read.delim()}} or \code{\link[readr:read_delim]{readr::read_delim()}} (see details).

\code{read_intchron_csv()} and \code{read_intchron_tsv()}/\code{read_intchron_txt()} are
convenience aliases for \code{read_intchron_delim(file, delim = ",")} and
\code{read_intchron_delim(file, delim = "\\t")} respectively.

It is usually more robust to retrieve data from IntChron in JSON format using
\code{\link[=intchron]{intchron()}} or \code{\link[=intchron_request]{intchron_request()}}.
}
\details{
Delimited files exported from IntChron have the following non-standard
formatting:
\itemize{
\item Comment lines are denoted with '#' and contain metadata before and after
the table of data itself.
\item The comment line immediately above the data contains the column headings
\item A variable number of empty columns occur at the beginning of rows
\item A trailing delimiter occurs at the end of every row except the header
\item Missing values may be coded as: "", "-"
}

Beyond this, some data tables are malformed (e.g. they contain unmatched
quotes) and cannot be parsed.
}
\concept{read and write functions}
