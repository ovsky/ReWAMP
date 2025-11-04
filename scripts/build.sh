#!/bin/bash
# Linux Build Script for ReWAMP
# Usage: ./build.sh [release]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
BINARY_NAME="rewamp"
CMD_PATH="./cmd/rewamp"
BUILD_DIR="build"

# Get version info
if [ -d ".git" ]; then
    VERSION=$(git describe --tags --always --dirty 2>/dev/null || echo "dev")
    BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
else
    VERSION="dev"
    BUILD_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
fi

echo -e "${GREEN}ReWAMP Linux Build Script${NC}"
echo -e "${YELLOW}Version: $VERSION${NC}"
echo -e "${YELLOW}Build Time: $BUILD_TIME${NC}"
echo ""

# Build flags
LDFLAGS="-s -w -X main.version=$VERSION -X main.buildTime=$BUILD_TIME"

# Check if release build
if [ "$1" == "release" ]; then
    echo -e "${GREEN}Building release binaries...${NC}"
    
    # Create build directory
    mkdir -p $BUILD_DIR
    
    # Build for Linux AMD64
    echo -e "${YELLOW}Building for Linux AMD64...${NC}"
    GOOS=linux GOARCH=amd64 go build -ldflags="$LDFLAGS" -o "$BUILD_DIR/${BINARY_NAME}-linux-amd64" $CMD_PATH
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Linux AMD64 build successful${NC}"
    else
        echo -e "${RED}✗ Linux AMD64 build failed${NC}"
        exit 1
    fi
    
    # Build for Linux ARM64
    echo -e "${YELLOW}Building for Linux ARM64...${NC}"
    GOOS=linux GOARCH=arm64 go build -ldflags="$LDFLAGS" -o "$BUILD_DIR/${BINARY_NAME}-linux-arm64" $CMD_PATH
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Linux ARM64 build successful${NC}"
    else
        echo -e "${RED}✗ Linux ARM64 build failed${NC}"
        exit 1
    fi
    
    echo ""
    echo -e "${GREEN}Release builds complete!${NC}"
    echo -e "${YELLOW}Binaries located in $BUILD_DIR/${NC}"
    ls -lh $BUILD_DIR/
else
    # Development build (native architecture)
    echo -e "${GREEN}Building for current platform...${NC}"
    go build -ldflags="$LDFLAGS" -o "$BINARY_NAME" $CMD_PATH
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Build successful${NC}"
        echo -e "${YELLOW}Binary: ./$BINARY_NAME${NC}"
        
        # Make executable
        chmod +x $BINARY_NAME
        
        # Show file info
        ls -lh $BINARY_NAME
    else
        echo -e "${RED}✗ Build failed${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}Build complete!${NC}"
