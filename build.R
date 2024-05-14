# Script to build this renv from scratch

# unlink('~/.cache/R/renv/', recursive = TRUE)
# unlink("./renv/library/", recursive = TRUE)
# renv::init() # select 3

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
utils::install.packages(c("ravemanager", "pak"))
# ---- Install, configure, update RAVE -----------------------------------------
packages <- unique(c(
  ravemanager:::rave_depends,
  ravemanager:::rave_packages,
  ravemanager:::rave_suggests,
  "RcppArmadillo"
))
packages <- packages[!packages %in% c("clustermq")]
writeLines(
  con = "_library.R",
  sprintf("library(%s)", packages)
)
utils::install.packages(packages, repos = getOption("repos"))
utils::install.packages(
  c("Rcpp", "RcppEigen", "BH", "RcppArmadillo",
    "pbdZMQ", "mvtnorm", "nloptr", "quantreg"),
  repos = c(CRAN = "https://cloud.r-project.org")
)
utils::install.packages("ravebuiltins", repos = getOption("repos"))
renv::snapshot()

ravemanager::update_rave()

# Make sure RAVE can be loaded
source("_library.R")

renv::status()
renv::snapshot()

# module load miniconda
# Sys.setenv("R_RPYMAT_CONDA_EXE" = Sys.which("conda"))
# conda_env_path <- file.path(tools::R_user_dir("rpymat", which = "data"),
#                             "miniconda",
#                             "envs",
#                             "rpymat-conda-env")
# conda_env_path <- normalizePath(conda_env_path, winslash = "/", mustWork = FALSE)
# Sys.setenv("R_RPYMAT_CONDA_PREFIX" = conda_env_path)
# ravemanager::configure_python()