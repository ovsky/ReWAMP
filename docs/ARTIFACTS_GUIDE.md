# Quick Reference: GitHub Actions Artifacts

## 📦 What Gets Built

Every push to `main` and every pull request automatically builds:

| # | Platform | Architecture | Binary Name | Artifact Name |
|---|----------|-------------|-------------|---------------|
| 1️⃣ | Windows | AMD64 (64-bit) | `rewamp-windows-amd64.exe` | `rewamp-windows-amd64` |
| 2️⃣ | Windows | 386 (32-bit) | `rewamp-windows-386.exe` | `rewamp-windows-386` |
| 3️⃣ | Windows | ARM64 | `rewamp-windows-arm64.exe` | `rewamp-windows-arm64` |
| 4️⃣ | Linux | AMD64 (64-bit) | `rewamp-linux-amd64` | `rewamp-linux-amd64` |
| 5️⃣ | Linux | ARM64 | `rewamp-linux-arm64` | `rewamp-linux-arm64` |

## 📥 How to Download Artifacts

### Option 1: From Actions Tab

1. Go to https://github.com/ovsky/ReWAMP/actions
2. Click on the latest workflow run
3. Scroll to **"Artifacts"** section at the bottom
4. Click on the artifact you want to download
5. It downloads as a ZIP file - extract to get the binary

### Option 2: From Releases (When Tagged)

1. Go to https://github.com/ovsky/ReWAMP/releases
2. Find the latest release
3. Download the binary for your platform directly
4. No ZIP extraction needed - binaries are attached directly

## 🎯 Which Binary Should I Use?

### Windows Users

- **Most users**: `rewamp-windows-amd64.exe` (Modern 64-bit PCs)
- **Older systems**: `rewamp-windows-386.exe` (32-bit Windows)
- **Surface Pro X / Windows on ARM**: `rewamp-windows-arm64.exe`

### Linux Users

- **Most users**: `rewamp-linux-amd64` (Standard x86_64 systems)
- **Raspberry Pi 4+ / ARM servers**: `rewamp-linux-arm64`

## ✅ Artifact Verification

All artifacts include:
- ✅ Passed all unit tests
- ✅ Passed go vet code quality checks
- ✅ Optimized and stripped debug symbols
- ✅ Built with Go 1.24+

## ⏰ Artifact Retention

- **Branch builds**: Available for 90 days
- **PR builds**: Available for 90 days
- **Release builds**: Available permanently

## 🔍 Checking Build Status

Live build status badge:

![Build Status](https://github.com/ovsky/ReWAMP/workflows/Build%20and%20Release/badge.svg)

## 📝 Notes

- All 5 binaries are built in parallel (takes ~3-4 minutes total)
- Each artifact is a separate download
- Windows binaries include `.exe` extension
- Linux binaries are executable files (no extension)
- All binaries are statically linked (no dependencies needed)

## 🚀 Creating a Release

**For maintainers:**

```bash
# Create and push a version tag
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0

# GitHub Actions will automatically:
# - Build all 5 binaries
# - Create a GitHub release
# - Attach all binaries to the release
# - Generate release notes
```

All 5 binaries will be available in the release within ~4 minutes! 🎉
