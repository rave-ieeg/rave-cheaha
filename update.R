#' ---- Update RAVE ------------------------------------------------------------
#'
#' This script provides instructions to update RAVE. You must set up
#' RAVE first (see `setup.R` if you haven't done so)
#'
#' -----------------------------------------------------------------------------

# Check if RAVE needs update
ravemanager::version_info()

# Update RAVE
renv::update("ravemanager")
renv::activate()
ravemanager::update_rave()