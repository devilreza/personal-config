# Go Development Environment

Go programming language with linting and mocking tools.

## Features

- **Go**: Latest stable version via Homebrew
- **golangci-lint**: Fast Go linters aggregator
- **mockery**: Mock generation tool for Go interfaces
- **Environment**: GOPATH and PATH configuration

## Installation

```bash
./install.sh
```

This will:
1. Install Go via Homebrew
2. Install golangci-lint for code quality
3. Install mockery for test mocks
4. Configure Go environment variables in ~/.zshrc

## Environment Variables

The installer adds to ~/.zshrc:
```bash
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

## Usage

### Go Commands
- `go run main.go` - Run Go program
- `go build` - Build Go binary
- `go test ./...` - Run tests
- `go mod init` - Initialize Go module
- `go get <package>` - Install Go package

### Linting
```bash
# Run linters on current directory
golangci-lint run

# Run specific linters
golangci-lint run --enable-all

# Auto-fix issues
golangci-lint run --fix
```

### Mocking
```bash
# Generate mocks for an interface
mockery --name=MyInterface --dir=./pkg/mypackage --output=./mocks

# Generate all mocks in a directory
mockery --all --dir=./internal --output=./mocks
```

## Configuration

### golangci-lint
Create `.golangci.yml` in your project:
```yaml
linters:
  enable:
    - gofmt
    - golint
    - govet
    - errcheck
    - staticcheck
    - gosimple
    - ineffassign
```

### mockery
Create `.mockery.yaml` in your project:
```yaml
with-expecter: true
dir: .
recursive: true
all: true
outpkg: mocks
output: ./mocks
```
