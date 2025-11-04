# Contributing to ReWAMP

Thank you for your interest in contributing to ReWAMP! This document provides guidelines and information for contributors.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment for everyone.

## Getting Started

### Prerequisites

- Go 1.24 or later
- Git
- Windows (for testing system tray functionality)

### Setting up the Development Environment

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/yourusername/ReWAMP.git
   cd ReWAMP
   ```
3. Add the original repository as upstream:
   ```bash
   git remote add upstream https://github.com/ovsky/ReWAMP.git
   ```
1. Install dependencies:
   ```bash
   go mod download
   ```

## Development Workflow

### Making Changes

1. Create a new branch for your feature/fix:
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. Make your changes following the coding standards

3. Test your changes:
   ```bash
   go test ./...
   go run .
   ```

4. Format and lint your code:
   ```bash
   go fmt ./...
   go vet ./...
   ```

### Commit Guidelines

- Use clear, descriptive commit messages
- Follow the conventional commit format:
  - `feat:` for new features
  - `fix:` for bug fixes
  - `docs:` for documentation changes
  - `refactor:` for code refactoring
  - `test:` for adding tests
  - `ci:` for CI/CD changes

Example:
```
feat: add version information to system tray menu

- Display current version in menu
- Add build time information
- Link to releases page
```

### Pull Request Process

1. Update your branch with the latest upstream changes:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. Push your changes to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

3. Create a Pull Request with:
   - Clear title and description
   - Reference any related issues
   - Screenshots for UI changes
   - Test results

## Coding Standards

### Go Style Guide

- Follow the [Go Code Review Comments](https://github.com/golang/go/wiki/CodeReviewComments)
- Use `gofmt` for formatting
- Use meaningful variable and function names
- Add comments for exported functions and types
- Keep functions small and focused

### Project Structure

```
ReWAMP/
├── main.go           # Main application logic
├── windows.go        # Windows-specific functionality
├── main_test.go      # Tests
├── icon/             # Icon resources
├── .github/          # GitHub workflows
└── docs/             # Documentation
```

### Error Handling

- Always handle errors appropriately
- Use meaningful error messages
- Prefer specific error types when useful

### Testing

- Write tests for new functionality
- Maintain or improve test coverage
- Use table-driven tests where appropriate
- Test both success and failure cases

## Documentation

- Update README.md for user-facing changes
- Add inline comments for complex logic
- Update this CONTRIBUTING.md if the process changes

## Reporting Issues

When reporting bugs, please include:

- Operating system and version
- Go version
- Steps to reproduce
- Expected vs actual behavior
- Relevant log output
- Screenshots if applicable

## Feature Requests

Before submitting a feature request:

1. Check existing issues to avoid duplicates
2. Clearly describe the problem and proposed solution
3. Consider the scope and complexity
4. Be open to alternative approaches

## Release Process

Releases are managed by maintainers and follow semantic versioning:

- `MAJOR.MINOR.PATCH`
- Breaking changes increment MAJOR
- New features increment MINOR
- Bug fixes increment PATCH

## Getting Help

- Check the [README.md](README.md) for basic information
- Look through existing [issues](https://github.com/ovsky/ReWAMP/issues)
- Create a new issue for questions or problems

## License

By contributing to ReWAMP, you agree that your contributions will be licensed under the MIT License.

## Recognition

Contributors are recognized in:
- Git commit history
- Release notes for significant contributions
- Potential mention in README.md

Thank you for contributing to ReWAMP!