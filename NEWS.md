# rintchron 0.1.0

Initial release, including:

* High level functions:
  * `intchron()` queries databases indexed by IntChron.
  * `intchron_get_labcode()` and `intchron_get_doi()` fetch individual records by lab code and DOI respectively.
  * `intchron_hosts()` retrieves a list of available databases (hosts).
  * `intchron_countries()` retires a list of available countries (optionally by host).
* Low level functions:
  * `intchron_request()` and `intchron_url()` help construct requests to IntChron.
  * `intchron_crawl()` recursively retrieves records.
  * `intchron_extract()` and `intchron_tabulate()` help wrangle response data.
* Read and write functions:
  * `read_intchron_delim()` for CSV and TXT/TSV files from IntChron
* Vignettes: `vignette("rintchron")` and `vignette("intchron-api")`
