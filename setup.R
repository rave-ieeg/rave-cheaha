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


# Initial bootstrap
source("renv/utils.R")
pkg_install("renv")

# Set up R libraries (time consuming)
renv::restore(prompt = FALSE)

# set up Python libraries
