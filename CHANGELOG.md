# k8s-snapshot-controller Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v8.2.1-3] - 2025-07-17
### Changed
- [#25] Update Makefiles to 10.2.0
### Added
- [#25] add metadata mapping for logLevel

## [v8.2.1-2] - 2025-07-01
### Fixes
- [#23] Update old CRD-dependency

## [v8.2.1-1] - 2025-06-05
### Changed
- [#21] Update snapshot-controller to 8.2.1

## [v7.0.2-3] - 2025-04-30

### Changed
- [#19] Set sensible resource requests and limits

## [v7.0.2-1] - 2025-04-03
### Changed
- [#17] Update snapshot-controller to 7.0.2

## [v6.2.1-1] - 2025-04-01
### Changed
- [#15] Update snapshot-controller to 6.2.1

## [v5.0.1-8] - 2024-12-05
### Added
- [#13] Add networkPolicy to deny all ingress traffic

## [v5.0.1-7] - 2024-10-28
## Changed
- [#11] Use `ces-container-registries` secret for pulling container images as default.

## [v5.0.1-6] - 2024-09-19
- Relicense to AGPL-3.0-only

## [v5.0.1-5] - 2023-12-06
### Added
- [#7] Added component patch template file for mirroring this chart in offline environments.

### Changed
- [#7] Update makefiles and just use only the chart as yaml resources.

## [v5.0.1-4] - 2023-10-24
### Changed
- [#4] Add labels `app=ces` and `k8s.cloudogu.com/part-of=backup`.
- Split CRDs in second chart.

## [v5.0.1-3] - 2023-10-06
## Fixed
- [#3] Use correct namespace from helm release.

## [v5.0.1-2] - 2023-10-02
## Fixed
- Fixed automatic release in Jenkinsfile.

## [v5.0.1-1] - 2023-10-02
### Added
- [#1] Add initial version of the snapshot-controller component.