
<!-- README.md is generated from README.Rmd. Please edit that file -->

rintchron: R interface to IntChron
==================================

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![CRAN
status](https://www.r-pkg.org/badges/version/rintchron)](https://CRAN.R-project.org/package=rintchron)
[![R build
status](https://github.com/joeroe/rintchron/workflows/R-CMD-check/badge.svg)](https://github.com/joeroe/rintchron/actions)
<!-- badges: end -->

**rintchron** provides an R interface to
[IntChron](https://intchron.org), an indexing service and exchange
format for chronological data such as radiocarbon dates ([Bronk Ramsey
et al. 2019](https://doi.org/10.1017/RDC.2019.21)). It includes a user
friendly interface for querying databases indexed by IntChron, as well
as low level functions for interacting directly with the IntChron API
and other resources using [its schema](https://intchron.org/schema).

For a quick start guide to querying IntChron’s databases see the [basic
usage](https://rintchron.joeroe.io/articles/rintchron) vignette
(`vignette("rintchron")`). For advanced users, low level functions for
interacting with the IntChron API directly are described in the
[IntChron API](https://rintchron.joeroe.io/articles/intchron_api)
vignette (`vignette("intchron_api")`).

Installation
------------

rintchron has not yet been released on CRAN. You can install the
development version from GitHub using the
[remotes](https://remotes.r-lib.org/) package:

    # install.package("remotes")
    remotes::install_github("joeroe/rintchron")

Usage
-----

Use [`intchron()`](https://rintchron.joeroe.io/reference/intchron) to
query databases indexed by IntChron. You can refine the query by
database (use `intchron_hosts()` to see what’s available) and optionally
by country and site. For example, to download records from Jordan in the
ORAU and NERC Radiocarbon Facility databases:

    library("rintchron")

    # List available databases
    intchron_hosts()
    #> # A tibble: 5 x 2
    #>   host     database                            
    #>   <chr>    <chr>                               
    #> 1 egyptdb  Egyptian Radiocarbon Database       
    #> 2 intimate INTIMATE Database                   
    #> 3 nrcf     NERC Radiocarbon Facility (Oxford)  
    #> 4 oxa      Oxford Radiocarbon Accelerator Unit 
    #> 5 sadb     Southern Africa Radiocarbon Database

    # Query IntChron
    intchron(c("oxa", "nrcf"), countries = "Jordan")
    #> # A tibble: 156 x 18
    #>    record_site record_country record_name record_longitude record_latitude
    #>    <chr>       <chr>          <chr>                  <dbl>           <dbl>
    #>  1 Araq ed-Du… Jordan         Araq ed-Du…             32.3            35.7
    #>  2 Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
    #>  3 Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
    #>  4 Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
    #>  5 Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
    #>  6 Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
    #>  7 Azraq 31    Jordan         Azraq 31                36.8            31.8
    #>  8 Azraq 31    Jordan         Azraq 31                36.8            31.8
    #>  9 Azraq 31    Jordan         Azraq 31                36.8            31.8
    #> 10 Burqu' 02   Jordan         Burqu' 02               37.8            32.7
    #> # … with 146 more rows, and 13 more variables: series_type <chr>,
    #> #   labcode <chr>, longitude <dbl>, latitude <dbl>, sample <chr>,
    #> #   material <chr>, species <chr>, d13C <dbl>, r_date <int>,
    #> #   r_date_sigma <int>, qual <chr>, F14C <dbl>, F14C_sigma <dbl>
