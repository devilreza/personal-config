# Development Tools

A collection of essential development tools for various workflows.

## Features

### Protocol Buffers Tools
- **protoc** - Protocol Buffers compiler
- **protoc-gen-go** - Go code generator for protobuf
- **protoc-gen-go-grpc** - Go gRPC code generator
- **grpcurl** - Command-line tool for interacting with gRPC servers
- **buf** - Modern Protocol Buffers build tool with linting and breaking change detection

### IDEs and Editors
- **Cursor AI** - AI-powered code editor
- **Zed** - High-performance, multiplayer code editor
- **DBeaver** - Universal database management tool

### CLI Tools
- **doctl** - DigitalOcean command-line interface
- **jq** - Command-line JSON processor
- **yq** - Command-line YAML processor
- **httpie** - User-friendly HTTP client
- **watch** - Execute commands periodically
- **tree** - Display directory structure

## Installation

```bash
./install.sh
```

This will install all the development tools and configure shell completions where applicable.

## Usage

### Protocol Buffers with Buf

#### Initialize a new buf module
```bash
buf mod init
```

#### Lint protobuf files
```bash
buf lint
```

#### Check for breaking changes
```bash
buf breaking --against '.git#branch=main'
```

#### Generate code
Create `buf.gen.yaml`:
```yaml
version: v1
plugins:
  - plugin: go
    out: gen/go
    opt: paths=source_relative
  - plugin: go-grpc
    out: gen/go
    opt: paths=source_relative
```

Then run:
```bash
buf generate
```

### Traditional protoc usage
```bash
# Generate Go code
protoc --go_out=. --go_opt=paths=source_relative \
       --go-grpc_out=. --go-grpc_opt=paths=source_relative \
       path/to/file.proto
```

### gRPC Testing with grpcurl
```bash
# List services
grpcurl -plaintext localhost:50051 list

# Describe a service
grpcurl -plaintext localhost:50051 describe myapp.MyService

# Call a method
grpcurl -plaintext -d '{"name": "World"}' localhost:50051 myapp.MyService/SayHello
```

### DigitalOcean CLI
```bash
# Authenticate
doctl auth init

# List droplets
doctl compute droplet list

# Create a droplet
doctl compute droplet create my-droplet --size s-1vcpu-1gb --image ubuntu-20-04-x64 --region nyc1
```

### JSON/YAML Processing
```bash
# Pretty print JSON
cat file.json | jq '.'

# Extract specific field
cat file.json | jq '.users[0].name'

# Convert YAML to JSON
yq eval -o=json file.yaml

# Query YAML
yq eval '.services.web.image' docker-compose.yml
```

### HTTP Testing
```bash
# GET request
http GET httpbin.org/get

# POST JSON
http POST httpbin.org/post name=John email=john@example.com

# Custom headers
http GET httpbin.org/headers Authorization:"Bearer token"
```

## Configuration

### Buf Configuration
Create `buf.yaml` in your project root:
```yaml
version: v1
breaking:
  use:
    - FILE
lint:
  use:
    - DEFAULT
```

### VS Code Installation (Optional)
If you want to install Visual Studio Code:
```bash
brew install --cask visual-studio-code
```

## Tips

1. Use `buf` instead of raw `protoc` for better developer experience
2. Configure your IDE to use `buf lint` for real-time protobuf validation
3. Set up pre-commit hooks to run `buf lint` and `buf breaking`
4. Use `grpcurl` for quick gRPC service testing without writing client code
5. Combine `jq` with other commands for powerful JSON manipulation in scripts
