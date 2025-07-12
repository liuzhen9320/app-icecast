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
    max-width: 1000px;
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

.server-info-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.server-info-card:hover {
    transform: translateY(-5px);
}

.card-header {
    display: flex;
    align-items: center;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid rgba(103, 126, 234, 0.1);
}

.card-title {
    font-size: 1.8em;
    color: #2c3e50;
    font-weight: 600;
    margin-left: 15px;
}

.server-icon {
    font-size: 2em;
    background: linear-gradient(45deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.info-item {
    background: rgba(103, 126, 234, 0.05);
    border-radius: 10px;
    padding: 20px;
    display: flex;
    align-items: center;
    gap: 15px;
    transition: all 0.3s ease;
}

.info-item:hover {
    background: rgba(103, 126, 234, 0.1);
    transform: scale(1.02);
}

.info-icon {
    font-size: 1.5em;
    min-width: 40px;
    text-align: center;
}

.info-content {
    flex: 1;
}

.info-label {
    font-size: 0.9em;
    color: #7f8c8d;
    font-weight: 500;
    margin-bottom: 5px;
}

.info-value {
    font-size: 1.1em;
    color: #2c3e50;
    font-weight: 600;
}

.resources-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.resources-header {
    display: flex;
    align-items: center;
    margin-bottom: 25px;
    padding-bottom: 15px;
    border-bottom: 2px solid rgba(103, 126, 234, 0.1);
}

.resources-title {
    font-size: 1.8em;
    color: #2c3e50;
    font-weight: 600;
    margin-left: 15px;
}

.resources-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 20px;
}

.resource-card {
    background: rgba(103, 126, 234, 0.05);
    border-radius: 10px;
    padding: 20px;
    transition: all 0.3s ease;
    text-align: center;
}

.resource-card:hover {
    background: rgba(103, 126, 234, 0.1);
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(103, 126, 234, 0.15);
}

.resource-icon {
    font-size: 2.5em;
    margin-bottom: 15px;
    background: linear-gradient(45deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.resource-title {
    font-size: 1.2em;
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 10px;
}

.resource-link {
    display: inline-block;
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 10px 20px;
    border-radius: 20px;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
    margin-top: 10px;
}

.resource-link:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
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

.version-badge {
    background: linear-gradient(45deg, #2ecc71, #27ae60);
    color: white;
    padding: 5px 15px;
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
    
    .card-header {
        flex-direction: column;
        text-align: center;
        gap: 10px;
    }
    
    .card-title {
        margin-left: 0;
    }
    
    .info-grid {
        grid-template-columns: 1fr;
    }
    
    .resources-grid {
        grid-template-columns: 1fr;
    }
    
    .info-item {
        flex-direction: column;
        text-align: center;
    }
}
        </style>
      </head>
      <body>
        <div class="container">
          <div class="header">
            <h1>🎵 Icecast Streaming Server</h1>
            <h2>Server Information &amp; Resources</h2>
          </div>
          <div class="nav-menu">
            <a href="admin/">🔧 Administration</a>
            <a href="status.xsl">📊 Server Status</a>
            <a href="server_version.xsl" class="active">ℹ️ Version</a>
          </div>
          <div class="server-info-card">
            <div class="card-header">
              <span class="server-icon">🖥️</span>
              <h3 class="card-title">Server Information</h3>
            </div>
            <div class="info-grid">
              <xsl:for-each select="/icestats">
                <div class="info-item">
                  <div class="info-icon">🌍</div>
                  <div class="info-content">
                    <div class="info-label">Location</div>
                    <div class="info-value">
                      <xsl:value-of select="location"/>
                    </div>
                  </div>
                </div>
                <div class="info-item">
                  <div class="info-icon">👤</div>
                  <div class="info-content">
                    <div class="info-label">Administrator</div>
                    <div class="info-value">
                      <xsl:value-of select="admin"/>
                    </div>
                  </div>
                </div>
                <div class="info-item">
                  <div class="info-icon">🏠</div>
                  <div class="info-content">
                    <div class="info-label">Host</div>
                    <div class="info-value">
                      <xsl:value-of select="host"/>
                    </div>
                  </div>
                </div>
                <div class="info-item">
                  <div class="info-icon">🔢</div>
                  <div class="info-content">
                    <div class="info-label">Version</div>
                    <div class="info-value">
                      <span class="version-badge">
                        <xsl:value-of select="server_id"/>
                      </span>
                    </div>
                  </div>
                </div>
              </xsl:for-each>
            </div>
          </div>
          <div class="resources-section">
            <div class="resources-header">
              <span class="server-icon">🔗</span>
              <h3 class="resources-title">Resources &amp; Links</h3>
            </div>
            <div class="resources-grid">
              <div class="resource-card">
                <div class="resource-icon">📥</div>
                <div class="resource-title">Download</div>
                <p>Get the latest version of Icecast</p>
                <a class="resource-link" target="_blank" href="https://icecast.org/download/">Download Now</a>
              </div>
              <div class="resource-card">
                <div class="resource-icon">🌿</div>
                <div class="resource-title">Source Code</div>
                <p>Access the Git repository</p>
                <a class="resource-link" target="_blank" href="https://gitlab.xiph.org/xiph/icecast-server">View Source</a>
              </div>
              <div class="resource-card">
                <div class="resource-icon">📚</div>
                <div class="resource-title">Documentation</div>
                <p>Complete guides and references</p>
                <a class="resource-link" target="_blank" href="https://icecast.org/docs">Read Docs</a>
              </div>
              <div class="resource-card">
                <div class="resource-icon">📻</div>
                <div class="resource-title">Stream Directory</div>
                <p>Browse public streams</p>
                <a class="resource-link" target="_blank" href="https://dir.xiph.org">Explore Streams</a>
              </div>
              <div class="resource-card">
                <div class="resource-icon">💬</div>
                <div class="resource-title">Community</div>
                <p>Join discussions and get help</p>
                <a class="resource-link" target="_blank" href="https://icecast.org/contact/">Contact</a>
              </div>
            </div>
          </div>
          <div class="footer">
            <p>💜 Support Icecast development at <a target="_blank" href="http://www.icecast.org">www.icecast.org</a>. This page was optimized by <a target="_blank" href="https://github.com/liuzhen9320/app-icecast">liuzhen932</a>.</p>
          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>