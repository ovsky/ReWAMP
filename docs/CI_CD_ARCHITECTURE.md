# ReWAMP CI/CD Architecture

## GitHub Actions Build Matrix

The project uses GitHub Actions to automatically build ReWAMP for **5 different platform/architecture combinations** on every push to the `main` branch and pull requests.

### Build Matrix Configuration

| Platform | Architecture | Runner | Binary Name | Artifact Name | Use Case |
|----------|-------------|--------|-------------|---------------|----------|
| Windows | AMD64 (64-bit) | `windows-latest` | `rewamp-windows-amd64.exe` | `rewamp-windows-amd64` | Modern Windows PCs |
| Windows | 386 (32-bit) | `windows-latest` | `rewamp-windows-386.exe` | `rewamp-windows-386` | Legacy Windows systems |
| Windows | ARM64 (64-bit) | `windows-latest` | `rewamp-windows-arm64.exe` | `rewamp-windows-arm64` | Surface Pro X, Windows on ARM |
| Linux | AMD64 (64-bit) | `ubuntu-latest` | `rewamp-linux-amd64` | `rewamp-linux-amd64` | Standard Linux servers/desktops |
| Linux | ARM64 (64-bit) | `ubuntu-latest` | `rewamp-linux-arm64` | `rewamp-linux-arm64` | Raspberry Pi 4+, ARM servers |

## Workflow Details

### Triggers

- ✅ **Push to main branch** - Builds all architectures
- ✅ **Pull requests** - Validates builds before merge
- ✅ **Tagged releases** (`v*`) - Creates GitHub releases with binaries

### Build Steps (Per Architecture)

1. **Checkout** - Clone repository code
2. **Setup Go 1.24** - Install Go toolchain
3. **Cache Dependencies** - Cache Go modules for faster builds
4. **Download Dependencies** - Run `go mod download`
5. **Run Tests** - Execute `go test -v ./...`
6. **Run Vet** - Execute `go vet ./...` for code quality
7. **Build Binary** - Cross-compile for target platform/architecture
8. **Upload Artifact** - Store binary as GitHub artifact

### Build Flags

**Windows:**
```bash
-ldflags="-H windowsgui -s -w"
```
- `-H windowsgui` - Hide console window (GUI app)
- `-s` - Strip debug symbols
- `-w` - Strip DWARF debug info

**Linux:**
```bash
-ldflags="-s -w"
```
- `-s` - Strip debug symbols
- `-w` - Strip DWARF debug info

## Artifact Storage

All built binaries are automatically uploaded as **GitHub Artifacts** after successful builds.

### Accessing Artifacts

1. **Via GitHub Actions UI:**
   - Go to repository → Actions tab
   - Click on workflow run
   - Scroll to "Artifacts" section at bottom
   - Download desired platform/architecture

2. **Via GitHub Releases:**
   - Go to repository → Releases
   - Download from latest release (when tagged)

### Artifact Retention

- **Pull Request builds**: 90 days (GitHub default)
- **Main branch builds**: 90 days (GitHub default)
- **Release builds**: Permanent (attached to release)

## Release Process

When a version tag is pushed (e.g., `v1.0.0`):

1. **Build Job** runs for all 5 architectures
2. **Release Job** activates (only on tags)
3. **Downloads** all 5 artifacts
4. **Creates GitHub Release** with:
   - Auto-generated release notes
   - All 5 binaries attached
   - Version tag reference

### Creating a Release

```bash
# Tag the release
git tag -a v1.0.0 -m "Release version 1.0.0"

# Push tag to GitHub
git push origin v1.0.0

# GitHub Actions automatically:
# - Builds all 5 binaries
# - Creates release
# - Attaches binaries
# - Generates release notes
```

## Continuous Integration Features

### ✅ Automated Testing
- Unit tests run on every build
- All architectures must pass tests
- Failures block merges

### ✅ Code Quality
- Go vet runs on every build
- Catches potential issues
- Enforces best practices

### ✅ Cross-Compilation
- Windows builds on Windows runners
- Linux builds on Ubuntu runners
- ARM64 cross-compiled from AMD64

### ✅ Caching
- Go modules cached per OS
- Significantly speeds up builds
- Cache invalidated on `go.sum` changes

### ✅ Matrix Strategy
- Parallel builds (all 5 architectures simultaneously)
- Faster total build time
- Independent failure isolation

## Build Performance

Typical build times per architecture:

| Platform | Architecture | Approximate Time |
|----------|-------------|------------------|
| Windows | AMD64 | ~2-3 minutes |
| Windows | 386 | ~2-3 minutes |
| Windows | ARM64 | ~2-3 minutes |
| Linux | AMD64 | ~1-2 minutes |
| Linux | ARM64 | ~1-2 minutes |

**Total parallel time**: ~3-4 minutes (all 5 architectures built simultaneously)

## Monitoring Builds

### Check Build Status

**Badge in README:**
```markdown
[![Build Status](https://github.com/ovsky/ReWAMP/workflows/Build%20and%20Release/badge.svg)](https://github.com/ovsky/ReWAMP/actions)
```

**GitHub Actions UI:**
- Repository → Actions tab
- View all workflow runs
- Click run for detailed logs
- Download artifacts from completed runs

### Build Notifications

GitHub automatically sends notifications when:
- ❌ Build fails on your commit
- ✅ Build succeeds after previous failure
- 📦 Release is published

## Architecture Benefits

1. **No Manual Builds** - Everything automated
2. **Consistent Binaries** - Same build process every time
3. **Multi-Platform** - All platforms built together
4. **Instant Distribution** - Artifacts immediately available
5. **Version Control** - All builds tagged and traceable
6. **Security** - Builds run in isolated GitHub runners
7. **Free** - GitHub Actions free for public repositories

## Troubleshooting

### Build Fails on Specific Architecture

Check the workflow log for that specific matrix job:
1. Go to Actions → Failed run
2. Expand failed job in left sidebar
3. Review build logs
4. Common issues:
   - Dependency problems
   - Platform-specific code errors
   - Test failures

### Artifact Not Available

- Check if build completed successfully
- Verify artifact retention period (90 days)
- Ensure you're looking at completed workflow
- Check if accessing correct workflow run

### Release Not Created

- Verify tag format matches `v*` pattern
- Check that all builds succeeded
- Review release job logs
- Ensure `GITHUB_TOKEN` has permissions

## Summary

ReWAMP uses GitHub Actions to provide:

✅ **5 Architecture Builds** - Windows (AMD64, 386, ARM64) + Linux (AMD64, ARM64)
✅ **Automatic Artifact Upload** - Every build stored for 90 days
✅ **Release Automation** - Tag → Build → Release
✅ **Parallel Builds** - All architectures built simultaneously
✅ **Quality Gates** - Tests and vet must pass
✅ **Free Infrastructure** - No cost for public repository

**Result**: Professional-grade CI/CD pipeline with zero manual intervention! 🚀
