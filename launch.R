#' ---- Launch RAVE ------------------------------------------------------------
#'
#' This script provides instructions to launch RAVE.
#'
#' -----------------------------------------------------------------------------

source("renv/utils.R")

# Number of cores; default is all cores
rave_options_set("max_worker", value = available_cpu())

# (Optional) FreeSurfer
rave_options_set("freesurfer_path", value = freesurfer_path())
start_rave2(as_job = TRUE)

