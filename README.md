[![R-CMD-check](https://github.com/mrustl/tigo/workflows/R-CMD-check/badge.svg)](https://github.com/mrustl/tigo/actions?query=workflow%3AR-CMD-check)
[![pkgdown](https://github.com/mrustl/tigo/workflows/pkgdown/badge.svg)](https://github.com/mrustl/tigo/actions?query=workflow%3Apkgdown)
[![codecov](https://codecov.io/github/mrustl/tigo/branch/main/graphs/badge.svg)](https://codecov.io/github/mrustl/tigo)
[![Project Status](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![CRAN_Status_Badge](https://www.r-pkg.org/badges/version/tigo)]()

# tigo

R Package For Accessing Tigo Energy API available
at:
<https://support.tigoenergy.com/hc/en-us/articles/200863027-Tigo-Energy-API>.

## Installation

For details on how to install KWB-R packages checkout our [installation tutorial](https://kwb-r.github.io/kwb.pkgbuild/articles/install.html).

```r
### Optionally: specify GitHub Personal Access Token (GITHUB_PAT)
### See here why this might be important for you:
### https://kwb-r.github.io/kwb.pkgbuild/articles/install.html#set-your-github_pat

# Sys.setenv(GITHUB_PAT = "mysecret_access_token")

# Install package "remotes" from CRAN
if (! require("remotes")) {
  install.packages("remotes", repos = "https://cloud.r-project.org")
}

# Install KWB package 'tigo' from GitHub
remotes::install_github("mrustl/tigo")
```

## Documentation

Release: [https://mrustl.de/tigo/](https://mrustl.de/tigo/)

Development: [https://mrustl.de/tigo/dev](https://mrustl.de/tigo/dev)
