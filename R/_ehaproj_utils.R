# These are utility functions commonly used in the project.  These may migrate
# to a separate package {ehautils?} in the future
load_env <- function(
    env_files = list.files(all.files = TRUE, pattern = "^\\.env.*"),
    verbose = TRUE) {
  for (f in env_files) {
    tryCatch(
      readRenviron(f),
      error = function(e) {
        if (verbose) {
          if (isTRUE(suppressWarnings(readBin(f, "character", 2))[2] == "GITCRYPT")) {
            message("`", f, "` is encrypted, not loading. Run `git-crypt unlock`.")
          } else {
            message("Error reading ", f, ": ", e$message, ". Not loading.")
          }
        }
      })
  }
}

# 'Generate a lockfile from dependencies. 
#'
# 'Note that this obeys the `.renvignore` file because it uses renv::dependencies underneath.
#' @param async If TRUE, run in a separate process.
capshot_all <- function(files = NULL, async = TRUE) {
  if (is.null(files)) {
    files <- list.files(
      path = c(".", "R","reports", "vignettes", "outputs"), 
      pattern = "\\.(R|r|Rmd|rmd)$", 
      full.names = TRUE)
  }
  if (async) {
    out <- mirai::mirai(capsule::capshot(files), .args = list(files = files))
  } else {
    out <- capsule::capshot(files)
  }
  invisible(out)
}

#' Collect all targets and lists of targets in the environment
#' 
#' A convenience function to run at the end of a _targets.R file.
#' @param env The environment to search for targets. Defaults to the parent environment.
#' @param add_list_names If TRUE, lists of targets such as those made with
#'   [targets::tar_plan()] will be redefined in the environment so they can
#'   be used to refer to all targets on the list, such as `tar_make(list_name)`.
#'   Note this does not work with `tar_load()` or other functions that do not run _targets.R.
all_targets <- function(env = parent.env(environment()), add_list_names = TRUE) {
  
  # Function to determine if an object is a target, or a list of only targets
  rfn <- function(obj) inherits(obj, "tar_target") || (is.list(obj) && all(vapply(obj, rfn, logical(1))))
  # Get the names everything in the environment (e.g. sourced in the _targets file)
  objs <- ls(env)
  out <- list()
  
  for (o in objs) {
    obj <- get(o, envir = env) # Get each top-level object in turn
    if (rfn(obj)) { # For targets and lists of targets
      out[[length(out) + 1]] <- obj # Add them to the output
      
      # If the object is a list of targets, add a vector of those names to the environment
      # So that one can call `tar_make(list_name)` to make all the targets in that list
      if (add_list_names && is.list(obj)) {
        target_names <- vapply(obj, \(x) x$settings$name, character(1))
        assign(o, target_names, envir = env)
      }
    }
  }
  return(out)
}


