
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rintchron: R interface to IntChron

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
usage vignette](https://rintchron.joeroe.io/articles/rintchron). For
advanced users, low level functions for interacting with the IntChron
API directly are described in the [IntChron API
vignette](https://rintchron.joeroe.io/articles/intchron_api).

## Installation

rintchron has not yet been released on CRAN. You can install the
development version from GitHub using the
[remotes](https://remotes.r-lib.org/) package:

``` r
# install.package("remotes")
remotes::install_github("joeroe/rintchron")
```

## Usage

Use [`intchron()`](https://rintchron.joeroe.io/reference/intchron) to
query databases indexed by IntChron. You can refine the query by
database (use `intchron_hosts()` to see what’s available) and optionally
by country and site. For example, to download records from Jordan in the
ORAU and NERC Radiocarbon Facility databases:

``` r
library("rintchron")

# List available databases
intchron_hosts()
#> [90m# A tibble: 5 x 2[39m
#>   host     database                            
#>   [3m[90m<chr>[39m[23m    [3m[90m<chr>[39m[23m                               
#> [90m1[39m egyptdb  Egyptian Radiocarbon Database       
#> [90m2[39m intimate INTIMATE Database                   
#> [90m3[39m nrcf     NERC Radiocarbon Facility (Oxford)  
#> [90m4[39m oxa      Oxford Radiocarbon Accelerator Unit 
#> [90m5[39m sadb     Southern Africa Radiocarbon Database

# Query IntChron
intchron(c("oxa", "nrcf"), countries = "Jordan")
#> [90m# A tibble: 156 x 18[39m
#>    record_site record_country record_name record_longitude record_latitude
#>    [3m[90m<chr>[39m[23m       [3m[90m<chr>[39m[23m          [3m[90m<chr>[39m[23m                  [3m[90m<dbl>[39m[23m           [3m[90m<dbl>[39m[23m
#> [90m 1[39m Araq ed-Du… Jordan         Araq ed-Du…             32.3            35.7
#> [90m 2[39m Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
#> [90m 3[39m Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
#> [90m 4[39m Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
#> [90m 5[39m Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
#> [90m 6[39m Ayn Qasiyah Jordan         Ayn Qasiyah             36.8            31.8
#> [90m 7[39m Azraq 31    Jordan         Azraq 31                36.8            31.8
#> [90m 8[39m Azraq 31    Jordan         Azraq 31                36.8            31.8
#> [90m 9[39m Azraq 31    Jordan         Azraq 31                36.8            31.8
#> [90m10[39m Burqu' 02   Jordan         Burqu' 02               37.8            32.7
#> [90m# … with 146 more rows, and 13 more variables: series_type [3m[90m<chr>[90m[23m,[39m
#> [90m#   labcode [3m[90m<chr>[90m[23m, longitude [3m[90m<dbl>[90m[23m, latitude [3m[90m<dbl>[90m[23m, sample [3m[90m<chr>[90m[23m,[39m
#> [90m#   material [3m[90m<chr>[90m[23m, species [3m[90m<chr>[90m[23m, d13C [3m[90m<dbl>[90m[23m, r_date [3m[90m<int>[90m[23m,[39m
#> [90m#   r_date_sigma [3m[90m<int>[90m[23m, qual [3m[90m<chr>[90m[23m, F14C [3m[90m<dbl>[90m[23m, F14C_sigma [3m[90m<dbl>[90m[23m[39m
```
