
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
    #>       host                             database
    #> 1  egyptdb        Egyptian Radiocarbon Database
    #> 2 intimate                    INTIMATE Database
    #> 3     nrcf   NERC Radiocarbon Facility (Oxford)
    #> 4      oxa  Oxford Radiocarbon Accelerator Unit
    #> 5     sadb Southern Africa Radiocarbon Database

    # Query IntChron
    intchron(c("oxa", "nrcf"), countries = "Jordan")
    #>                record_site record_country            record_name
    #> 1             Araq ed-Dubb         Jordan           Araq ed-Dubb
    #> 2              Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 3              Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 4              Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 5              Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 6              Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 7                 Azraq 31         Jordan               Azraq 31
    #> 8                 Azraq 31         Jordan               Azraq 31
    #> 9                 Azraq 31         Jordan               Azraq 31
    #> 10               Burqu' 02         Jordan              Burqu' 02
    #> 11               Burqu' 03         Jordan              Burqu' 03
    #> 12               Burqu' 27         Jordan              Burqu' 27
    #> 13               Burqu' 27         Jordan              Burqu' 27
    #> 14               Burqu' 27         Jordan              Burqu' 27
    #> 15               Burqu' 35         Jordan              Burqu' 35
    #> 16               Burqu' 35         Jordan              Burqu' 35
    #> 17               Burqu' 35         Jordan              Burqu' 35
    #> 18  Dahikiya, Badia Region         Jordan Dahikiya, Badia Region
    #> 19  Dahikiya, Badia Region         Jordan Dahikiya, Badia Region
    #> 20                Dhuweila         Jordan               Dhuweila
    #> 21                Dhuweila         Jordan               Dhuweila
    #> 22                Dhuweila         Jordan               Dhuweila
    #> 23                Dhuweila         Jordan               Dhuweila
    #> 24             Kharaneh IV         Jordan            Kharaneh IV
    #> 25             Kharaneh IV         Jordan            Kharaneh IV
    #> 26             Kharaneh IV         Jordan            Kharaneh IV
    #> 27             Kharaneh IV         Jordan            Kharaneh IV
    #> 28             Kharaneh IV         Jordan            Kharaneh IV
    #> 29             Kharaneh IV         Jordan            Kharaneh IV
    #> 30             Kharaneh IV         Jordan            Kharaneh IV
    #> 31           Shuna Project         Jordan          Shuna Project
    #> 32           Shuna Project         Jordan          Shuna Project
    #> 33           Shuna Project         Jordan          Shuna Project
    #> 34           Shuna Project         Jordan          Shuna Project
    #> 35           Shuna Project         Jordan          Shuna Project
    #> 36           Shuna Project         Jordan          Shuna Project
    #> 37           Shuna Project         Jordan          Shuna Project
    #> 38           Shuna Project         Jordan          Shuna Project
    #> 39           Shuna Project         Jordan          Shuna Project
    #> 40           Shuna Project         Jordan          Shuna Project
    #> 41           Shuna Project         Jordan          Shuna Project
    #> 42           Shuna Project         Jordan          Shuna Project
    #> 43           Shuna Project         Jordan          Shuna Project
    #> 44           Shuna Project         Jordan          Shuna Project
    #> 45           Shuna Project         Jordan          Shuna Project
    #> 46           Shuna Project         Jordan          Shuna Project
    #> 47           Shuna Project         Jordan          Shuna Project
    #> 48           Shuna Project         Jordan          Shuna Project
    #> 49           Shuna Project         Jordan          Shuna Project
    #> 50           Shuna Project         Jordan          Shuna Project
    #> 51           Shuna Project         Jordan          Shuna Project
    #> 52           Shuna Project         Jordan          Shuna Project
    #> 53      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 54      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 55      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 56      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 57      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 58      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 59      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 60      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 61      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 62      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 63      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 64      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 65      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 66      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 67      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 68      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 69      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 70      Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 71        Tell Abu en-Niaj         Jordan       Tell Abu en-Niaj
    #> 72        Tell Abu en-Niaj         Jordan       Tell Abu en-Niaj
    #> 73        Tell Abu en-Niaj         Jordan       Tell Abu en-Niaj
    #> 74          Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 75          Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 76          Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 77          Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 78            Tell el-Hibr         Jordan           Tell el-Hibr
    #> 79             Tell Hesban         Jordan            Tell Hesban
    #> 80              Wadi Jilat         Jordan             Wadi Jilat
    #> 81              Wadi Jilat         Jordan             Wadi Jilat
    #> 82              Wadi Jilat         Jordan             Wadi Jilat
    #> 83              Wadi Jilat         Jordan             Wadi Jilat
    #> 84              Wadi Jilat         Jordan             Wadi Jilat
    #> 85              Wadi Jilat         Jordan             Wadi Jilat
    #> 86              Wadi Jilat         Jordan             Wadi Jilat
    #> 87              Wadi Jilat         Jordan             Wadi Jilat
    #> 88              Wadi Jilat         Jordan             Wadi Jilat
    #> 89              Wadi Jilat         Jordan             Wadi Jilat
    #> 90              Wadi Jilat         Jordan             Wadi Jilat
    #> 91           Wadi Jilat 13         Jordan          Wadi Jilat 13
    #> 92           Wadi Jilat 22         Jordan          Wadi Jilat 22
    #> 93           Wadi Jilat 22         Jordan          Wadi Jilat 22
    #> 94           Wadi Jilat 25         Jordan          Wadi Jilat 25
    #> 95             Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 96             Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 97             Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 98             Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 99             Ayn Qasiyah         Jordan            Ayn Qasiyah
    #> 100 Dahikiya, Badia Region         Jordan Dahikiya, Badia Region
    #> 101 Dahikiya, Badia Region         Jordan Dahikiya, Badia Region
    #> 102            Kharaneh IV         Jordan            Kharaneh IV
    #> 103            Kharaneh IV         Jordan            Kharaneh IV
    #> 104            Kharaneh IV         Jordan            Kharaneh IV
    #> 105            Kharaneh IV         Jordan            Kharaneh IV
    #> 106            Kharaneh IV         Jordan            Kharaneh IV
    #> 107            Kharaneh IV         Jordan            Kharaneh IV
    #> 108            Kharaneh IV         Jordan            Kharaneh IV
    #> 109          Shuna Project         Jordan          Shuna Project
    #> 110          Shuna Project         Jordan          Shuna Project
    #> 111          Shuna Project         Jordan          Shuna Project
    #> 112          Shuna Project         Jordan          Shuna Project
    #> 113          Shuna Project         Jordan          Shuna Project
    #> 114          Shuna Project         Jordan          Shuna Project
    #> 115          Shuna Project         Jordan          Shuna Project
    #> 116          Shuna Project         Jordan          Shuna Project
    #> 117          Shuna Project         Jordan          Shuna Project
    #> 118          Shuna Project         Jordan          Shuna Project
    #> 119          Shuna Project         Jordan          Shuna Project
    #> 120          Shuna Project         Jordan          Shuna Project
    #> 121          Shuna Project         Jordan          Shuna Project
    #> 122          Shuna Project         Jordan          Shuna Project
    #> 123          Shuna Project         Jordan          Shuna Project
    #> 124          Shuna Project         Jordan          Shuna Project
    #> 125          Shuna Project         Jordan          Shuna Project
    #> 126          Shuna Project         Jordan          Shuna Project
    #> 127          Shuna Project         Jordan          Shuna Project
    #> 128          Shuna Project         Jordan          Shuna Project
    #> 129          Shuna Project         Jordan          Shuna Project
    #> 130          Shuna Project         Jordan          Shuna Project
    #> 131     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 132     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 133     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 134     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 135     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 136     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 137     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 138     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 139     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 140     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 141     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 142     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 143     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 144     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 145     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 146     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 147     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 148     Tell Abu Al-Kharaz         Jordan     Tell Abu Al-Kharaz
    #> 149       Tell Abu en-Niaj         Jordan       Tell Abu en-Niaj
    #> 150       Tell Abu en-Niaj         Jordan       Tell Abu en-Niaj
    #> 151       Tell Abu en-Niaj         Jordan       Tell Abu en-Niaj
    #> 152         Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 153         Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 154         Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 155         Tell el-Hayyat         Jordan         Tell el-Hayyat
    #> 156            Tell Hesban         Jordan            Tell Hesban
    #>     record_longitude record_latitude series_type   labcode longitude latitude
    #> 1            32.3167         35.6667  R_Datelist  OxA-2567   32.3167  35.6667
    #> 2            36.8181         31.8339  R_Datelist OxA-18829   36.8181  31.8339
    #> 3            36.8181         31.8339  R_Datelist OxA-18830   36.8181  31.8339
    #> 4            36.8181         31.8339  R_Datelist OxA-18831   36.8181  31.8339
    #> 5            36.8181         31.8339  R_Datelist OxA-18832   36.8181  31.8339
    #> 6            36.8181         31.8339  R_Datelist OxA-18833   36.8181  31.8339
    #> 7            36.8167         31.8000  R_Datelist   OxA-870    0.0000   0.0000
    #> 8            36.8167         31.8000  R_Datelist   OxA-871    0.0000   0.0000
    #> 9            36.8167         31.8000  R_Datelist  OxA-2412   36.8167  31.8000
    #> 10           37.8333         32.6667  R_Datelist  OxA-2807   37.8333  32.6667
    #> 11           37.8333         32.6667  R_Datelist  OxA-2808   37.8333  32.6667
    #> 12           37.8333         32.6667  R_Datelist  OxA-2764   37.8333  32.6667
    #> 13           37.8333         32.6667  R_Datelist  OxA-2765   37.8333  32.6667
    #> 14           37.8333         32.6667  R_Datelist  OxA-2766   37.8333  32.6667
    #> 15           37.8333         32.6667  R_Datelist  OxA-2768   37.8333  32.6667
    #> 16           37.8333         32.6667  R_Datelist  OxA-2769   37.8333  32.6667
    #> 17           37.8333         32.6667  R_Datelist  OxA-2770   37.8333  32.6667
    #> 18           31.6000         37.1000  R_Datelist OxA-11594   31.6000  37.1000
    #> 19           31.6000         37.1000  R_Datelist OxA-11595   31.6000  37.1000
    #> 20           37.2500         32.0833  R_Datelist  OxA-1636    0.0000   0.0000
    #> 21           37.2500         32.0833  R_Datelist  OxA-1637    0.0000   0.0000
    #> 22           37.2500         32.0833  R_Datelist  OxA-1728   37.2500  32.0833
    #> 23           37.2500         32.0833  R_Datelist  OxA-1729   37.2500  32.0833
    #> 24           36.4542         31.7237  R_Datelist OxA-22273   36.4542  31.7237
    #> 25           36.4542         31.7237  R_Datelist OxA-22274   36.4542  31.7237
    #> 26           36.4542         31.7237  R_Datelist OxA-22275   36.4542  31.7237
    #> 27           36.4542         31.7237  R_Datelist OxA-22287   36.4542  31.7237
    #> 28           36.4542         31.7237  R_Datelist OxA-22288   36.4542  31.7237
    #> 29           36.4542         31.7237  R_Datelist OxA-22289   36.4542  31.7237
    #> 30           36.4542         31.7237  R_Datelist OxA-22290   36.4542  31.7237
    #> 31           32.6167         35.6000  R_Datelist  OxA-4633   32.6167  35.6000
    #> 32           32.6167         35.6000  R_Datelist  OxA-4634   32.6167  35.6000
    #> 33           32.6167         35.6000  R_Datelist  OxA-4635   32.6167  35.6000
    #> 34           32.6167         35.6000  R_Datelist  OxA-4636   32.6167  35.6000
    #> 35           32.6167         35.6000  R_Datelist  OxA-4637   32.6167  35.6000
    #> 36           32.6167         35.6000  R_Datelist  OxA-4638   32.6167  35.6000
    #> 37           32.6167         35.6000  R_Datelist  OxA-4639   32.6167  35.6000
    #> 38           32.6167         35.6000  R_Datelist  OxA-4640   32.6167  35.6000
    #> 39           32.6167         35.6000  R_Datelist  OxA-4641   32.6167  35.6000
    #> 40           32.6167         35.6000  R_Datelist  OxA-4642   32.6167  35.6000
    #> 41           32.6167         35.6000  R_Datelist  OxA-4643   32.6167  35.6000
    #> 42           32.6167         35.6000  R_Datelist  OxA-4644   32.6167  35.6000
    #> 43           32.6167         35.6000  R_Datelist  OxA-5387   32.6167  35.6000
    #> 44           32.6167         35.6000  R_Datelist  OxA-5388   32.6167  35.6000
    #> 45           32.6167         35.6000  R_Datelist  OxA-5389   32.6167  35.6000
    #> 46           32.6167         35.6000  R_Datelist  OxA-5390   32.6167  35.6000
    #> 47           32.6167         35.6000  R_Datelist  OxA-5391   32.6167  35.6000
    #> 48           32.6167         35.6000  R_Datelist  OxA-5392   32.6167  35.6000
    #> 49           32.6167         35.6000  R_Datelist  OxA-5393   32.6167  35.6000
    #> 50           32.6167         35.6000  R_Datelist  OxA-5394   32.6167  35.6000
    #> 51           32.6167         35.6000  R_Datelist  OxA-5395   32.6167  35.6000
    #> 52           32.6167         35.6000  R_Datelist  OxA-5396   32.6167  35.6000
    #> 53           35.5833         32.3667  R_Datelist  OxA-4329   35.5833  32.3667
    #> 54           35.5833         32.3667  R_Datelist  OxA-4330   35.5833  32.3667
    #> 55           35.5833         32.3667  R_Datelist  OxA-4331   35.5833  32.3667
    #> 56           35.5833         32.3667  R_Datelist  OxA-4332   35.5833  32.3667
    #> 57           35.5833         32.3667  R_Datelist  OxA-4333   35.5833  32.3667
    #> 58           35.5833         32.3667  R_Datelist  OxA-4334   35.5833  32.3667
    #> 59           35.5833         32.3667  R_Datelist  OxA-4335   35.5833  32.3667
    #> 60           35.5833         32.3667  R_Datelist  OxA-4336   35.5833  32.3667
    #> 61           35.5833         32.3667  R_Datelist  OxA-4337   35.5833  32.3667
    #> 62           35.5833         32.3667  R_Datelist  OxA-5088   35.5833  32.3667
    #> 63           35.5833         32.3667  R_Datelist  OxA-5089   35.5833  32.3667
    #> 64           35.5833         32.3667  R_Datelist  OxA-5090   35.5833  32.3667
    #> 65           35.5833         32.3667  R_Datelist  OxA-5091   35.5833  32.3667
    #> 66           35.5833         32.3667  R_Datelist  OxA-5092   35.5833  32.3667
    #> 67           35.5833         32.3667  R_Datelist  OxA-5093   35.5833  32.3667
    #> 68           35.5833         32.3667  R_Datelist  OxA-5094   35.5833  32.3667
    #> 69           35.5833         32.3667  R_Datelist  OxA-5095   35.5833  32.3667
    #> 70           35.5833         32.3667  R_Datelist  OxA-5096   35.5833  32.3667
    #> 71           35.5833         32.4167  R_Datelist OxA-10990   35.5833  32.4167
    #> 72           35.5833         32.4167  R_Datelist OxA-10991   35.5833  32.4167
    #> 73           35.5833         32.4167  R_Datelist OxA-10992   35.5833  32.4167
    #> 74           35.5833         32.4167  R_Datelist OxA-10986   35.5833  32.4167
    #> 75           35.5833         32.4167  R_Datelist OxA-10987   35.5833  32.4167
    #> 76           35.5833         32.4167  R_Datelist OxA-10988   35.5833  32.4167
    #> 77           35.5833         32.4167  R_Datelist OxA-10989   35.5833  32.4167
    #> 78           38.1667         32.0000  R_Datelist  OxA-2767   38.1667  32.0000
    #> 79           35.1333         31.1333  R_Datelist OxA-22099   35.1333  31.1333
    #> 80           36.4167         31.5000  R_Datelist  OxA-1770    0.0000   0.0000
    #> 81           36.4167         31.5000  R_Datelist  OxA-1771    0.0000   0.0000
    #> 82           36.4167         31.5000  R_Datelist  OxA-1772    0.0000   0.0000
    #> 83           36.4167         31.5000  R_Datelist  OxA-1799    0.0000   0.0000
    #> 84           36.4167         31.5000  R_Datelist  OxA-1800    0.0000   0.0000
    #> 85           36.4167         31.5000  R_Datelist  OxA-1801    0.0000   0.0000
    #> 86           36.4167         31.5000  R_Datelist  OxA-1802    0.0000   0.0000
    #> 87           36.4167         31.5000  R_Datelist  OxA-1812    0.0000   0.0000
    #> 88           36.4167         31.5000  R_Datelist  OxA-2407    0.0000   0.0000
    #> 89           36.4167         31.5000  R_Datelist  OxA-2413    0.0000   0.0000
    #> 90           36.4167         31.5000  R_Datelist  OxA-2969   36.4167  31.5000
    #> 91           36.4167         31.5000  R_Datelist  OxA-2411   36.4167  31.5000
    #> 92           36.4167         31.5000  R_Datelist  OxA-2409   36.4167  31.5000
    #> 93           36.4167         31.5000  R_Datelist  OxA-2410   36.4167  31.5000
    #> 94           36.4167         31.5000  R_Datelist  OxA-2408   36.4167  31.5000
    #> 95           36.8181         31.8339  R_Datelist OxA-18829   36.8181  31.8339
    #> 96           36.8181         31.8339  R_Datelist OxA-18830   36.8181  31.8339
    #> 97           36.8181         31.8339  R_Datelist OxA-18831   36.8181  31.8339
    #> 98           36.8181         31.8339  R_Datelist OxA-18832   36.8181  31.8339
    #> 99           36.8181         31.8339  R_Datelist OxA-18833   36.8181  31.8339
    #> 100          31.6000         37.1000  R_Datelist OxA-11594   31.6000  37.1000
    #> 101          31.6000         37.1000  R_Datelist OxA-11595   31.6000  37.1000
    #> 102          36.4542         31.7237  R_Datelist OxA-22273   36.4542  31.7237
    #> 103          36.4542         31.7237  R_Datelist OxA-22274   36.4542  31.7237
    #> 104          36.4542         31.7237  R_Datelist OxA-22275   36.4542  31.7237
    #> 105          36.4542         31.7237  R_Datelist OxA-22287   36.4542  31.7237
    #> 106          36.4542         31.7237  R_Datelist OxA-22288   36.4542  31.7237
    #> 107          36.4542         31.7237  R_Datelist OxA-22289   36.4542  31.7237
    #> 108          36.4542         31.7237  R_Datelist OxA-22290   36.4542  31.7237
    #> 109          32.6167         35.6000  R_Datelist  OxA-4633   32.6167  35.6000
    #> 110          32.6167         35.6000  R_Datelist  OxA-4634   32.6167  35.6000
    #> 111          32.6167         35.6000  R_Datelist  OxA-4635   32.6167  35.6000
    #> 112          32.6167         35.6000  R_Datelist  OxA-4636   32.6167  35.6000
    #> 113          32.6167         35.6000  R_Datelist  OxA-4637   32.6167  35.6000
    #> 114          32.6167         35.6000  R_Datelist  OxA-4638   32.6167  35.6000
    #> 115          32.6167         35.6000  R_Datelist  OxA-4639   32.6167  35.6000
    #> 116          32.6167         35.6000  R_Datelist  OxA-4640   32.6167  35.6000
    #> 117          32.6167         35.6000  R_Datelist  OxA-4641   32.6167  35.6000
    #> 118          32.6167         35.6000  R_Datelist  OxA-4642   32.6167  35.6000
    #> 119          32.6167         35.6000  R_Datelist  OxA-4643   32.6167  35.6000
    #> 120          32.6167         35.6000  R_Datelist  OxA-4644   32.6167  35.6000
    #> 121          32.6167         35.6000  R_Datelist  OxA-5387   32.6167  35.6000
    #> 122          32.6167         35.6000  R_Datelist  OxA-5388   32.6167  35.6000
    #> 123          32.6167         35.6000  R_Datelist  OxA-5389   32.6167  35.6000
    #> 124          32.6167         35.6000  R_Datelist  OxA-5390   32.6167  35.6000
    #> 125          32.6167         35.6000  R_Datelist  OxA-5391   32.6167  35.6000
    #> 126          32.6167         35.6000  R_Datelist  OxA-5392   32.6167  35.6000
    #> 127          32.6167         35.6000  R_Datelist  OxA-5393   32.6167  35.6000
    #> 128          32.6167         35.6000  R_Datelist  OxA-5394   32.6167  35.6000
    #> 129          32.6167         35.6000  R_Datelist  OxA-5395   32.6167  35.6000
    #> 130          32.6167         35.6000  R_Datelist  OxA-5396   32.6167  35.6000
    #> 131          35.5833         32.3667  R_Datelist  OxA-4329   35.5833  32.3667
    #> 132          35.5833         32.3667  R_Datelist  OxA-4330   35.5833  32.3667
    #> 133          35.5833         32.3667  R_Datelist  OxA-4331   35.5833  32.3667
    #> 134          35.5833         32.3667  R_Datelist  OxA-4332   35.5833  32.3667
    #> 135          35.5833         32.3667  R_Datelist  OxA-4333   35.5833  32.3667
    #> 136          35.5833         32.3667  R_Datelist  OxA-4334   35.5833  32.3667
    #> 137          35.5833         32.3667  R_Datelist  OxA-4335   35.5833  32.3667
    #> 138          35.5833         32.3667  R_Datelist  OxA-4336   35.5833  32.3667
    #> 139          35.5833         32.3667  R_Datelist  OxA-4337   35.5833  32.3667
    #> 140          35.5833         32.3667  R_Datelist  OxA-5088   35.5833  32.3667
    #> 141          35.5833         32.3667  R_Datelist  OxA-5089   35.5833  32.3667
    #> 142          35.5833         32.3667  R_Datelist  OxA-5090   35.5833  32.3667
    #> 143          35.5833         32.3667  R_Datelist  OxA-5091   35.5833  32.3667
    #> 144          35.5833         32.3667  R_Datelist  OxA-5092   35.5833  32.3667
    #> 145          35.5833         32.3667  R_Datelist  OxA-5093   35.5833  32.3667
    #> 146          35.5833         32.3667  R_Datelist  OxA-5094   35.5833  32.3667
    #> 147          35.5833         32.3667  R_Datelist  OxA-5095   35.5833  32.3667
    #> 148          35.5833         32.3667  R_Datelist  OxA-5096   35.5833  32.3667
    #> 149          35.5833         32.4167  R_Datelist OxA-10990   35.5833  32.4167
    #> 150          35.5833         32.4167  R_Datelist OxA-10991   35.5833  32.4167
    #> 151          35.5833         32.4167  R_Datelist OxA-10992   35.5833  32.4167
    #> 152          35.5833         32.4167  R_Datelist OxA-10986   35.5833  32.4167
    #> 153          35.5833         32.4167  R_Datelist OxA-10987   35.5833  32.4167
    #> 154          35.5833         32.4167  R_Datelist OxA-10988   35.5833  32.4167
    #> 155          35.5833         32.4167  R_Datelist OxA-10989   35.5833  32.4167
    #> 156          35.1333         31.1333  R_Datelist OxA-22099   35.1333  31.1333
    #>                 sample      material                   species    d13C r_date
    #> 1                WY130      charcoal                         - -26.100   9950
    #> 2      Sample Number 8      charcoal Amygdalus (possibly almon -25.859  17550
    #> 3      Sample Number 8      charcoal Amygdalus (possibly almon -26.004  17490
    #> 4           Sample #33      charcoal            chenopodiaceae -11.272  17555
    #> 5           Sample #24      charcoal                 Amygdalus -23.747  17495
    #> 6         Sample #2009      charcoal           Chenopodiaeceae -11.412   9195
    #> 7             Sq.1, 10      charcoal                         -      NA   8350
    #> 8           Sq.14, 107          bone                         -      NA   1280
    #> 9                C,19b      charcoal                         - -10.500   8275
    #> 10             B.02203      charcoal                         - -13.700      0
    #> 11             B.03158      charcoal                         - -11.900   6900
    #> 12             B.27132      charcoal                         - -13.800   7270
    #> 13             B.27141      charcoal                         - -13.600   7350
    #> 14             B.27142      charcoal                         - -12.500   7930
    #> 15             B.35207      charcoal                         - -10.800   8140
    #> 16             B.35208      charcoal                         - -12.200   8180
    #> 17             B.35112      charcoal                         - -11.200   8270
    #> 18             BRT-DA1 plant remains                           -11.487      0
    #> 19             BRT-DA2 plant remains                           -11.571      0
    #> 20           2202/4217      charcoal                         - -26.000   7030
    #> 21           2202/2133      charcoal                         - -26.000   8350
    #> 22                4225      charcoal                         - -26.000   7140
    #> 23                4118      charcoal                         - -26.000   7450
    #> 24        KHIV-AreaB-6      charcoal            Chenopodiaceae -23.846  15890
    #> 25       KHIV-AreaB-10      charcoal             Indet. Dicot. -11.040  15770
    #> 26       KHIV-AreaB-19      charcoal             Indet. Dicot. -26.070  16145
    #> 27        KHIV-AreaB-4      charcoal            Chenopodiaceae -22.959  15980
    #> 28       KHIV-AreaB-15      charcoal            Chenopodiaceae -24.045  16275
    #> 29       KHIV-AreaB-24      charcoal             Indet. Dicot. -10.156  16300
    #> 30       KHIV-AreaB-25      charcoal            Chenopodiaceae -24.492  16200
    #> 31                  11      charcoal                   Tamarix -25.990   4500
    #> 32                  12      charcoal                  Ulmaceae -26.980   4440
    #> 33                  13      charcoal                   Tamarix -27.250   4520
    #> 34                  14      charcoal                       Ash -23.500   4555
    #> 35                  15      charcoal                     Olive -22.770   4920
    #> 36                  16      charcoal                     Olive -22.310   4870
    #> 37                  17      charcoal                     Olive -24.350   4975
    #> 38                  18      charcoal                   Quercus -24.940   4820
    #> 39                  11 charred seeds                     Olive -23.120   5020
    #> 40                  11 charred seeds                     Olive -22.280   5080
    #> 41                  12 charred seeds             hulled barley -23.820   6055
    #> 42                  12 charred seeds             hulled barley -23.660   6000
    #> 43      9, Area D: 443      charcoal                   tamarix -25.400   6020
    #> 44      10, Area D:585         seeds           Hordeum sativum -22.100   6040
    #> 45          13, Ac 725      charcoal                  tamarisk -26.310   4750
    #> 46          14, Aa:813         seeds                    lentil -22.460   4665
    #> 47          15, Aa:626         seeds               olive stone -21.320   4585
    #> 48          16, Aa:696         seeds                     emmer -20.950   4590
    #> 49          17, Ab:744         seeds             hulled barley -19.770   4685
    #> 50          18, Ab:753         seeds                     emmer -23.170   4735
    #> 51          19, Ab:869         seeds               olive stone -22.880   6065
    #> 52          20, Ab:841         seeds                     emmer -22.900   6070
    #> 53    1/K91 VIIC GL140      charcoal                         - -23.200   4475
    #> 54      2/K92 XIB 4L55      charcoal                         - -23.700   4440
    #> 55    3/K91 VIII 5L144      charcoal                         - -20.900   4445
    #> 56      4/K91 IX 3L223      charcoal                         - -21.700   4600
    #> 57      K92 XIB 6 L110      charcoal                         - -19.200   4360
    #> 58  6/K91 VIIB 12 L230      charcoal                         - -24.200   4435
    #> 59   7/K92 VIIC 8 L281      charcoal                         - -21.600   4405
    #> 60  8/K91 VIIA 12 L246      charcoal                         - -25.100   4540
    #> 61      9/K92 XIC 6L93  charred bone                         - -22.100   2910
    #> 62    1/K93 XXII 2 L42      charcoal                           -24.570   2495
    #> 63  2/K93 VIII A4 L380 charred seeds                           -23.230   3260
    #> 64  3/K93 VIII A4 L368 charred seeds                           -23.350   3210
    #> 65     4/K93 IX 5 L322 charred seeds                           -22.840   4390
    #> 66  5/K93 VIIIB 7 L412 charred seeds                           -25.100   4265
    #> 67  6/K93 VIIIA 8 L416      charcoal                           -25.100   4450
    #> 68  7/K93 VIIIA 9 L441 charred seeds                           -22.410   4400
    #> 69  8/K93 VIIIA 9 L444      charcoal                           -24.570   4440
    #> 70  9/K93 VIIIb 9 L434      charcoal                           -21.970   4335
    #> 71           C14MBA#43         seeds           Hordeum vulgare -23.335   3932
    #> 72           C14MBA#44         seeds           Hordeum vulgare -22.415   3877
    #> 73           C14MBA#45         seeds                    cereal -22.830   3886
    #> 74           C14MBA#39         seeds         Triticum aestivum -22.443   3470
    #> 75           C14MBA#40         seeds         Triticum aestivum -22.879   3497
    #> 76           C14MBA#41         seeds          olive stone/olea -21.280   3502
    #> 77           C14MBA#42         seeds          olive stone/olea -21.290   3523
    #> 78            HIBR 108      charcoal                         - -12.300   3950
    #> 79        H74-D2-MM408          bone            Cervus elaphus -20.653    864
    #> 80          22 1 6b 13      charcoal                         - -26.000  11920
    #> 81         22 3 15b 37      charcoal                         - -26.000  13040
    #> 82         22 3 15b 36      charcoal                         - -26.000  12840
    #> 83             7 A 34b      charcoal                         - -26.000   5840
    #> 84         13 A 21a 19      charcoal                         - -26.000   7920
    #> 85          13 A 15a 9      charcoal                         - -26.000   7870
    #> 86          26 Cb 7a 1      charcoal                         - -26.000   8690
    #> 87          27 E 41a 7      charcoal                           -26.000   5270
    #> 88          26 C 12a 3      charcoal                         - -12.800   8720
    #> 89            7, A 34a      charcoal                         - -23.400   8390
    #> 90           26,ED,18a      charcoal                         - -11.200   8740
    #> 91                C,24      charcoal                         - -24.200   7900
    #> 92               17a,1      charcoal                         - -15.200  13490
    #> 93               171,2      charcoal                         - -13.100  13540
    #> 94  Area Aa locus 10aV      charcoal                         - -11.100   8020
    #> 95     Sample Number 8      charcoal Amygdalus (possibly almon -25.859  17550
    #> 96     Sample Number 8      charcoal Amygdalus (possibly almon -26.004  17490
    #> 97          Sample #33      charcoal            chenopodiaceae -11.272  17555
    #> 98          Sample #24      charcoal                 Amygdalus -23.747  17495
    #> 99        Sample #2009      charcoal           Chenopodiaeceae -11.412   9195
    #> 100            BRT-DA1 plant remains                           -11.487      0
    #> 101            BRT-DA2 plant remains                           -11.571      0
    #> 102       KHIV-AreaB-6      charcoal            Chenopodiaceae -23.846  15890
    #> 103      KHIV-AreaB-10      charcoal             Indet. Dicot. -11.040  15770
    #> 104      KHIV-AreaB-19      charcoal             Indet. Dicot. -26.070  16145
    #> 105       KHIV-AreaB-4      charcoal            Chenopodiaceae -22.959  15980
    #> 106      KHIV-AreaB-15      charcoal            Chenopodiaceae -24.045  16275
    #> 107      KHIV-AreaB-24      charcoal             Indet. Dicot. -10.156  16300
    #> 108      KHIV-AreaB-25      charcoal            Chenopodiaceae -24.492  16200
    #> 109                 11      charcoal                   Tamarix -25.990   4500
    #> 110                 12      charcoal                  Ulmaceae -26.980   4440
    #> 111                 13      charcoal                   Tamarix -27.250   4520
    #> 112                 14      charcoal                       Ash -23.500   4555
    #> 113                 15      charcoal                     Olive -22.770   4920
    #> 114                 16      charcoal                     Olive -22.310   4870
    #> 115                 17      charcoal                     Olive -24.350   4975
    #> 116                 18      charcoal                   Quercus -24.940   4820
    #> 117                 11 charred seeds                     Olive -23.120   5020
    #> 118                 11 charred seeds                     Olive -22.280   5080
    #> 119                 12 charred seeds             hulled barley -23.820   6055
    #> 120                 12 charred seeds             hulled barley -23.660   6000
    #> 121     9, Area D: 443      charcoal                   tamarix -25.400   6020
    #> 122     10, Area D:585         seeds           Hordeum sativum -22.100   6040
    #> 123         13, Ac 725      charcoal                  tamarisk -26.310   4750
    #> 124         14, Aa:813         seeds                    lentil -22.460   4665
    #> 125         15, Aa:626         seeds               olive stone -21.320   4585
    #> 126         16, Aa:696         seeds                     emmer -20.950   4590
    #> 127         17, Ab:744         seeds             hulled barley -19.770   4685
    #> 128         18, Ab:753         seeds                     emmer -23.170   4735
    #> 129         19, Ab:869         seeds               olive stone -22.880   6065
    #> 130         20, Ab:841         seeds                     emmer -22.900   6070
    #> 131   1/K91 VIIC GL140      charcoal                         - -23.200   4475
    #> 132     2/K92 XIB 4L55      charcoal                         - -23.700   4440
    #> 133   3/K91 VIII 5L144      charcoal                         - -20.900   4445
    #> 134     4/K91 IX 3L223      charcoal                         - -21.700   4600
    #> 135     K92 XIB 6 L110      charcoal                         - -19.200   4360
    #> 136 6/K91 VIIB 12 L230      charcoal                         - -24.200   4435
    #> 137  7/K92 VIIC 8 L281      charcoal                         - -21.600   4405
    #> 138 8/K91 VIIA 12 L246      charcoal                         - -25.100   4540
    #> 139     9/K92 XIC 6L93  charred bone                         - -22.100   2910
    #> 140   1/K93 XXII 2 L42      charcoal                           -24.570   2495
    #> 141 2/K93 VIII A4 L380 charred seeds                           -23.230   3260
    #> 142 3/K93 VIII A4 L368 charred seeds                           -23.350   3210
    #> 143    4/K93 IX 5 L322 charred seeds                           -22.840   4390
    #> 144 5/K93 VIIIB 7 L412 charred seeds                           -25.100   4265
    #> 145 6/K93 VIIIA 8 L416      charcoal                           -25.100   4450
    #> 146 7/K93 VIIIA 9 L441 charred seeds                           -22.410   4400
    #> 147 8/K93 VIIIA 9 L444      charcoal                           -24.570   4440
    #> 148 9/K93 VIIIb 9 L434      charcoal                           -21.970   4335
    #> 149          C14MBA#43         seeds           Hordeum vulgare -23.335   3932
    #> 150          C14MBA#44         seeds           Hordeum vulgare -22.415   3877
    #> 151          C14MBA#45         seeds                    cereal -22.830   3886
    #> 152          C14MBA#39         seeds         Triticum aestivum -22.443   3470
    #> 153          C14MBA#40         seeds         Triticum aestivum -22.879   3497
    #> 154          C14MBA#41         seeds          olive stone/olea -21.280   3502
    #> 155          C14MBA#42         seeds          olive stone/olea -21.290   3523
    #> 156       H74-D2-MM408          bone            Cervus elaphus -20.653    864
    #>     r_date_sigma qual     F14C F14C_sigma
    #> 1            100      0.289778 0.00360734
    #> 2             75      0.112520 0.00108000
    #> 3             75      0.113330 0.00104000
    #> 4             75      0.112460 0.00102000
    #> 5             70      0.113260 0.00099000
    #> 6             40      0.318350 0.00166000
    #> 7            120      0.353645 0.00528288
    #> 8             90      0.852704 0.00955351
    #> 9             80      0.356962 0.00355496
    #> 10             0    m 1.442000 0.01000000
    #> 11           100      0.423604 0.00527329
    #> 12            80      0.404535 0.00402873
    #> 13            80      0.400526 0.00398881
    #> 14            80      0.372627 0.00371096
    #> 15            90      0.363012 0.00406711
    #> 16            80      0.361209 0.00359725
    #> 17            80      0.357184 0.00355717
    #> 18             0    m 1.173600 0.00380000
    #> 19             0    m 1.042300 0.00370000
    #> 20            90      0.416804 0.00466978
    #> 21           100      0.353645 0.00440240
    #> 22            90      0.411135 0.00460627
    #> 23            90      0.395571 0.00443189
    #> 24            90      0.138350 0.00147000
    #> 25            80      0.140330 0.00146000
    #> 26            75      0.134010 0.00125000
    #> 27            60      0.136790 0.00100000
    #> 28            60      0.131870 0.00098000
    #> 29            65      0.131430 0.00102000
    #> 30            65      0.133080 0.00106000
    #> 31           120      0.570800 0.00860000
    #> 32            80      0.575200 0.00590000
    #> 33            75      0.569700 0.00530000
    #> 34            70      0.567200 0.00500000
    #> 35            75      0.542200 0.00490000
    #> 36           150      0.545100 0.01050000
    #> 37            75      0.538200 0.00500000
    #> 38            80      0.549000 0.00560000
    #> 39            75      0.535300 0.00500000
    #> 40            75      0.531200 0.00500000
    #> 41            80      0.470600 0.00460000
    #> 42            75      0.473900 0.00440000
    #> 43            65      0.472700 0.00380000
    #> 44            55      0.471400 0.00320000
    #> 45            55      0.553700 0.00380000
    #> 46            55      0.559600 0.00390000
    #> 47            50      0.564900 0.00350000
    #> 48            50      0.564600 0.00340000
    #> 49            75      0.558100 0.00520000
    #> 50            55      0.554800 0.00370000
    #> 51            55      0.470000 0.00310000
    #> 52            55      0.469700 0.00320000
    #> 53            60      0.572881 0.00427896
    #> 54            60      0.575383 0.00429764
    #> 55            60      0.575025 0.00429497
    #> 56            65      0.564036 0.00456396
    #> 57            60      0.581141 0.00434066
    #> 58            65      0.575741 0.00465868
    #> 59            65      0.577895 0.00467611
    #> 60            70      0.568264 0.00495189
    #> 61            65      0.696104 0.00563261
    #> 62            45      0.732900 0.00420000
    #> 63            50      0.666500 0.00400000
    #> 64            60      0.670700 0.00510000
    #> 65            60      0.579100 0.00430000
    #> 66            55      0.587900 0.00420000
    #> 67            60      0.574600 0.00420000
    #> 68            50      0.578300 0.00370000
    #> 69            60      0.575400 0.00430000
    #> 70            55      0.582900 0.00400000
    #> 71            38      0.613000 0.00290000
    #> 72            40      0.617100 0.00300000
    #> 73            40      0.616400 0.00300000
    #> 74            36      0.649200 0.00290000
    #> 75            37      0.647000 0.00300000
    #> 76            37      0.646600 0.00290000
    #> 77            39      0.645000 0.00310000
    #> 78            80      0.611573 0.00609060
    #> 79            28      0.898030 0.00308000
    #> 80           180      0.226756 0.00508106
    #> 81           180      0.197246 0.00441980
    #> 82           140      0.202218 0.00352429
    #> 83           100      0.483356 0.00601713
    #> 84           100      0.373091 0.00464448
    #> 85           100      0.375420 0.00467348
    #> 86           110      0.338989 0.00464195
    #> 87            90      0.518900 0.00581365
    #> 88           100      0.337725 0.00420422
    #> 89            80      0.351888 0.00350443
    #> 90           110      0.336886 0.00461315
    #> 91            80      0.374021 0.00372485
    #> 92           110      0.186500 0.00255384
    #> 93           120      0.185343 0.00276872
    #> 94            80      0.368475 0.00366962
    #> 95            75      0.112520 0.00108000
    #> 96            75      0.113330 0.00104000
    #> 97            75      0.112460 0.00102000
    #> 98            70      0.113260 0.00099000
    #> 99            40      0.318350 0.00166000
    #> 100            0    m 1.173600 0.00380000
    #> 101            0    m 1.042300 0.00370000
    #> 102           90      0.138350 0.00147000
    #> 103           80      0.140330 0.00146000
    #> 104           75      0.134010 0.00125000
    #> 105           60      0.136790 0.00100000
    #> 106           60      0.131870 0.00098000
    #> 107           65      0.131430 0.00102000
    #> 108           65      0.133080 0.00106000
    #> 109          120      0.570800 0.00860000
    #> 110           80      0.575200 0.00590000
    #> 111           75      0.569700 0.00530000
    #> 112           70      0.567200 0.00500000
    #> 113           75      0.542200 0.00490000
    #> 114          150      0.545100 0.01050000
    #> 115           75      0.538200 0.00500000
    #> 116           80      0.549000 0.00560000
    #> 117           75      0.535300 0.00500000
    #> 118           75      0.531200 0.00500000
    #> 119           80      0.470600 0.00460000
    #> 120           75      0.473900 0.00440000
    #> 121           65      0.472700 0.00380000
    #> 122           55      0.471400 0.00320000
    #> 123           55      0.553700 0.00380000
    #> 124           55      0.559600 0.00390000
    #> 125           50      0.564900 0.00350000
    #> 126           50      0.564600 0.00340000
    #> 127           75      0.558100 0.00520000
    #> 128           55      0.554800 0.00370000
    #> 129           55      0.470000 0.00310000
    #> 130           55      0.469700 0.00320000
    #> 131           60      0.572881 0.00427896
    #> 132           60      0.575383 0.00429764
    #> 133           60      0.575025 0.00429497
    #> 134           65      0.564036 0.00456396
    #> 135           60      0.581141 0.00434066
    #> 136           65      0.575741 0.00465868
    #> 137           65      0.577895 0.00467611
    #> 138           70      0.568264 0.00495189
    #> 139           65      0.696104 0.00563261
    #> 140           45      0.732900 0.00420000
    #> 141           50      0.666500 0.00400000
    #> 142           60      0.670700 0.00510000
    #> 143           60      0.579100 0.00430000
    #> 144           55      0.587900 0.00420000
    #> 145           60      0.574600 0.00420000
    #> 146           50      0.578300 0.00370000
    #> 147           60      0.575400 0.00430000
    #> 148           55      0.582900 0.00400000
    #> 149           38      0.613000 0.00290000
    #> 150           40      0.617100 0.00300000
    #> 151           40      0.616400 0.00300000
    #> 152           36      0.649200 0.00290000
    #> 153           37      0.647000 0.00300000
    #> 154           37      0.646600 0.00290000
    #> 155           39      0.645000 0.00310000
    #> 156           28      0.898030 0.00308000
