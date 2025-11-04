# Building ReWAMP for Linux from Windows

## The Challenge

Cross-compiling Go applications with CGO dependencies (like `github.com/getlantern/systray`) from Windows to Linux is challenging because:

1. **CGO Requirement**: The systray library requires CGO to interface with native Linux libraries (libappindicator, libgtk)
2. **Cross-Compiler Needed**: Would require installing a Linux GCC cross-compiler toolchain on Windows
3. **Complexity**: Setting up the full toolchain is complex and error-prone

## The Solution: Use GitHub Actions

The recommended and easiest approach is to let **GitHub Actions** build the Linux binaries automatically on native Linux runners.

### How It Works

1. **Push your code** to GitHub:
   ```powershell
   git add .
   git commit -m "Add full Linux support"
   git push origin main
   ```

2. **GitHub Actions automatically builds** both Windows and Linux versions:
   - Windows builds on `windows-latest` runner
   - Linux builds on `ubuntu-latest` runner (with proper CGO support)

3. **Download artifacts** from the Actions tab or Releases page

### Current GitHub Actions Configuration

The workflow is already set up in `.github/workflows/build.yml`:

```yaml
matrix:
  include:
    - os: windows-latest
      goos: windows
      goarch: amd64
      binary: rewamp.exe

    - os: ubuntu-latest
      goos: linux
      goarch: amd64
      binary: rewamp
```

**Features:**
- ✅ Builds on push to main branch
- ✅ Builds on pull requests
- ✅ Creates releases on tags (v*)
- ✅ Uploads build artifacts
- ✅ Native compilation (no cross-compile issues)

## Alternative: Build on Linux

If you need to build locally, you can:

### Option 1: Use WSL (Windows Subsystem for Linux)

```bash
# In WSL
cd /mnt/c/Users/Administrator/Documents/GitHub/REWAMP
go build -ldflags="-s -w" -o rewamp ./cmd/rewamp
```

### Option 2: Use Docker

```powershell
# From Windows PowerShell
docker run --rm -v ${PWD}:/app -w /app golang:1.24 `
  go build -ldflags="-s -w" -o rewamp-linux-amd64 ./cmd/rewamp
```

### Option 3: Use a Linux VM or Server

Transfer the code to a Linux machine and build there:

```bash
git clone https://github.com/ovsky/ReWAMP.git
cd ReWAMP
./scripts/build.sh
# Or for release builds
./scripts/build.sh release
```

## Build Status

### ✅ Windows Build
Can be built natively on Windows:
```powershell
go build -ldflags="-H windowsgui -s -w" -o rewamp.exe ./cmd/rewamp
```
**Status:** Working ✅

### ⏳ Linux Build
Requires native Linux environment or GitHub Actions:
```bash
go build -ldflags="-s -w" -o rewamp ./cmd/rewamp
```
**Status:** Configured for CI/CD ✅

## Recommended Workflow

1. **Develop on Windows** (native build works)
2. **Commit and push** to GitHub
3. **Let GitHub Actions** build Linux binaries
4. **Download from Actions** tab or wait for release

This ensures:
- ✅ Proper native compilation
- ✅ Correct linking with system libraries
- ✅ No cross-compilation complexity
- ✅ Reproducible builds
- ✅ Automated testing

## Testing Linux Builds

Once GitHub Actions builds the Linux binary:

1. Download the artifact
2. Test on Linux:
   ```bash
   chmod +x rewamp-linux-amd64
   ./rewamp-linux-amd64
   ```

## Summary

**Can you build for Linux on Windows?**
- ❌ Not easily with CGO dependencies
- ✅ Yes, using GitHub Actions (recommended)
- ✅ Yes, using WSL or Docker
- ✅ Yes, on actual Linux machine

**Best Practice:** Use GitHub Actions for automated, native Linux builds. The workflow is already configured and ready to use!
