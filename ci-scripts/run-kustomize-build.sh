#!/bin/bash

ROOT_PATH=${1:-./k8s}

function run_kustomize() {
  echo -n "Running kustomize in ${1} ... "
  out=$(cd "${1}" && kustomize build 2>&1)
  if [ $? -ne 0 ]; then
    echo FAILED
    echo "${out}"
    exit 1
  else
    echo OK
  fi
}

for kustomization in $(find ${ROOT_PATH} -iname kustomization.yaml -type f); do
  run_kustomize $(dirname ${kustomization})
done
