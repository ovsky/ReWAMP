# ReWAMP Makefile
# Modern build system for cross-platform Go builds

# Variables
BINARY_NAME=rewamp
CMD_PATH=./cmd/rewamp
VERSION?=$(shell git describe --tags --always --dirty)
BUILD_TIME=$(shell date +%FT%T%z)

# Platform-specific flags
WINDOWS_LDFLAGS=-ldflags="-H windowsgui -s -w -X main.version=${VERSION} -X main.buildTime=${BUILD_TIME}"
LINUX_LDFLAGS=-ldflags="-s -w -X main.version=${VERSION} -X main.buildTime=${BUILD_TIME}"

# Detect OS for smart build
ifeq ($(OS),Windows_NT)
	DETECTED_OS := Windows
	EXT := .exe
else
	DETECTED_OS := $(shell uname -s)
	EXT :=
endif

# Default target
.PHONY: all
all: clean test build

# Build for current platform
.PHONY: build
build:
ifeq ($(DETECTED_OS),Windows)
	go build ${WINDOWS_LDFLAGS} -o ${BINARY_NAME}.exe ${CMD_PATH}
else
	go build ${LINUX_LDFLAGS} -o ${BINARY_NAME} ${CMD_PATH}
endif

# Build for Windows
.PHONY: build-windows
build-windows:
	GOOS=windows GOARCH=amd64 go build ${WINDOWS_LDFLAGS} -o ${BINARY_NAME}-windows-amd64.exe ${CMD_PATH}
	GOOS=windows GOARCH=386 go build ${WINDOWS_LDFLAGS} -o ${BINARY_NAME}-windows-386.exe ${CMD_PATH}

# Build for Linux
.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 go build ${LINUX_LDFLAGS} -o ${BINARY_NAME}-linux-amd64 ${CMD_PATH}
	GOOS=linux GOARCH=arm64 go build ${LINUX_LDFLAGS} -o ${BINARY_NAME}-linux-arm64 ${CMD_PATH}

# Build for all supported platforms
.PHONY: build-all
build-all: build-windows build-linux

# Run tests
.PHONY: test
test:
	go test -v ./...

# Run tests with coverage
.PHONY: test-coverage
test-coverage:
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out -o coverage.html

# Format code
.PHONY: fmt
fmt:
	go fmt ./...

# Lint code
.PHONY: lint
lint:
	golangci-lint run

# Vet code
.PHONY: vet
vet:
	go vet ./...

# Tidy dependencies
.PHONY: tidy
tidy:
	go mod tidy

# Update dependencies
.PHONY: update
update:
	go get -u ./...
	go mod tidy

# Clean build artifacts
.PHONY: clean
clean:
	go clean
	rm -f ${BINARY_NAME}*.exe ${BINARY_NAME} ${BINARY_NAME}-*
	rm -f coverage.out coverage.html

# Install dependencies for development
.PHONY: deps
deps:
	go mod download
	go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest

# Run the application
.PHONY: run
run:
	go run .

# Generate release
.PHONY: release
release: clean test build-all
	mkdir -p dist
	cp ${BINARY_NAME}-windows-amd64.exe dist/
	cp ${BINARY_NAME}-windows-386.exe dist/
	cp ${BINARY_NAME}-linux-amd64 dist/
	cp ${BINARY_NAME}-linux-arm64 dist/
	cp README.md dist/
	cp LICENSE dist/

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build          - Build for current platform"
	@echo "  build-windows  - Build for Windows (amd64 and 386)"
	@echo "  build-linux    - Build for Linux (amd64 and arm64)"
	@echo "  build-all      - Build for all supported platforms"
	@echo "  test           - Run tests"
	@echo "  test-coverage  - Run tests with coverage report"
	@echo "  fmt            - Format code"
	@echo "  lint           - Lint code"
	@echo "  vet            - Vet code"
	@echo "  tidy           - Tidy dependencies"
	@echo "  update         - Update dependencies"
	@echo "  clean          - Clean build artifacts"
	@echo "  deps           - Install development dependencies"
	@echo "  run            - Run the application"
	@echo "  release        - Generate release artifacts"
	@echo "  help           - Show this help"