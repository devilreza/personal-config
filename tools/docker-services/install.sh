#!/bin/bash

# Docker Services Installation Script
# Sets up dockerized Redis, PostgreSQL, and MySQL

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
source "$ROOT_DIR/scripts/common.sh"

print_header "Docker Services Setup"

# Check if Docker is running
print_info "Checking Docker status..."
if ! docker info &> /dev/null; then
    print_error "Docker is not running. Please start Docker Desktop first."
    print_info "You can install Docker by running: ./install-docker.sh"
    exit 1
fi
print_success "Docker is running"

# Create docker services directory
SERVICES_DIR="$HOME/docker-services"
ensure_dir "$SERVICES_DIR"
ensure_dir "$SERVICES_DIR/data"
ensure_dir "$SERVICES_DIR/data/redis"
ensure_dir "$SERVICES_DIR/data/postgres"
ensure_dir "$SERVICES_DIR/data/mysql"

# Create docker-compose.yml for services
print_info "Creating docker-compose.yml for services..."
cat > "$SERVICES_DIR/docker-compose.yml" << 'EOF'
version: '3.8'

services:
  redis:
    image: redis:7-alpine
    container_name: local-redis
    ports:
      - "6379:6379"
    volumes:
      - ./data/redis:/data
    command: redis-server --appendonly yes
    restart: unless-stopped
    networks:
      - local-services

  postgres:
    image: postgres:15-alpine
    container_name: local-postgres
    ports:
      - "5432:5432"
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_DB: postgres
    volumes:
      - ./data/postgres:/var/lib/postgresql/data
    restart: unless-stopped
    networks:
      - local-services

  mysql:
    image: mysql:8.0
    container_name: local-mysql
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: mysql
      MYSQL_DATABASE: mysql
      MYSQL_USER: mysql
      MYSQL_PASSWORD: mysql
    volumes:
      - ./data/mysql:/var/lib/mysql
    restart: unless-stopped
    networks:
      - local-services

  adminer:
    image: adminer:latest
    container_name: local-adminer
    ports:
      - "8080:8080"
    environment:
      ADMINER_DEFAULT_SERVER: postgres
    restart: unless-stopped
    networks:
      - local-services
    depends_on:
      - postgres
      - mysql

  redis-commander:
    image: rediscommander/redis-commander:latest
    container_name: local-redis-commander
    ports:
      - "8081:8081"
    environment:
      REDIS_HOSTS: local:redis:6379
    restart: unless-stopped
    networks:
      - local-services
    depends_on:
      - redis

networks:
  local-services:
    driver: bridge
EOF

print_success "docker-compose.yml created"

# Create convenience scripts
print_info "Creating convenience scripts..."

# Start script
cat > "$SERVICES_DIR/start.sh" << 'EOF'
#!/bin/bash
echo "Starting Docker services..."
docker compose up -d
echo ""
echo "Services started:"
echo "  Redis:           localhost:6379"
echo "  PostgreSQL:      localhost:5432 (user: postgres, pass: postgres)"
echo "  MySQL:           localhost:3306 (user: mysql, pass: mysql)"
echo "  Adminer:         http://localhost:8080 (Database UI)"
echo "  Redis Commander: http://localhost:8081 (Redis UI)"
EOF
chmod +x "$SERVICES_DIR/start.sh"

# Stop script
cat > "$SERVICES_DIR/stop.sh" << 'EOF'
#!/bin/bash
echo "Stopping Docker services..."
docker compose down
echo "Services stopped."
EOF
chmod +x "$SERVICES_DIR/stop.sh"

# Status script
cat > "$SERVICES_DIR/status.sh" << 'EOF'
#!/bin/bash
echo "Docker services status:"
docker compose ps
EOF
chmod +x "$SERVICES_DIR/status.sh"

# Logs script
cat > "$SERVICES_DIR/logs.sh" << 'EOF'
#!/bin/bash
SERVICE=$1
if [ -z "$SERVICE" ]; then
    docker compose logs -f
else
    docker compose logs -f $SERVICE
fi
EOF
chmod +x "$SERVICES_DIR/logs.sh"

# Clean script
cat > "$SERVICES_DIR/clean.sh" << 'EOF'
#!/bin/bash
echo "WARNING: This will remove all data!"
read -p "Are you sure? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    docker compose down -v
    rm -rf ./data/*
    echo "All data removed."
else
    echo "Cancelled."
fi
EOF
chmod +x "$SERVICES_DIR/clean.sh"

# Create README
cat > "$SERVICES_DIR/README.md" << 'EOF'
# Docker Services

This directory contains dockerized versions of common development services.

## Services

- **Redis**: In-memory data store (port 6379)
- **PostgreSQL**: Relational database (port 5432)
- **MySQL**: Relational database (port 3306)
- **Adminer**: Database management UI (port 8080)
- **Redis Commander**: Redis management UI (port 8081)

## Usage

### Start all services
```bash
./start.sh
```

### Stop all services
```bash
./stop.sh
```

### Check status
```bash
./status.sh
```

### View logs
```bash
./logs.sh          # All services
./logs.sh redis    # Specific service
```

### Clean all data (WARNING: destructive)
```bash
./clean.sh
```

## Connection Details

### Redis
- Host: localhost
- Port: 6379
- No authentication by default

### PostgreSQL
- Host: localhost
- Port: 5432
- Username: postgres
- Password: postgres
- Database: postgres

### MySQL
- Host: localhost
- Port: 3306
- Username: mysql (or root)
- Password: mysql
- Database: mysql

### Web UIs
- Adminer: http://localhost:8080
- Redis Commander: http://localhost:8081

## Data Persistence

All data is stored in the `./data` directory:
- `./data/redis`: Redis data
- `./data/postgres`: PostgreSQL data
- `./data/mysql`: MySQL data

## Customization

Edit `docker-compose.yml` to:
- Change ports
- Modify credentials
- Add more services
- Adjust resource limits
EOF

print_success "Convenience scripts created"

# Install database CLI tools
print_info "Installing database CLI tools..."

# PostgreSQL client
if ! command -v psql &> /dev/null; then
    brew install postgresql@15
    print_success "PostgreSQL client installed"
else
    print_info "PostgreSQL client is already installed"
fi

# MySQL client
if ! command -v mysql &> /dev/null; then
    brew install mysql-client
    print_success "MySQL client installed"
    
    # Add MySQL client to PATH
    if ! grep -q 'mysql-client' ~/.zshrc; then
        echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~/.zshrc
    fi
else
    print_info "MySQL client is already installed"
fi

# Redis CLI
if ! command -v redis-cli &> /dev/null; then
    brew install redis
    print_success "Redis CLI installed"
else
    print_info "Redis CLI is already installed"
fi

# Create aliases for easy database access
print_info "Setting up database aliases..."
if ! grep -q 'Database aliases' ~/.zshrc; then
    cat >> ~/.zshrc << 'EOF'

# Database aliases
alias psql-local='psql -h localhost -U postgres -d postgres'
alias mysql-local='mysql -h 127.0.0.1 -u mysql -pmysql mysql'
alias redis-local='redis-cli'

# Docker services aliases
alias ds-start='cd ~/docker-services && ./start.sh'
alias ds-stop='cd ~/docker-services && ./stop.sh'
alias ds-status='cd ~/docker-services && ./status.sh'
alias ds-logs='cd ~/docker-services && ./logs.sh'
EOF
    print_success "Database aliases added to ~/.zshrc"
else
    print_info "Database aliases already configured"
fi

print_footer "Docker services setup completed!"
print_info "Services location: $SERVICES_DIR"
print_info ""
print_info "Quick start:"
print_info "  cd ~/docker-services"
print_info "  ./start.sh              # Start all services"
print_info ""
print_info "Or use aliases (after restarting terminal):"
print_info "  ds-start               # Start services"
print_info "  ds-stop                # Stop services"
print_info "  ds-status              # Check status"
print_info "  psql-local             # Connect to PostgreSQL"
print_info "  mysql-local            # Connect to MySQL"
print_info "  redis-local            # Connect to Redis"
print_info ""
print_info "Web UIs:"
print_info "  Adminer:         http://localhost:8080"
print_info "  Redis Commander: http://localhost:8081"
