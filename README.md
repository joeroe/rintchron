
<!-- README.md is generated from README.Rmd. Please edit that file -->

rintchron
=========

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/rintchron)](https://CRAN.R-project.org/package=rintchron)
<!-- badges: end -->

rintchron provides an R interface to [IntChron](https://intchron.org)),
an indexing service and exchange format for chronological data such as
radiocarbon dates ([Bronk Ramsey et
al. 2019](https://doi.org/10.1017/RDC.2019.21)). It includes a
user-friendly interface for querying the IntChron database, as well as
low level functions for interacting directly with the IntChron API and
other resources using [its schema](https://intchron.org/schema).

Installation
------------

rintchron has not yet been released on CRAN. You can install the
development version from GitHub using the
[remotes](https://remotes.r-lib.org/) package:

    # install.package("remotes")
    remotes::install_github("joeroe/rintchron")

Usage
-----

Use `intchron()` to query databases indexed by IntChron, optionally
filtering the results by country and/or site. For example, to download
records from Jordan in the ORAU (`oxa`) and NERC-RF (`nrcf`) databases:

    library("rintchron")
    jordan <- intchron(c("oxa", "nrcf"), countries = "Jordan")
    head(jordan)
    #>    record_site record_country  record_name record_longitude record_latitude
    #> 1 Araq ed-Dubb         Jordan Araq ed-Dubb          32.3167         35.6667
    #> 2  Ayn Qasiyah         Jordan  Ayn Qasiyah          36.8181         31.8339
    #> 3  Ayn Qasiyah         Jordan  Ayn Qasiyah          36.8181         31.8339
    #> 4  Ayn Qasiyah         Jordan  Ayn Qasiyah          36.8181         31.8339
    #> 5  Ayn Qasiyah         Jordan  Ayn Qasiyah          36.8181         31.8339
    #> 6  Ayn Qasiyah         Jordan  Ayn Qasiyah          36.8181         31.8339
    #>   series_type   labcode longitude latitude          sample material
    #> 1  R_Datelist  OxA-2567   32.3167  35.6667           WY130 charcoal
    #> 2  R_Datelist OxA-18829   36.8181  31.8339 Sample Number 8 charcoal
    #> 3  R_Datelist OxA-18830   36.8181  31.8339 Sample Number 8 charcoal
    #> 4  R_Datelist OxA-18831   36.8181  31.8339      Sample #33 charcoal
    #> 5  R_Datelist OxA-18832   36.8181  31.8339      Sample #24 charcoal
    #> 6  R_Datelist OxA-18833   36.8181  31.8339    Sample #2009 charcoal
    #>                     species    d13C r_date r_date_sigma qual     F14C
    #> 1                         - -26.100   9950          100      0.289778
    #> 2 Amygdalus (possibly almon -25.859  17550           75      0.112520
    #> 3 Amygdalus (possibly almon -26.004  17490           75      0.113330
    #> 4            chenopodiaceae -11.272  17555           75      0.112460
    #> 5                 Amygdalus -23.747  17495           70      0.113260
    #> 6           Chenopodiaeceae -11.412   9195           40      0.318350
    #>   F14C_sigma
    #> 1 0.00360734
    #> 2 0.00108000
    #> 3 0.00104000
    #> 4 0.00102000
    #> 5 0.00099000
    #> 6 0.00166000

A list of available databases can be retrieved with `intchron_hosts()`:

    intchron_hosts()
    #>       host                             database
    #> 1  egyptdb        Egyptian Radiocarbon Database
    #> 2 intimate                    INTIMATE Database
    #> 3     nrcf   NERC Radiocarbon Facility (Oxford)
    #> 4      oxa  Oxford Radiocarbon Accelerator Unit
    #> 5     sadb Southern Africa Radiocarbon Database

For advanced uses, rintchron also provides a number of functions for
interacting with the IntChron API directly; see
`vignette("intchron-api")`.
