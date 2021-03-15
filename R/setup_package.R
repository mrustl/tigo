pkg <- list(
  name = "tigo",
  title = "R Package For Accessing Tigo Energy API",
  desc = paste(
    "R Package For Accessing Tigo Energy API",
    "available at: <https://support.tigoenergy.com/hc/en-us/articles/200863027-Tigo-Energy-API>."
  )
)


kwb.pkgbuild::use_pkg_skeleton("tigo")

kwb.pkgbuild::use_pkg(
  pkg = pkg,
  copyright_holder = list(name = "Michael Rustler", start_year = NULL),
  user = "mrustl"
)

kwb.pkgbuild::create_empty_branch_ghpages("tigo")
