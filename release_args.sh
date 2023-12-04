#!/bin/bash
set -o errexit
set -o nounset
set -o pipefail

componentTemplateFile=k8s/helm/component-patch-tpl.yaml

# this function will be sourced from release.sh and be called from release_functions.sh
update_versions_modify_files() {
  local snapshotControllerImage
  snapshotControllerImage=$(yq ".snapshot_controller_image" < "k8s/helm/values.yaml")

  echo "Set images in component patch template file"
  update_component_patch_template ".values.images.snapshotController" "${snapshotControllerImage}"
}

update_component_patch_template() {
  local key="${1}"
  local value="${2}"
  yq -i "${key} = \"${value}\"" "${componentTemplateFile}"
}

update_versions_stage_modified_files() {
  git add "${componentTemplateFile}"
}
