<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/icestats">
    <html>
      <head>
        <title>Icecast Streaming Media Server</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 20px;
    color: #333;
}

.container {
    max-width: 1200px;
    margin: 0 auto;
}

.header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    text-align: center;
}

.header h1 {
    font-size: 2.5em;
    color: #2c3e50;
    margin-bottom: 10px;
    font-weight: 300;
}

.header h2 {
    font-size: 1.2em;
    color: #7f8c8d;
    font-weight: 400;
}

.nav-menu {
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 30px;
    box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
    display: flex;
    justify-content: center;
    gap: 20px;
    flex-wrap: wrap;
}

.nav-menu a {
    color: #2c3e50;
    text-decoration: none;
    padding: 12px 24px;
    border-radius: 8px;
    transition: all 0.3s ease;
    font-weight: 500;
    background: rgba(103, 126, 234, 0.1);
}

.nav-menu a:hover {
    background: rgba(103, 126, 234, 0.2);
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.3);
}

.nav-menu a.active {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
}

.stream-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.stream-card:hover {
    transform: translateY(-5px);
}

.stream-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
    flex-wrap: wrap;
    gap: 15px;
}

.stream-title {
    font-size: 1.8em;
    color: #2c3e50;
    font-weight: 600;
}

.stream-links {
    display: flex;
    gap: 10px;
}

.stream-links a {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 0.9em;
    font-weight: 500;
    transition: all 0.3s ease;
}

.stream-links a:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
}

.stream-info {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}

.info-section {
    background: rgba(103, 126, 234, 0.05);
    border-radius: 10px;
    padding: 20px;
}

.info-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 0;
    border-bottom: 1px solid rgba(103, 126, 234, 0.1);
}

.info-row:last-child {
    border-bottom: none;
}

.info-label {
    font-weight: 600;
    color: #2c3e50;
    min-width: 140px;
}

.info-value {
    color: #34495e;
    font-weight: 500;
    text-align: right;
}

.info-value a {
    color: #667eea;
    text-decoration: none;
}

.info-value a:hover {
    text-decoration: underline;
}

.current-song {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    border-radius: 10px;
    padding: 20px;
    margin-top: 20px;
    text-align: center;
}

.current-song h3 {
    font-size: 1.1em;
    margin-bottom: 10px;
    opacity: 0.9;
}

.current-song .song-title {
    font-size: 1.3em;
    font-weight: 600;
}

.not-connected {
    background: rgba(231, 76, 60, 0.1);
    border: 2px solid rgba(231, 76, 60, 0.3);
    color: #e74c3c;
    padding: 20px;
    border-radius: 10px;
    text-align: center;
    font-weight: 600;
    margin-bottom: 20px;
}

.footer {
    text-align: center;
    margin-top: 50px;
    padding: 20px;
    color: rgba(255, 255, 255, 0.8);
}

.footer a {
    color: rgba(255, 255, 255, 0.9);
    text-decoration: none;
    font-weight: 500;
}

.footer a:hover {
    text-decoration: underline;
}

.listeners-badge {
    background: linear-gradient(45deg, #2ecc71, #27ae60);
    color: white;
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 0.9em;
    font-weight: 600;
    display: inline-block;
}

.peak-badge {
    background: linear-gradient(45deg, #f39c12, #e67e22);
    color: white;
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 0.9em;
    font-weight: 600;
    display: inline-block;
}

@media (max-width: 768px) {
    .container {
        padding: 10px;
    }
    
    .header {
        padding: 20px;
    }
    
    .header h1 {
        font-size: 2em;
    }
    
    .nav-menu {
        flex-direction: column;
        text-align: center;
    }
    
    .stream-header {
        flex-direction: column;
        text-align: center;
    }
    
    .stream-info {
        grid-template-columns: 1fr;
    }
    
    .info-row {
        flex-direction: column;
        text-align: center;
        gap: 5px;
    }
    
    .info-value {
        text-align: center;
    }
}
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>🎵 Icecast Streaming Server</h1>
            <h2>Live Stream Status Dashboard</h2>
          </div>
          <div class="nav-menu">
            <a href="admin/">🔧 Administration</a>
            <a href="status.xsl" class="active">📊 Server Status</a>
            <a href="server_version.xsl">ℹ️ Version</a>
          </div>
          <xsl:for-each select="source">
            <xsl:choose>
              <xsl:when test="listeners">
                <div class="stream-card">
                  <div class="stream-header">
                    <h3 class="stream-title">📡 <xsl:value-of select="@mount"/></h3>
                    <div class="stream-links">
                      <xsl:choose>
                        <xsl:when test="authenticator">
                          <a href="/auth.xsl">🔐 Login</a>
                        </xsl:when>
                        <xsl:otherwise>
                          <a href="{@mount}.m3u">🎵 M3U</a>
                          <a href="{@mount}.xspf">📀 XSPF</a>
                          <a href="{@mount}.vclt">🎬 VCLT</a>
                        </xsl:otherwise>
                      </xsl:choose>
                    </div>
                  </div>
                  <div class="stream-info">
                    <div class="info-section">
                      <xsl:if test="server_name">
                        <div class="info-row">
                          <span class="info-label">🎙️ Stream Title:</span>
                          <span class="info-value">
                            <xsl:value-of select="server_name"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="server_description">
                        <div class="info-row">
                          <span class="info-label">📝 Description:</span>
                          <span class="info-value">
                            <xsl:value-of select="server_description"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="server_type">
                        <div class="info-row">
                          <span class="info-label">🎵 Content Type:</span>
                          <span class="info-value">
                            <xsl:value-of select="server_type"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="genre">
                        <div class="info-row">
                          <span class="info-label">🎨 Genre:</span>
                          <span class="info-value">
                            <xsl:value-of select="genre"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="server_url">
                        <div class="info-row">
                          <span class="info-label">🌐 Stream URL:</span>
                          <span class="info-value">
                            <a target="_blank" href="{server_url}">
                              <xsl:value-of select="server_url"/>
                            </a>
                          </span>
                        </div>
                      </xsl:if>
                    </div>
                    <div class="info-section">
                      <xsl:if test="stream_start">
                        <div class="info-row">
                          <span class="info-label">⏰ Started:</span>
                          <span class="info-value">
                            <xsl:value-of select="stream_start"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="bitrate">
                        <div class="info-row">
                          <span class="info-label">📊 Bitrate:</span>
                          <span class="info-value"><xsl:value-of select="bitrate"/> kbps</span>
                        </div>
                      </xsl:if>
                      <xsl:if test="quality">
                        <div class="info-row">
                          <span class="info-label">🎯 Audio Quality:</span>
                          <span class="info-value">
                            <xsl:value-of select="quality"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="video_quality">
                        <div class="info-row">
                          <span class="info-label">📹 Video Quality:</span>
                          <span class="info-value">
                            <xsl:value-of select="video_quality"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="frame_size">
                        <div class="info-row">
                          <span class="info-label">🖼️ Frame Size:</span>
                          <span class="info-value">
                            <xsl:value-of select="frame_size"/>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="frame_rate">
                        <div class="info-row">
                          <span class="info-label">🎬 Frame Rate:</span>
                          <span class="info-value"><xsl:value-of select="frame_rate"/> fps</span>
                        </div>
                      </xsl:if>
                      <xsl:if test="listeners">
                        <div class="info-row">
                          <span class="info-label">👥 Current Listeners:</span>
                          <span class="info-value">
                            <span class="listeners-badge">
                              <xsl:value-of select="listeners"/>
                            </span>
                          </span>
                        </div>
                      </xsl:if>
                      <xsl:if test="listener_peak">
                        <div class="info-row">
                          <span class="info-label">🏆 Peak Listeners:</span>
                          <span class="info-value">
                            <span class="peak-badge">
                              <xsl:value-of select="listener_peak"/>
                            </span>
                          </span>
                        </div>
                      </xsl:if>
                    </div>
                  </div>
                  <div class="current-song">
                    <h3>🎵 Now Playing</h3>
                    <div class="song-title">
                      <xsl:if test="artist"><xsl:value-of select="artist"/> - </xsl:if>
                      <xsl:value-of select="title"/>
                    </div>
                  </div>
                </div>
              </xsl:when>
              <xsl:otherwise>
                <div class="not-connected">
                  <h3>❌ <xsl:value-of select="@mount"/> - Not Connected</h3>
                </div>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:for-each>
          <div class="footer">
            <p>💜 Support Icecast development at <a target="_blank" href="http://www.icecast.org">www.icecast.org</a>. This page was optimized by <a target="_blank" href="https://github.com/liuzhen9320/app-icecast">liuzhen932</a>.</p>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>