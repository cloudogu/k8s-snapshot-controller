ARTIFACT_ID=k8s-snapshot-controller
VERSION=5.0.1-3
MAKEFILES_VERSION=8.7.3
REGISTRY_NAMESPACE?=k8s
HELM_REPO_ENDPOINT=k3ces.local:30099

include build/make/variables.mk
include build/make/clean.mk
include build/make/self-update.mk

##@ Release
PRE_APPLY_TARGETS=
K8S_PRE_GENERATE_TARGETS=generate-release-resource
include build/make/k8s-component.mk
include build/make/k8s-crd.mk

.PHONY: generate-release-resource
generate-release-resource: $(K8S_RESOURCE_TEMP_FOLDER)
	@cp manifests/snapshot-controller.yaml ${K8S_RESOURCE_TEMP_YAML}

.PHONY: snapshot-controller-release
snapshot-controller-release: ## Interactively starts the release workflow.
	@echo "Starting git flow release..."
	@build/make/release.sh snapshot-controller
