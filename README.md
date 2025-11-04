
# ![logo](./icon/icon_small.png) REWAMP

> Modern Zero-install WAMP built with Go.

[![Build Status](https://github.com/ovsky/REWAMP/workflows/Build%20and%20Release/badge.svg)](https://github.com/ovsky/REWAMP/actions)
[![Go Report Card](https://goreportcard.com/badge/github.com/ovsky/REWAMP)](https://goreportcard.com/report/github.com/ovsky/REWAMP)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

The goal of REWAMP is to provide a simple executable to run web development tools with one click. It's packed with Apache / MySQL / PHP / MongoDB and administration tools pre-configured.

Heavily inspired by the now defunct ZWAMP and modernized for 2025.

![screenshot](./screenshot.png)

## Features

- ✅ **Zero Configuration**: Works out of the box
- ✅ **System Tray Integration**: Convenient system tray menu
- ✅ **Multiple Services**: Apache, MySQL, PHP, MongoDB, Memcached
- ✅ **Quick Access**: Direct links to admin tools and documentation
- ✅ **Virtual Drive**: Isolated environment using virtual drives
- ✅ **Modern Go**: Built with Go 1.24+ and modern dependencies

## Getting Started

### Download Pre-built Binary

Download the latest release from the [Releases page](https://github.com/ovsky/REWAMP/releases).

### Building from Source

#### Prerequisites

- Go 1.24 or later
- Windows (for the system tray functionality)

#### Build Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/ovsky/REWAMP.git
   cd REWAMP
   ```

2. Download dependencies:
   ```bash
   go mod download
   ```

3. Build the executable:
   ```bash
   go build -ldflags="-H windowsgui -s -w" -o rewamp.exe .
   ```

   Or use the provided build script:
   ```bash
   build.bat
   ```

#### Development Setup

1. Install Go 1.24 or later from [golang.org](https://golang.org/downloads/)

2. Clone and setup the project:
   ```bash
   git clone https://github.com/ovsky/REWAMP.git
   cd REWAMP
   go mod tidy
   ```

3. Run in development mode:
   ```bash
   go run .
   ```

## How It Works

REWAMP creates a virtual drive (usually Z:) that contains all the web development tools. This approach provides:

- **Isolation**: No interference with system-installed software
- **Portability**: Entire stack is self-contained
- **Clean Uninstall**: Simply delete the folder

## Where to Put Your Code

Add your PHP files or web applications to the `vdrive\web` folder.

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
