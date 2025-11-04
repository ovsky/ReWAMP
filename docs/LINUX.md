# ReWAMP on Linux

This guide covers running ReWAMP on Linux systems.

## Requirements

### System Requirements
- Linux distribution with desktop environment (GNOME, KDE, XFCE, etc.)
- System tray support
- Go 1.24+ (for building from source)

### Required Services
You need to have the following services installed on your system:
- Apache (httpd or apache2)
- MySQL (mysqld)
- MongoDB (mongod)
- PHP
- Memcached

## Installation

### Option 1: Download Pre-built Binary

1. Download the latest Linux binary from the [Releases page](https://github.com/ovsky/ReWAMP/releases)
2. Make it executable:
   ```bash
   chmod +x rewamp-linux-amd64
   ```
3. Optionally, move it to your PATH:
   ```bash
   sudo mv rewamp-linux-amd64 /usr/local/bin/rewamp
   ```

### Option 2: Build from Source

1. Install Go 1.24+:
   ```bash
   # Ubuntu/Debian
   sudo apt update
   sudo apt install golang-go
   
   # Fedora
   sudo dnf install golang
   
   # Arch Linux
   sudo pacman -S go
   ```

2. Clone and build:
   ```bash
   git clone https://github.com/ovsky/ReWAMP.git
   cd ReWAMP
   go mod download
   go build -ldflags="-s -w" -o rewamp ./cmd/rewamp
   ```

3. Make executable and install:
   ```bash
   chmod +x rewamp
   sudo mv rewamp /usr/local/bin/
   ```

## Setting Up Services

ReWAMP expects services to be available in specific locations. Here's how to set them up:

### 1. Create the VDrive Directory Structure

```bash
cd /path/to/ReWAMP
mkdir -p vdrive/.sys/{apache2,mysql,php,mongodb,memcached}
```

### 2. Configure Service Paths

You have two options:

#### Option A: Use System-Wide Services
Point ReWAMP to your system's installed services by creating symbolic links:

```bash
# Apache
ln -s /usr/bin/httpd vdrive/.sys/apache2/bin/httpd
# or for apache2
ln -s /usr/sbin/apache2 vdrive/.sys/apache2/bin/httpd

# MySQL
ln -s /usr/bin/mysqld vdrive/.sys/mysql/bin/mysqld

# MongoDB
ln -s /usr/bin/mongod vdrive/.sys/mongodb/mongod

# Memcached
ln -s /usr/bin/memcached vdrive/.sys/memcached/memcached

# PHP
ln -s /usr/bin/php vdrive/.sys/php/php
```

#### Option B: Install Portable Versions
Install portable/local versions of the services in the vdrive directory structure.

### 3. Configuration Files

Create basic configuration files in the appropriate locations:

```bash
# Apache config
mkdir -p vdrive/.sys/apache2/conf
touch vdrive/.sys/apache2/conf/httpd.conf

# MySQL config
mkdir -p vdrive/.sys/mysql
touch vdrive/.sys/mysql/my.ini

# PHP config
touch vdrive/.sys/php/php.ini

# MongoDB config
mkdir -p vdrive/.sys/mongodb
touch vdrive/.sys/mongodb/mongod.yaml
```

## Running ReWAMP

### Start the Application

```bash
rewamp
```

The application will:
1. Create a symlink at `/tmp/rewamp-{uid}` pointing to your vdrive directory
2. Add service paths to your PATH
3. Display a system tray icon with service controls

### System Tray

Look for the ReWAMP icon in your system tray. From there you can:
- Start/Stop individual services
- View logs
- Edit configuration files
- Access documentation

## Configuration

ReWAMP stores its configuration in `~/.config/rewamp/config.json`. This includes:
- Virtual drive path
- Symlink path
- Service process IDs

## Troubleshooting

### System Tray Icon Not Appearing

Make sure your desktop environment supports system tray icons:

**GNOME:**
```bash
# Install AppIndicator extension
gnome-extensions install appindicatorsupport@rgcjonas.gmail.com
```

**KDE Plasma:**
System tray is built-in and should work automatically.

**XFCE:**
Make sure the Notification Area plugin is enabled in your panel.

### Service Won't Start

1. Check if the service executable exists:
   ```bash
   ls -la /tmp/rewamp-$(id -u)/.sys/*/bin/
   ```

2. Check if you have permissions:
   ```bash
   ls -l /tmp/rewamp-$(id -u)
   ```

3. Try starting the service manually:
   ```bash
   /tmp/rewamp-$(id -u)/.sys/apache2/bin/httpd
   ```

### Text Editor Not Opening

ReWAMP uses the `$EDITOR` environment variable. Set it to your preferred editor:

```bash
export EDITOR=nano
# or
export EDITOR=vim
# or
export EDITOR=gedit
```

Add this to your `~/.bashrc` or `~/.profile` to make it permanent.

### Cannot Open URLs

ReWAMP uses `xdg-open` to open URLs. Make sure it's installed:

```bash
# Ubuntu/Debian
sudo apt install xdg-utils

# Fedora
sudo dnf install xdg-utils

# Arch Linux
sudo pacman -S xdg-utils
```

## Uninstallation

1. Stop ReWAMP (Quit from system tray)
2. Remove the binary:
   ```bash
   sudo rm /usr/local/bin/rewamp
   ```
3. Remove configuration:
   ```bash
   rm -rf ~/.config/rewamp
   ```
4. Remove project directory:
   ```bash
   rm -rf /path/to/ReWAMP
   ```

## Differences from Windows

| Feature | Windows | Linux |
|---------|---------|-------|
| Drive Mount | Virtual Drive (Z:) | Symlink (/tmp/rewamp-uid) |
| Configuration | Windows Registry | JSON file (~/.config/rewamp/) |
| Text Editor | Notepad | $EDITOR or nano/vim/vi |
| File/URL Opening | rundll32 | xdg-open |
| Path Separator | \ (backslash) | / (forward slash) |
| Process Management | Windows API | Unix signals (SIGTERM/SIGKILL) |

## Tips

1. **Autostart:** Add ReWAMP to your desktop environment's autostart applications
2. **Multiple Instances:** Each user can run their own instance (separate configs)
3. **Service Logs:** Check service logs in `vdrive/.sys/{service}/logs/`
4. **Performance:** Use local/portable service installations for better isolation

## Support

For issues specific to Linux, please:
1. Check the troubleshooting section above
2. Review the main [README.md](../README.md)
3. Open an issue on [GitHub](https://github.com/ovsky/ReWAMP/issues) with:
   - Your Linux distribution and version
   - Desktop environment
   - Error messages or logs
   - Steps to reproduce
