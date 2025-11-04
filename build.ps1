# REWAMP Build Script
# Modern PowerShell build script with error handling and features

param(
    [string]$Version = "dev",
    [switch]$Release,
    [switch]$Clean,
    [switch]$Test,
    [switch]$Lint,
    [switch]$All
)

# Set error action preference
$ErrorActionPreference = "Stop"

# Colors for output
function Write-ColorOutput {
    param([string]$Message, [ConsoleColor]$Color = "White")
    Write-Host $Message -ForegroundColor $Color
}

function Write-Success { param([string]$Message) Write-ColorOutput "✓ $Message" "Green" }
function Write-Info { param([string]$Message) Write-ColorOutput "ℹ $Message" "Cyan" }
function Write-Warning { param([string]$Message) Write-ColorOutput "⚠ $Message" "Yellow" }
function Write-Error { param([string]$Message) Write-ColorOutput "✗ $Message" "Red" }

# Get build information
$BuildTime = Get-Date -Format "yyyy-MM-ddTHH:mm:sszzz"
$GitHash = try { git rev-parse --short HEAD 2>$null } catch { "unknown" }
if ($Version -eq "dev") {
    $Version = "dev-$GitHash"
}

Write-Info "Building REWAMP $Version"

# Clean previous builds
if ($Clean -or $All) {
    Write-Info "Cleaning previous builds..."
    try {
        Remove-Item -Path "*.exe" -Force -ErrorAction SilentlyContinue
        Remove-Item -Path "dist" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Success "Cleaned build artifacts"
    }
    catch {
        Write-Warning "Some files could not be cleaned: $_"
    }
}

# Run tests
if ($Test -or $All) {
    Write-Info "Running tests..."
    try {
        go test -v ./...
        Write-Success "Tests passed"
    }
    catch {
        Write-Error "Tests failed: $_"
        exit 1
    }
}

# Run linting
if ($Lint -or $All) {
    Write-Info "Running code analysis..."
    try {
        go vet ./...
        Write-Success "Code analysis passed"
    }
    catch {
        Write-Warning "Code analysis warnings: $_"
    }
}

# Build the application
Write-Info "Building application..."
try {
    $LdFlags = "-H windowsgui -s -w -X main.version=$Version -X main.buildTime=$BuildTime"

    if ($Release) {
        # Build for multiple architectures
        Write-Info "Building release versions..."

        # Create dist directory
        New-Item -ItemType Directory -Path "dist" -Force | Out-Null

        # Windows AMD64
        $env:GOOS = "windows"
        $env:GOARCH = "amd64"
        go build -ldflags="$LdFlags" -o "dist/rewamp-windows-amd64.exe" .
        Write-Success "Built Windows AMD64 version"

        # Windows 386
        $env:GOARCH = "386"
        go build -ldflags="$LdFlags" -o "dist/rewamp-windows-386.exe" .
        Write-Success "Built Windows 386 version"

        # Copy additional files
        Copy-Item "README.md" "dist/"
        Copy-Item "LICENSE" "dist/"

        Write-Success "Release build completed in dist/ directory"
    }
    else {
        # Regular build
        go build -ldflags="$LdFlags" -o "rewamp.exe" .
        Write-Success "Build completed: rewamp.exe"
    }

    # Show file size
    if (Test-Path "rewamp.exe") {
        $Size = (Get-Item "rewamp.exe").Length
        $SizeKB = [math]::Round($Size / 1KB, 2)
        Write-Info "Binary size: $SizeKB KB"
    }

}
catch {
    Write-Error "Build failed: $_"
    exit 1
}
finally {
    # Reset environment variables
    Remove-Item env:GOOS -ErrorAction SilentlyContinue
    Remove-Item env:GOARCH -ErrorAction SilentlyContinue
}

Write-Success "Build process completed successfully!"