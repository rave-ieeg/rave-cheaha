# Script to build this renv from scratch

# unlink('~/.cache/R/renv/', recursive = TRUE)
# unlink("./renv/library/", recursive = TRUE)
# renv::init() # select 3
source("renv/utils.R")
lockfile <- pkg_call(
  "renv", lockfile_modify, 
  lockfile = pkg_call("renv", "lockfile_read"),
  repos = list(raveieeg = "https://rave-ieeg.r-universe.dev", 
               CRAN = "https://cloud.r-project.org")
)
pkg_call("renv", "lockfile_write", lockfile)
renv::activate()

# Install Missing R builtin packages (Cheaha R 4.3.1 misses the following builtin packages)
R_MISSING_PACKAGES <- list(
  "MASS" = "https://cran.r-project.org/src/contrib/Archive/MASS/MASS_7.3-60.tar.gz",
  "lattice" = "https://cran.r-project.org/src/contrib/Archive/lattice/lattice_0.21-9.tar.gz",
  "Matrix" = "https://cran.r-project.org/src/contrib/Archive/Matrix/Matrix_1.6-0.tar.gz"
)

# ---- Install packages to bootstrap this builder ------------------------------
source("renv/utils.R")
check_base_pkgs(names(R_MISSING_PACKAGES))
ensure_user_libpath()

utils::install.packages('ravemanager', repos = 'https://rave-ieeg.r-universe.dev')
pkg_call("renv", "status")
ravemanager::add_r_package("pak")

pkg_store(c("pak", "ravemanager", names(R_MISSING_PACKAGES)))
pkg_call("renv", "snapshot")

# ravemanager:::try_setup_pak()
# ravemanager::update_rave()

# Make sure RAVE can be loaded

# module load miniconda
# Sys.setenv("R_RPYMAT_CONDA_EXE" = Sys.which("conda"))
# conda_env_path <- file.path(tools::R_user_dir("rpymat", which = "data"),
#                             "miniconda",
#                             "envs",
#                             "rpymat-conda-env")
# conda_env_path <- normalizePath(conda_env_path, winslash = "/", mustWork = FALSE)
# Sys.setenv("R_RPYMAT_CONDA_PREFIX" = conda_env_path)
# ravemanager::configure_python()