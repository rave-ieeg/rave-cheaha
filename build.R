# Script to build this renv from scratch
source("renv/utils.R")

# Install Missing R builtin packages (R 4.3.1)
R_MISSING_PACKAGES <- list(
  "MASS" = "https://cran.r-project.org/src/contrib/Archive/MASS/MASS_7.3-60.tar.gz",
  "lattice" = "https://cran.r-project.org/src/contrib/Archive/lattice/lattice_0.21-9.tar.gz",
  "Matrix" = "https://cran.r-project.org/src/contrib/Archive/Matrix/Matrix_1.6-0.tar.gz"
)

check_base_pkgs(names(R_MISSING_PACKAGES))

# Install, configure, update RAVE
renv::install(
  packages = c("ravemanager"),
  repos = 'https://rave-ieeg.r-universe.dev',
  prompt = FALSE
)
renv::install("pak", prompt = FALSE)
renv::install(c("Rcpp", "RcppEigen", "BH", "RcppArmadillo"),
              prompt = FALSE)
pak::pak_install_extra()

ravemanager::add_r_package(c("rave", "ravebuiltins"))

ravemanager::update_rave()

# write libraries so renv can capture the 
packages <- unique(c(
  ravemanager:::rave_depends,
  ravemanager:::rave_packages,
  ravemanager:::rave_suggests,
  "RcppArmadillo"
))
writeLines(
  con = "_library.R",
  sprintf("library(%s)", packages)
)

# module load miniconda
# Sys.setenv("R_RPYMAT_CONDA_EXE" = Sys.which("conda"))
# conda_env_path <- file.path(tools::R_user_dir("rpymat", which = "data"),
#                             "miniconda",
#                             "envs",
#                             "rpymat-conda-env")
# conda_env_path <- normalizePath(conda_env_path, winslash = "/", mustWork = FALSE)
# Sys.setenv("R_RPYMAT_CONDA_PREFIX" = conda_env_path)
# ravemanager::configure_python()

Sys.setenv(RENV_PROFILE="default")

renv::status()
renv::snapshot()

renv::activate()
renv::config$pak.enabled()

