# REWAMP Makefile
# Modern build system for cross-platform Go builds

# Variables
BINARY_NAME=rewamp
VERSION?=$(shell git describe --tags --always --dirty)
BUILD_TIME=$(shell date +%FT%T%z)
LDFLAGS=-ldflags="-H windowsgui -s -w -X main.version=${VERSION} -X main.buildTime=${BUILD_TIME}"

# Default target
.PHONY: all
all: clean test build

# Build for current platform
.PHONY: build
build:
	go build ${LDFLAGS} -o ${BINARY_NAME}.exe .

# Build for Windows (main target)
.PHONY: build-windows
build-windows:
	GOOS=windows GOARCH=amd64 go build ${LDFLAGS} -o ${BINARY_NAME}-windows-amd64.exe .
	GOOS=windows GOARCH=386 go build ${LDFLAGS} -o ${BINARY_NAME}-windows-386.exe .

# Build for all supported platforms
.PHONY: build-all
build-all: build-windows

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
	rm -f ${BINARY_NAME}*.exe
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
	cp README.md dist/
	cp LICENSE dist/

# Help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build          - Build for current platform"
	@echo "  build-windows  - Build for Windows (amd64 and 386)"
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