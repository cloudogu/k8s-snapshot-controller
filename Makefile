ARTIFACT_ID=k8s-snapshot-controller
VERSION=7.0.2-1
MAKEFILES_VERSION=9.3.2
REGISTRY_NAMESPACE?=k8s
HELM_REPO_ENDPOINT=k3ces.local:30099

include build/make/variables.mk
include build/make/clean.mk
include build/make/self-update.mk

##@ Release

CRD_HELM_MANIFEST_TARGET=
include build/make/k8s-component.mk
include build/make/k8s-crd.mk

.PHONY: snapshot-controller-release
snapshot-controller-release: ## Interactively starts the release workflow.
	@echo "Starting git flow release..."
	@build/make/release.sh snapshot-controller
