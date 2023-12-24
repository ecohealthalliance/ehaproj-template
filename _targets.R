
# ---- Setup ----
# Load all the functions in the `R/` directory, packages, and other `_targets_*.R files`
targets::tar_source(c("R", "packages.R", list.files(".", "^_targets_.*\\.(r|R)$")))

# When using capsule record the packages used
if (nzchar(Sys.getenv("USE_CAPSULE"))) capshot_all()


# ---- Targets Plan ----
# Define your targets here. They can be standalone or 
reports <- tar_plan(
  tar_file(targets_files, list.files(".", "^_targets.*\\.(r|R)$"), repository = "local"),
  tar_render(readme, path = "README.Rmd", params = list(file = targets_files))
)

# ---- Wrapup ----
all_targets()
