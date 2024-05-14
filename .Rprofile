# module load miniconda
# Sys.setenv("R_RPYMAT_CONDA_EXE" = Sys.which("conda"))

# Sys.setenv("R_RPYMAT_CONDA_PREFIX" = conda_env_path)
# ravemanager::configure_python()

Sys.setenv("RENV_CONFIG_REPOS_OVERRIDE" = "https://packagemanager.posit.co/cran/__linux__/centos7/2024-05-13")

source("renv/activate.R")

local({
  conda_path <- Sys.which("conda")
  if(!nzchar(conda_path)) {
    conda_path <- file.path(tools::R_user_dir("rpymat", which = "data"),
                            "miniconda",
                            "condabin",
                            "conda")
  }
  conda_path <- normalizePath(conda_path, winslash = "/", mustWork = FALSE)
  
  conda_env_path <- file.path(tools::R_user_dir("rpymat", which = "data"),
                              "miniconda",
                              "envs",
                              "rpymat-conda-env")
  conda_env_path <- normalizePath(conda_env_path, winslash = "/", mustWork = FALSE)
  
  Sys.setenv("R_RPYMAT_CONDA_EXE" = conda_path)
  Sys.setenv("R_RPYMAT_CONDA_PREFIX" = conda_env_path)
})
