#!/bin/sh

# Icecast2 Docker entrypoint script
set -e

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Logging functions
log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] INFO: $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARN: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

# Check configuration file
check_config() {
    log "Checking Icecast2 configuration file..."
    
    if [ ! -f "/etc/icecast2/icecast.xml" ]; then
        error "Configuration file /etc/icecast2/icecast.xml not found"
        exit 1
    fi
    
    log "Configuration file check passed"
}

# Create necessary directories
create_directories() {
    log "Creating necessary directories..."
    
    mkdir -p /var/log/icecast2
    mkdir -p /var/run/icecast2
    mkdir -p /usr/share/icecast2/web
    mkdir -p /usr/share/icecast2/admin
    
    log "Directories created successfully"
}

# Environment variable substitution
replace_env_vars() {
    log "Processing environment variable substitution..."
    
    # Supported environment variables
    : ${ICECAST_SOURCE_PASSWORD:=hackme}
    : ${ICECAST_RELAY_PASSWORD:=hackme}
    : ${ICECAST_ADMIN_PASSWORD:=hackme}
    : ${ICECAST_ADMIN_USER:=admin}
    : ${ICECAST_HOSTNAME:=localhost}
    : ${ICECAST_LOCATION:=Earth}
    : ${ICECAST_ADMIN_EMAIL:=admin@example.com}
    : ${ICECAST_MAX_CLIENTS:=100}
    : ${ICECAST_MAX_SOURCES:=2}
    : ${ICECAST_PORT:=8000}
    
    # Create temporary configuration file
    sed -e "s/<source-password>.*<\/source-password>/<source-password>$ICECAST_SOURCE_PASSWORD<\/source-password>/g" \
        -e "s/<relay-password>.*<\/relay-password>/<relay-password>$ICECAST_RELAY_PASSWORD<\/relay-password>/g" \
        -e "s/<admin-password>.*<\/admin-password>/<admin-password>$ICECAST_ADMIN_PASSWORD<\/admin-password>/g" \
        -e "s/<admin-user>.*<\/admin-user>/<admin-user>$ICECAST_ADMIN_USER<\/admin-user>/g" \
        -e "s/<hostname>.*<\/hostname>/<hostname>$ICECAST_HOSTNAME<\/hostname>/g" \
        -e "s/<location>.*<\/location>/<location>$ICECAST_LOCATION<\/location>/g" \
        -e "s/<admin>.*<\/admin>/<admin>$ICECAST_ADMIN_EMAIL<\/admin>/g" \
        -e "s/<clients>.*<\/clients>/<clients>$ICECAST_MAX_CLIENTS<\/clients>/g" \
        -e "s/<sources>.*<\/sources>/<sources>$ICECAST_MAX_SOURCES<\/sources>/g" \
        -e "s/<port>.*<\/port>/<port>$ICECAST_PORT<\/port>/g" \
        /etc/icecast2/icecast.xml > /etc/icecast2/icecast.xml.new
    
    # Replace original configuration file
    mv /etc/icecast2/icecast.xml.new /etc/icecast2/icecast.xml
    
    log "Environment variable substitution completed"
}

# Display configuration information
show_config() {
    log "=== Icecast2 Configuration ==="
    log "Hostname:    $ICECAST_HOSTNAME"
    log "Listen port: $ICECAST_PORT"
    log "Admin user:  $ICECAST_ADMIN_USER"
    log "Max clients: $ICECAST_MAX_CLIENTS"
    log "Max sources: $ICECAST_MAX_SOURCES"
    log "Location:    $ICECAST_LOCATION"
    log "Admin email: $ICECAST_ADMIN_EMAIL"
    log "=============================="
}

# Signal handling
handle_signal() {
    log "Received stop signal, shutting down Icecast2..."
    if [ -f "/var/run/icecast2/icecast.pid" ]; then
        kill -TERM $(cat /var/run/icecast2/icecast.pid)
    fi
    exit 0
}

# Set signal handlers
trap handle_signal SIGINT SIGTERM

main() {
    log "Starting Icecast2 Docker container..."

    # Check if SKIP_INIT is set and not empty
    if [ -z "${SKIP_INIT+x}" ]; then
        # Environment variable NOT set - do the initialization
        check_config
        create_directories
        replace_env_vars
        show_config
    else
        warn "SKIP_INIT is set - skipping initialization steps."
        check_config
        create_directories
    fi

    log "Starting Icecast2 server..."

    # If no arguments, use default command
    if [ $# -eq 0 ]; then
        exec icecast -c /etc/icecast2/icecast.xml
    else
        exec "$@"
    fi
}

# Run main function
main "$@"
