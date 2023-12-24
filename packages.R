# List packages here that you expect to use in most of your target building
# These packages are loaded by default and also using the {tflow} add-in
# to load `packages.R` and `R/*.R` files (typically bound to Ctrl+Alt+P)
#
# In general, avoid adding too many packages to this file - only ones that
# You need to load for most of your workflow.  Use `::` in your functions
# For packages that you only call a few functions from, or attach packages
# to specific targets using the `tar_target(..., packages = "PACKAGE")` argument.
suppressPackageStartupMessages({
  
  library(targets)
  library(tarchetypes)
  library(dplyr) # Avoid loading tidyverse by default, instead use individual packages
  library(purrr)
  # library(paws.storage) # Load paws.storage rather than the whole paws package

  
  })


# Check what is already used by your project by running
# names(jsonlite::read_json(lockfile)$Packages)