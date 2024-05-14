#' ---- Setup RAVE -------------------------------------------------------------
#' This script downloads, installs, and sets up RAVE on Cheaha
#' 
#' * If this is the first time, it will take a while so be patient
#' * Once RAVE is installed and configured correctly, you won't use
#'   this script again.
#' 
#' If you have RAVE installed already and would like to upgrade RAVE,
#' please check `update.R`.
#' ---- END of Documentation ---------------------------------------------------

# ---- Initial bootstrap (~3 min) ----------------------------------------------
source("renv/utils.R")
pkg_install("renv")
renv::restore(prompt = FALSE)
pak::pak_install_extra()

# ---- Set up R & Python libraries (20-25 min) ---------------------------------
ravemanager::install(python = TRUE)

