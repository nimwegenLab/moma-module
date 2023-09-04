setup_docker_container() {
  if [[ "$(docker images -q "${CONTAINER_TAG}" 2> /dev/null)" == "" ]]; then
    printf "Setting up module with Docker container.\n"
    docker pull "${CONTAINER_TAG}"
  fi
  id=$(docker create "${CONTAINER_TAG}")

  ### Copy support scripts from container to host
  HOST_SCRIPT_DIR="/host_scripts"
  if [[ ! -f "${MOMA_BIN_DIRECTORY}/moma" ]]; then
    docker cp "${id}":"${HOST_SCRIPT_DIR}/moma" "${MOMA_BIN_DIRECTORY}/moma"
  fi
  if [[ ! -f "${MOMA_BIN_DIRECTORY}/moma_batch_run" ]]; then
    docker cp "${id}":"${HOST_SCRIPT_DIR}/moma_batch_run" "${MOMA_BIN_DIRECTORY}/moma_batch_run"
  fi
  if [[ ! -f "${HOME}/.moma/mm.properties" ]]; then
    docker cp "${id}":"${HOST_SCRIPT_DIR}/mm.properties" "${MOMA_BIN_DIRECTORY}/mm.properties"
  fi
}

function setup_singularity_container() {
    if [[ ! -f "${SINGULARITY_CONTAINER_FILE_PATH}" ]]; then
      printf "Setting up module with Singularity container.\n"
      singularity pull "${SINGULARITY_CONTAINER_FILE_PATH}" "docker://${CONTAINER_TAG}"
    fi

    HOST_SCRIPT_DIR="/host_scripts"
    if [[ ! -f "${MOMA_BIN_DIRECTORY}/moma" ]]; then
      singularity  exec --bind "${SINGULARITY_CONTAINER_DIR}":"${SINGULARITY_CONTAINER_DIR}" "${SINGULARITY_CONTAINER_FILE_PATH}" cp "${HOST_SCRIPT_DIR}/moma" "${SINGULARITY_CONTAINER_DIR}/moma"
    fi
    if [[ ! -f "${MOMA_BIN_DIRECTORY}/moma_batch_run" ]]; then
      singularity  exec --bind "${SINGULARITY_CONTAINER_DIR}":"${SINGULARITY_CONTAINER_DIR}" "${SINGULARITY_CONTAINER_FILE_PATH}" cp "${HOST_SCRIPT_DIR}/moma_batch_run" "${SINGULARITY_CONTAINER_DIR}/moma_batch_run"
    fi
    if [[ ! -f "${HOME}/.moma/mm.properties" ]]; then
      singularity  exec --bind "${SINGULARITY_CONTAINER_DIR}":"${SINGULARITY_CONTAINER_DIR}" "${SINGULARITY_CONTAINER_FILE_PATH}" cp "${HOST_SCRIPT_DIR}/mm.properties" "${SINGULARITY_CONTAINER_DIR}/mm.properties"
    fi
}

setup_module() {
  export VERSION="v0.9.8"
  export CONTAINER_NAME="moma"
  CONTAINER_NAMESPACE="nimwegenlab"
  export CONTAINER_TAG="${CONTAINER_NAMESPACE}/${CONTAINER_NAME}:${VERSION}"

  DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
  MOMA_BIN_DIRECTORY="${DIR}/bin/"
  export SINGULARITY_CONTAINER_DIR="${MOMA_BIN_DIRECTORY}"
  SINGULARITY_CONTAINER_FILENAME="${CONTAINER_NAME//\//_}_${VERSION}.sif"
  export SINGULARITY_CONTAINER_FILE_PATH="${SINGULARITY_CONTAINER_DIR}/${SINGULARITY_CONTAINER_FILENAME}"

  if [[ ! -d "${MOMA_BIN_DIRECTORY}" ]]
  then
    mkdir -p "${MOMA_BIN_DIRECTORY}"
  fi

  if command -v docker &> /dev/null
  then
    setup_docker_container
  elif command -v singularity &> /dev/null
  then
    setup_singularity_container
  else
      printf "ERROR: No container engine was found. Check that Singularity or Docker are correctly configured."
      exit 1
  fi
}
