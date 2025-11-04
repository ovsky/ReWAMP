
# ![logo](./icon/icon_small.png) ReWAMP

> Modern Cross-Platform Web Development Stack built with Go.

[![Build Status](https://github.com/ovsky/ReWAMP/workflows/Build%20and%20Release/badge.svg)](https://github.com/ovsky/ReWAMP/actions)
[![Go Report Card](https://goreportcard.com/badge/github.com/ovsky/ReWAMP)](https://goreportcard.com/report/github.com/ovsky/ReWAMP)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

The goal of ReWAMP is to provide a simple executable to run web development tools with one click. It's packed with Apache / MySQL / PHP / MongoDB and administration tools pre-configured.

**Now with full Linux support!** Works on both Windows and Linux distributions.

Heavily inspired by the now defunct ZWAMP and modernized for 2025.

![screenshot](./screenshot.png)

## Features

- ✅ **Zero Configuration**: Works out of the box
- ✅ **Cross-Platform**: Full support for Windows and Linux
- ✅ **Multiple Architectures**: AMD64, ARM64, and x86 (32-bit)
- ✅ **System Tray Integration**: Convenient system tray menu
- ✅ **Multiple Services**: Apache, MySQL, PHP, MongoDB, Memcached
- ✅ **Quick Access**: Direct links to admin tools and documentation
- ✅ **Isolated Environment**: Virtual drives (Windows) or symlinks (Linux)
- ✅ **Modern Go**: Built with Go 1.24+ and modern dependencies

## Getting Started

### Download Pre-built Binary

Download the latest release from the [Releases page](https://github.com/ovsky/ReWAMP/releases).

### Building from Source

#### Prerequisites

- Go 1.24 or later
- System tray support (Windows or Linux with desktop environment)

#### Build Steps

**Windows:**

1. Clone the repository:
   ```bash
   git clone https://github.com/ovsky/ReWAMP.git
   cd ReWAMP
   ```

2. Download dependencies:
   ```bash
   go mod download
   ```

3. Build the executable:
   ```bash
   go build -ldflags="-H windowsgui -s -w" -o rewamp.exe ./cmd/rewamp
   ```

   Or use the provided build script:
   ```powershell
   .\scripts\build.ps1
   ```
   Or:
   ```cmd
   scripts\build.bat
   ```

**Linux:**

1. Clone the repository:
   ```bash
   git clone https://github.com/ovsky/ReWAMP.git
   cd ReWAMP
   ```

2. Download dependencies:
   ```bash
   go mod download
   ```

3. Build the executable:
   ```bash
   go build -ldflags="-s -w" -o rewamp ./cmd/rewamp
   ```

   Or use the provided build script:
   ```bash
   chmod +x scripts/build.sh
   ./scripts/build.sh
   ```

4. For release builds (multiple architectures):
   ```bash
   ./scripts/build.sh release
   ```

#### Using Makefile

The project includes a cross-platform Makefile:

```bash
# Build for current platform
make build

# Build for Windows (amd64 and 386)
make build-windows

# Build for Linux (amd64 and arm64)
make build-linux

# Build for all platforms
make build-all

# Run tests
make test

# Clean build artifacts
make clean
```

#### Development Setup

1. Install Go 1.24 or later from [golang.org](https://golang.org/downloads/)

2. Clone and setup the project:
   ```bash
   git clone https://github.com/ovsky/ReWAMP.git
   cd ReWAMP
   go mod tidy
   ```

3. Run in development mode:
   ```bash
   go run ./cmd/rewamp
   ```

## How It Works

ReWAMP creates an isolated environment for all your web development tools:

**Windows:** Creates a virtual drive (usually Z:) using Windows DOS device API.

**Linux:** Creates a symlink in `/tmp/rewamp-{uid}` pointing to the local vdrive directory.

This approach provides:

- **Isolation**: No interference with system-installed software
- **Portability**: Entire stack is self-contained
- **Clean Uninstall**: Simply delete the folder
- **Cross-Platform**: Consistent behavior on Windows and Linux

## Where to Put Your Code

**Windows:** Add your PHP files or web applications to the `vdrive\web` folder or `Z:\web`.

**Linux:** Add your PHP files or web applications to the `vdrive/web` folder or follow the symlink at `/tmp/rewamp-{uid}/web`.

## Platform-Specific Notes

### Windows
- Uses virtual drive letters (Z:, Y:, etc.)
- Services run as background processes
- Configuration stored in Windows Registry
- Text editor: Notepad (default)

### Linux
- Uses symlinks in /tmp directory
- Requires system tray support (GNOME, KDE, XFCE, etc.)
- Configuration stored in `~/.config/rewamp/config.json`
- Text editor: Uses $EDITOR environment variable or falls back to nano/vim/vi
- File browser: Uses xdg-open or falls back to common browsers

**📖 For detailed Linux setup instructions, see [docs/LINUX.md](docs/LINUX.md)**

## Included Tools and Versions

### Core Services
- **Apache 2.4.41+** - Web Server
- **MySQL 8.0.18+** - Relational Database (username: root / password: password)
- **MongoDB 4.2.1+** - Document Database
- **PHP 7.4.0+** - Server-side Scripting
- **Memcached 1.5.20+** - Caching System

### PHP Extensions
- Pear 2
- APCu 5.1.18+
- GeoIP 1.1.1+
- YAML 2.0.1+
- MongoDB 1.6.1+
- curl, gd2, openssl, pdo_mysql, pdo_sqlite, sqlite3, tidy, xmlrpc, opcache, mbstring

### Admin Tools
- **Adminer 4.7.5+** - Database Administration
- **MemCache Admin** - Memcached Management
- **APC Dashboard** - PHP Opcode Cache Statistics

## Dependencies

This project uses the following Go modules:

- [github.com/getlantern/systray](https://github.com/getlantern/systray) - System tray functionality
- [github.com/lxn/win](https://github.com/lxn/win) - Windows API bindings
- [github.com/mitchellh/go-ps](https://github.com/mitchellh/go-ps) - Process management
- [github.com/sqweek/dialog](https://github.com/sqweek/dialog) - Native dialogs
- [golang.org/x/sys](https://golang.org/x/sys) - System calls

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Original XWAMP project by romualdr
- ZWAMP project for inspiration
- All contributors and users
