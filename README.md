# moma-module

This repository contains files for running a containerized version of [MoMA](https://github.com/michaelmell/MoMA/wiki).
It allows you to run MoMA with minimal setup effort. Furthermore, contains module files for using MoMA with [Environment Modules](https://modules.readthedocs.io/en/latest/index.html).

## Requirements

- Your system should at least have 32GB of RAM.
- You will need a Linux host system to run the Linux containers.
- You must install [Docker](https://www.docker.com/) or [Singularity/Apptainer](https://apptainer.org/) to run the containers.

## Setup instructions

- Obtain a free, academic license for the Gurobi solver used by MoMA. This is explained [here](https://www.gurobi.com/features/academic-wls-license/). The steps are:
  - Register as academic user with the Gurobi web-site: https://portal.gurobi.com/iam/register/
  - Go to the [Gurobi User Portal](https://portal.gurobi.com/iam/licenses/request?type=academic) to request and download an Academic WLS License.
- After downloading the Academic WLS License, modify your `~/.bashrc` to export the path to the Gurobi license:
  - `export MOMA_GRB_LICENSE_FILE=<PATH_TO_GUROBI_WLS_LICENSE>`
- Install Docker or Apptainer/Singularity as explained here:
  - Docker: https://docs.docker.com/engine/install
  - Singularity/Apptainer: https://apptainer.org/docs/admin/main/installation.html
- Clone this Git repository or download the ZIP file.
- Modify your `~/.bashrc` to use e.g. version `0.9.7` of MoMA:
  - If you are not using [Environment Modules](https://modules.readthedocs.io/en/latest/index.html), add version `0.9.7` to your `PATH`:
    ```sh
    PATH=<PATH_TO_GIT_REPOSITORY>/0.9.7/:$PATH
    ```
  - If you are using [Environment Modules](https://modules.readthedocs.io/en/latest/index.html), add this to use version `0.9.7`:
    ```sh
    module use <PATH_TO_GIT_REPOSITORY>
    module load moma-module/0.9.7
    ```
