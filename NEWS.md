# rintchron 0.1.0

Initial release, including:

* High level functions:
  * `intchron()` queries databases indexed by IntChron.
  * `intchron_hosts()` retrieves a list of available databases.
* Low level functions:
  * `intchron_request()` and `intchron_url()` help construct requests to IntChron.
  * `intchron_crawl()` recursively retrieves records.
  * `intchron_extract()` and `intchron_tabulate()` help wrangle response data.
* Vignettes: `vignette("intchron")` and `vignette("intchron-api")`
