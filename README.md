# Icecast2 Alpine Docker

A lightweight, production-ready Icecast2 streaming server built on Alpine Linux Docker image. Perfect for audio streaming, internet radio, and live broadcasting applications.

## 🚀 Features

- **Lightweight**: Based on Alpine Linux for minimal resource usage
- **Secure**: Non-root user execution with proper permission handling
- **Configurable**: Environment variable support for easy configuration
- **Production-ready**: Health checks, logging, and signal handling
- **Easy deployment**: Docker Compose support with volume management

## 🏁 Quick Start

### Using Docker Run

```bash
# Pull and run the container
docker run -d \
  --name icecast2-server \
  -p 8000:8000 \
  -e ICECAST_SOURCE_PASSWORD=your_source_password \
  -e ICECAST_ADMIN_PASSWORD=your_admin_password \
  -v $(pwd)/logs:/var/log/icecast2 \
  liuzhen932/app-icecast:latest
```

Access the admin interface at `http://localhost:8000/admin/`

## ⚙️ Configuration

### Default Access Information

| Service | URL | Username | Password |
|---------|-----|----------|----------|
| Admin Interface | `http://localhost:8000/admin/` | admin | hackme |
| Audio Stream | `http://localhost:8000/stream` | source | hackme |
| Status Page | `http://localhost:8000/` | - | - |

> ⚠️ **Security Warning**: Change default passwords in production environments!

### File Structure

```
.
├── Dockerfile              # Docker image definition
├── docker-compose.yml      # Docker Compose configuration
├── icecast.xml             # Icecast2 configuration template
├── entrypoint.sh           # Container startup script
└── README.md               # This file
```

## 🔧 Environment Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `ICECAST_SOURCE_PASSWORD` | Password for source connections | `hackme` |
| `ICECAST_RELAY_PASSWORD` | Password for relay connections | `hackme` |
| `ICECAST_ADMIN_PASSWORD` | Admin interface password | `hackme` |
| `ICECAST_ADMIN_USER` | Admin username | `admin` |
| `ICECAST_HOSTNAME` | Server hostname | `localhost` |
| `ICECAST_LOCATION` | Server location | `Earth` |
| `ICECAST_ADMIN_EMAIL` | Admin email address | `admin@example.com` |
| `ICECAST_MAX_CLIENTS` | Maximum concurrent clients | `100` |
| `ICECAST_MAX_SOURCES` | Maximum concurrent sources | `2` |
| `ICECAST_PORT` | Server listening port | `8000` |

### Example Configuration

```yaml
environment:
  - ICECAST_SOURCE_PASSWORD=super_secret_source_password
  - ICECAST_ADMIN_PASSWORD=super_secret_admin_password
  - ICECAST_ADMIN_USER=myadmin
  - ICECAST_HOSTNAME=myradio.example.com
  - ICECAST_LOCATION=New York, USA
  - ICECAST_ADMIN_EMAIL=admin@myradio.example.com
  - ICECAST_MAX_CLIENTS=500
  - ICECAST_MAX_SOURCES=10
```

## 🚀 Deployment

### Production Docker Compose

```yaml
version: '3.8'

services:
  icecast2:
    build: .
    container_name: icecast2-production
    restart: unless-stopped
    ports:
      - "8000:8000"
    environment:
      - ICECAST_SOURCE_PASSWORD=${SOURCE_PASSWORD}
      - ICECAST_ADMIN_PASSWORD=${ADMIN_PASSWORD}
      - ICECAST_HOSTNAME=${HOSTNAME}
      - ICECAST_LOCATION=${LOCATION}
      - ICECAST_ADMIN_EMAIL=${ADMIN_EMAIL}
      - ICECAST_MAX_CLIENTS=1000
      - ICECAST_MAX_SOURCES=20
    volumes:
      - ./logs:/var/log/icecast2
      - ./web:/usr/share/icecast2/web
    networks:
      - icecast-network
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8000/admin/stats.xml"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s

networks:
  icecast-network:
    driver: bridge
```

### Environment File (.env)

```env
# Source and admin passwords
SOURCE_PASSWORD=your_secure_source_password
ADMIN_PASSWORD=your_secure_admin_password

# Server information
HOSTNAME=radio.yourdomain.com
LOCATION=Your City, Your Country
ADMIN_EMAIL=admin@yourdomain.com
```

## 📡 Usage Examples

### Streaming with FFmpeg

```bash
# Stream MP3 file
ffmpeg -re -i input.mp3 \
  -acodec libmp3lame -ab 128k -ac 2 \
  -content_type audio/mpeg -f mp3 \
  icecast://source:your_source_password@localhost:8000/stream

# Stream live microphone input
ffmpeg -f alsa -i default \
  -acodec libmp3lame -ab 128k -ac 2 \
  -content_type audio/mpeg -f mp3 \
  icecast://source:your_source_password@localhost:8000/live

# Stream from internet radio
ffmpeg -i http://example.com/stream.mp3 \
  -acodec copy -f mp3 \
  icecast://source:your_source_password@localhost:8000/relay
```

### Streaming with VLC

1. Open VLC Media Player
2. Go to **Media** → **Stream**
3. Add your audio file or capture device
4. Click **Stream**
5. Choose **HTTP** as destination
6. Set path to `/stream`
7. Set server address to `localhost:8000`
8. Enable authentication with username `source` and your password

### Listening to Streams

```bash
# Test stream availability
curl -I http://localhost:8000/stream

# Listen with VLC
vlc http://localhost:8000/stream

# Listen with mpv
mpv http://localhost:8000/stream

# Listen with ffplay
ffplay http://localhost:8000/stream
```

### API Access

```bash
# Get server statistics
curl -u admin:your_admin_password \
  http://localhost:8000/admin/stats.xml

# Get listener statistics
curl -u admin:your_admin_password \
  http://localhost:8000/admin/listclients.xml

# Kill a source
curl -u admin:your_admin_password \
  -X POST http://localhost:8000/admin/killsource.xml?mount=/stream
```

## 🔒 Security

### Production Security Checklist

- [ ] Change all default passwords
- [ ] Use strong, unique passwords
- [ ] Configure firewall rules
- [ ] Enable HTTPS with reverse proxy
- [ ] Restrict admin access by IP
- [ ] Regular security updates
- [ ] Monitor access logs
- [ ] Use non-standard ports if needed

### Reverse Proxy with Nginx

```nginx
server {
    listen 80;
    server_name radio.yourdomain.com;
    
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### SSL/TLS Configuration

```nginx
server {
    listen 443 ssl http2;
    server_name radio.yourdomain.com;
    
    ssl_certificate /path/to/certificate.crt;
    ssl_certificate_key /path/to/private.key;
    
    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

## 🐛 Troubleshooting

### Common Issues

#### Container Won't Start

```bash
# Check container logs
docker logs icecast2-server

# Check configuration
docker exec icecast2-server cat /etc/icecast2/icecast.xml

# Verify permissions
docker exec icecast2-server ls -la /var/log/icecast2
```

#### Port Already in Use

```bash
# Find process using port 8000
sudo lsof -i :8000

# Kill process if needed
sudo kill -9 <PID>

# Or use different port
docker run -p 8080:8000 
```

#### Cannot Connect to Stream

```bash
# Test network connectivity
curl -I http://localhost:8000/

# Check firewall
sudo ufw status

# Verify source password
grep source-password /etc/icecast2/icecast.xml
```

#### High CPU Usage

```bash
# Check active connections
curl -u admin:password http://localhost:8000/admin/stats.xml

# Monitor resource usage
docker stats icecast2-server

# Check for runaway processes
docker exec icecast2-server top
```

### Debug Mode

```bash
# Run with debug logging
docker run -it --rm \
  -e ICECAST_LOG_LEVEL=4 \
  -p 8000:8000 \
  
```

### Health Check

```bash
# Check container health
docker inspect icecast2-server | grep -A 5 Health

# Manual health check
curl -f http://localhost:8000/admin/stats.xml
```

## 🔧 Advanced Configuration

### Custom Configuration File

```bash
# Mount custom configuration
docker run -d \
  -v $(pwd)/custom-icecast.xml:/etc/icecast2/icecast.xml:ro \
  -p 8000:8000 \
  
```

### Multiple Mount Points

```xml
<!-- Add to icecast.xml -->
<mount type="normal">
    <mount-name>/jazz</mount-name>
    <username>source</username>
    <password>jazz_password</password>
    <stream-name>Jazz Radio</stream-name>
    <stream-description>24/7 Jazz Music</stream-description>
    <genre>jazz</genre>
</mount>

<mount type="normal">
    <mount-name>/rock</mount-name>
    <username>source</username>
    <password>rock_password</password>
    <stream-name>Rock Radio</stream-name>
    <stream-description>Classic Rock Hits</stream-description>
    <genre>rock</genre>
</mount>
```

### Relay Configuration

```xml
<!-- Add to icecast.xml -->
<relay>
    <server>upstream.example.com</server>
    <port>8000</port>
    <mount>/upstream</mount>
    <local-mount>/relay</local-mount>
    <username>relay</username>
    <password>relay_password</password>
    <relay-shoutcast-metadata>1</relay-shoutcast-metadata>
</relay>
```

## 📊 Monitoring

### Prometheus Metrics

```bash
# Add monitoring container
docker run -d \
  --name icecast-exporter \
  --link icecast2-server:icecast \
  -p 9150:9150 \
  icecast-exporter:latest
```

### Log Analysis

```bash
# Monitor access logs
docker exec icecast2-server tail -f /var/log/icecast2/access.log

# Monitor error logs
docker exec icecast2-server tail -f /var/log/icecast2/error.log

# Count unique listeners
docker exec icecast2-server \
  awk '{print $1}' /var/log/icecast2/access.log | sort | uniq -c
```

### Reporting Issues

When reporting issues, please include:

- Docker version
- Operating system
- Error messages
- Configuration files
- Steps to reproduce

## 📄 License

This project is licensed under the _GNU General Public License v3.0_ License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Icecast](https://icecast.org/) - The streaming server
- [Alpine Linux](https://alpinelinux.org/) - The base image
- [Docker](https://docker.com/) - Containerization platform

## 📞 Support

- 🐛 Issues: [GitHub Issues](https://github.com/liuzhen9320/app-icecast/issues)

---

**Made with ❤️ by [liuzhen932](https://github.com/liuzhen9320)**
