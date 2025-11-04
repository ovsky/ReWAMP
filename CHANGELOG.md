# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Modern Go module system with `go.mod`
- GitHub Actions CI/CD pipeline
- Comprehensive Makefile for cross-platform builds
- PowerShell build script with enhanced features
- Comprehensive test suite
- Code linting with golangci-lint
- Version information in system tray menu
- Modern documentation (README, CONTRIBUTING, CHANGELOG)
- Cross-platform build support

### Changed
- Updated from deprecated `github.com/romualdr/systray` to `github.com/getlantern/systray`
- Modernized import syntax (removed relative imports)
- Updated build constraints from `+build` to `//go:build`
- Improved .gitignore with modern Go project patterns
- Enhanced README with modern features and build instructions
- Updated application name from XWAMP to REWAMP
- Modernized code structure and organization

### Deprecated
- Old build.bat script (replaced with enhanced version)

### Removed
- Outdated dependency references
- Legacy build constraints

### Fixed
- Build issues with modern Go versions
- Import path problems
- Deprecated syntax warnings

### Security
- Updated all dependencies to latest secure versions
- Added dependency vulnerability scanning in CI

## [Previous Versions]

### Historical Note
This project is a modernized fork of the original XWAMP project. Previous versions were maintained in the original repository at `github.com/romualdr/xwamp`.