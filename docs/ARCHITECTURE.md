# REWAMP Project Structure

This document describes the modern project structure adopted for REWAMP.

## Directory Layout

```
REWAMP/
├── .github/              # GitHub-specific files
│   ├── workflows/        # CI/CD workflows
│   ├── ISSUE_TEMPLATE/   # Issue templates
│   └── ...
├── assets/               # Static assets
│   └── icons/            # Application icons (Windows and Unix)
├── cmd/                  # Command line applications
│   └── rewamp/           # Main application entry point
│       ├── main.go       # Application logic (cross-platform)
│       ├── main_test.go  # Tests
│       ├── windows.go    # Platform-specific Windows code
│       └── linux.go      # Platform-specific Linux code
├── docs/                 # Documentation
├── scripts/              # Build and utility scripts
│   ├── build.bat         # Windows batch build script
│   ├── build.ps1         # PowerShell build script
│   └── build.sh          # Linux/Unix build script
├── vdrive/               # Virtual drive content (gitignored)
├── .editorconfig         # Editor configuration
├── .gitignore            # Git ignore rules
├── .golangci.yml         # Linting configuration
├── CHANGELOG.md          # Change log
├── CONTRIBUTING.md       # Contribution guidelines
├── go.mod                # Go module definition
├── go.sum                # Go module checksums
├── LICENSE               # Project license
├── Makefile              # Build automation
├── README.md             # Project documentation
└── SECURITY.md           # Security policy
```

## Key Directories

### `/cmd`
Contains the main applications for this project. The directory name for each application should match the name of the executable you want to have. The `cmd/rewamp` directory contains the main REWAMP application entry point.

### `/assets`
Static files used by the application, such as icons, images, and embedded resources. Organized by type for easy maintenance.

### `/scripts`
Build scripts, installation scripts, and other utility scripts. Separated from the root to keep the project root clean.

### `/docs`
Documentation files, additional to the root-level README.md.

### `/.github`
GitHub-specific files including workflows for CI/CD, issue templates, and pull request templates.

## Building

### Using Makefile (Recommended)
```bash
# Build for current platform
make build

# Build for Windows
make build-windows

# Build for Linux
make build-linux

# Build for all platforms
make build-all

# Clean and rebuild
make clean build
```

### Direct Go Commands

**Windows:**
```bash
go build -ldflags="-H windowsgui -s -w" -o rewamp.exe ./cmd/rewamp
```

**Linux:**
```bash
go build -ldflags="-s -w" -o rewamp ./cmd/rewamp
```

### Using Build Scripts

**Windows:**
```bash
# From project root
.\scripts\build.bat        # Windows batch
.\scripts\build.ps1        # PowerShell

# From scripts directory
cd scripts
.\build.bat
.\build.ps1
```

**Linux:**
```bash
# From project root
chmod +x scripts/build.sh  # First time only
./scripts/build.sh         # Development build
./scripts/build.sh release # Release builds (amd64 + arm64)

# From scripts directory
cd scripts
chmod +x build.sh          # First time only
./build.sh
./build.sh release
```

## Testing

```bash
# Test all packages
go test ./...

# Test main package only
go test ./cmd/rewamp
```

## Why This Structure?

This structure follows the [Standard Go Project Layout](https://github.com/golang-standards/project-layout) which provides several benefits:

1. **Clear Separation**: Application code, assets, and scripts are clearly separated
2. **Scalability**: Easy to add new commands or internal packages as the project grows
3. **Standard Practices**: Follows Go community conventions
4. **CI/CD Friendly**: Build tools and CI systems can easily navigate the structure
5. **Maintainability**: Contributors can quickly understand where things belong

## Platform-Specific Implementation

REWAMP uses Go build tags to provide platform-specific implementations:

### Cross-Platform Code (`main.go`)
- Core application logic
- UI creation and management
- Service definitions with platform-aware paths
- Helper functions for path conversion

### Windows-Specific (`windows.go`)
- Build tag: `//go:build windows`
- Virtual drive creation using Windows DOS device API
- Windows Registry for configuration storage
- Process management using Windows APIs
- Notepad for text editing

### Linux-Specific (`linux.go`)
- Build tag: `//go:build linux`
- Symlink creation in `/tmp` directory
- JSON file configuration in `~/.config/rewamp/`
- Process management using Unix signals
- xdg-open for file/URL opening
- Respects `$EDITOR` environment variable

## Migration Notes

The project was reorganized and enhanced in November 2025:

**Initial Reorganization:**
- Moved `main.go` → `cmd/rewamp/main.go`
- Moved `windows.go` → `cmd/rewamp/windows.go`
- Moved `icon/` → `assets/icons/`
- Moved build scripts → `scripts/`
- Updated import paths to `rewamp/assets/icons`

**Linux Support Added:**
- Created `cmd/rewamp/linux.go` with full Linux implementation
- Updated `main.go` to be cross-platform aware
- Added Linux build scripts and Makefile targets
- Updated CI/CD to build for both Windows and Linux
- Enhanced documentation for cross-platform usage
