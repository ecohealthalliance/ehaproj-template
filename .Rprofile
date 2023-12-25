# The .Rprofile file is loaded at the start of every R session and can be used
# to set common options and settings. As {targets} starts a new session for each 
# target, it should be limited to options and avoid loading packages or other
# heavy tasks. Messages and diagnostics should be limited to interactive sessions.

# ---- Function definitions ----------------------------------------------------
local({ # Wrapping in `local()` avoids side effects or cluttering the environment
  
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
  
  # ---- Interactive-only ------------------------------------------------------
  if (interactive()) {
    # Source the user's .Rprofile if it exists, but other options will clobber it
    user_rprof <- Sys.getenv("R_PROFILE_USER", normalizePath("~/.Rprofile", mustWork = FALSE))
    if (file.exists(user_rprof) && nzchar("USE_CAPSULE")) {
      source(user_rprof)
    }
    load_env(verbose = TRUE)
    
    options(
      renv.config.startup.quiet = FALSE,
      renv.config.synchronized.check = TRUE,
      renv.config.dependency.errors = "reported"
    )
    
    if (!nzchar("USE_CAPSULE") && requireNamespace("capsule", quietly = TRUE)) {
      capsule::whinge()
    }
    

    
  } else {
    # ---- Non-interactive only ------------------------------------------------
    
    load_env(verbose = FALSE)
    options(
      renv.config.startup.quiet = TRUE,
      renv.config.synchronized.check = FALSE, # Avoid the check in every sub-process
      renv.config.dependency.errors = "ignored"
    )
  }
  
  # ---- All sessions ----------------------------------------------------------
  options(
    renv.config.install.verbose = TRUE  # See what is happening when packages are installed
  )
  
  if (requireNamespace("renv", quietly = TRUE)) {
    renv::settings$ignored.packages(c("ehaproj", "tflow", "fnmate"))
  }
  
  if (!nzchar("USE_CAPSULE")) {
    source("renv/activate.R")
    load_env(verbose = FALSE) # Load again because renv can clobber env vars
  }
  
  
})


# ---- Startup message ---------------------------------------------------------
if (interactive() && Sys.getenv("RSTUDIO") == "1") {
  setHook("rstudio.sessionInit", function(newSession) {
    if (newSession) {
      cat("\014")
      cat("\033[38;5;196m▃▃▃▃▃▃\033[39m\033[38;5;214m▃▃▃▃▃▃\033[39m\033[38;5;226m▃▃▃▃▃▃\033[39m\033[38;5;34m▃▃▃▃▃▃\033[39m\033[38;5;27m▃▃▃▃▃▃\033[39m\033[38;5;91m▃▃▃▃▃▃\033[39m")
      cat("\n")
    }
  }, action = "append")
}

