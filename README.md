# moma-module

This repository contains files for running a containerized version of [MoMA](https://github.com/michaelmell/MoMA/wiki).
It allows you to run MoMA with minimal setup effort. Furthermore, contains module files for using MoMA with [Environment Modules](https://modules.readthedocs.io/en/latest/index.html).

## Requirements

- You will need a Linux host system to run the Linux containers.
- You must install [Docker](https://www.docker.com/) or [Singularity/Apptainer](https://apptainer.org/) to run the containers.

## Setup instructions

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
