# k8s-snapshot-controller Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
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