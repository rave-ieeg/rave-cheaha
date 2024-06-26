# ---- Utility functions -------------------------------------------------------

# Function to create a directory
dir_create <- function(path) {
  if(!nzchar(path)) {
    stop("Path cannot be blank")
  }
  if(!file.exists(path)) {
    dir.create(path = path, showWarnings = FALSE, recursive = TRUE)
  }
  if(!dir.exists(path)) {
    stop("Path exists but is not a directory: ", path)
  }
  invisible(normalizePath(path = path, winslash = "/", mustWork = TRUE))
}

# Ensure the user path exists
ensure_user_libpath <- function() {
  dir_create(Sys.getenv("R_LIBS_USER", unset = ""))
}

# check if packages exists
pkg_installed <- function(pkg, lib.loc = NULL) {
  path <- system.file(package = pkg, lib.loc = lib.loc)
  if(path == "") { return(FALSE)}
  return(TRUE)
}

pkg_install <- function(pkg) {
  if(pkg_installed(pkg)) { return() }
  if(!pkg_installed("renv")) {
    install.packages(pkg)
  } else {
    renv::install(pkg, prompt = FALSE)
  }
}

pkg_call <- function(pkg, fun, ...) {
  asNamespace(pkg)[[fun]](...)
}

pkg_store <- function(pkgs) {
  writeLines(
    con = "_library.R",
    text = paste(
      collapse = "\n",
      sprintf("library(%s)", pkgs)
    )
  )
}

# Function to install base packages
check_base_pkgs <- function(pkgs) {
  if( length(pkgs) == 0 ) { return(invisible()) }
  if( length(pkgs) > 1 ) {
    lapply(pkgs, check_base_pkgs)
    return(invisible())
  }
  if( pkg_installed(pkgs) ) { return(invisible()) }
  url <- R_MISSING_PACKAGES[[pkgs]]
  if(length(url) != 1) { return(invisible()) }
  lob_loc <- ensure_user_libpath()
  
  renv::install(url, prompt = FALSE)
}






rave_options_set <- function(key, value) {
  pkg_call("raveio", "raveio_setopt", key = key, value = value)
}

available_cpu <- function() {
  pkg_call("parallelly", "availableCores")
}

freesurfer_path <- function() {
  recon_path <- system("module load FreeSurfer && which recon-all", intern = TRUE)
  dirname(dirname(recon_path))
}

start_rave2 <- function(...) {
  pkg_call(pkg = "rave", fun = "start_rave2")
}




