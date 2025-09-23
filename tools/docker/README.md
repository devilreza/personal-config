# Docker and Docker Desktop

Container platform for developing, shipping, and running applications.

## Features

- **Docker Desktop**: Includes Docker Engine and Docker Compose
- **Docker CLI**: Command-line interface for container management
- **Docker Compose**: Multi-container application orchestration
- **Shell Completion**: Zsh completion for Docker commands

## Installation

```bash
./install.sh
```

This will:
1. Install Docker Desktop via Homebrew Cask
2. Configure Docker shell completion
3. Create Docker config directory

## Post-Installation

1. Launch Docker Desktop from Applications
2. Sign in to Docker Hub (optional)
3. Configure resources in Docker Desktop preferences

## Usage

### Docker Commands
```bash
# Container management
docker run <image>          # Run a container
docker ps                   # List running containers
docker ps -a               # List all containers
docker stop <container>     # Stop a container
docker rm <container>       # Remove a container

# Image management
docker images              # List images
docker pull <image>        # Download an image
docker build -t <tag> .    # Build an image
docker rmi <image>         # Remove an image

# System management
docker system prune        # Clean up unused resources
docker system df           # Show disk usage
docker info               # Display system information
```

### Docker Compose Commands
```bash
# Service management
docker compose up          # Start services
docker compose up -d       # Start in detached mode
docker compose down        # Stop and remove services
docker compose ps          # List services
docker compose logs        # View service logs
docker compose logs -f     # Follow logs

# Development workflow
docker compose build       # Build services
docker compose restart     # Restart services
docker compose exec <service> <command>  # Execute command in service
```

## Configuration

### Docker Desktop Settings
- **Resources**: CPU, Memory, Disk allocation
- **File Sharing**: Configure shared directories
- **Network**: DNS and proxy settings
- **Kubernetes**: Enable/disable Kubernetes

### Docker Compose Example
Create `docker-compose.yml`:
```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    volumes:
      - .:/app
    depends_on:
      - db
    
  db:
    image: postgres:15
    environment:
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## Tips

1. Use `.dockerignore` to exclude files from build context
2. Multi-stage builds for smaller production images
3. Use Docker volumes for persistent data
4. Enable BuildKit for faster builds: `export DOCKER_BUILDKIT=1`
5. Use Docker Compose for local development environments
