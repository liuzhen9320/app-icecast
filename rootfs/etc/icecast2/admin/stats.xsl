<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />
<xsl:template match="/icestats">
<html>
<head>
<title>Admin Panel | Icecast Streaming Media Server</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
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
    max-width: 1400px;
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
    border: 2px solid rgba(231, 76, 60, 0.2);
}

.header h1 {
    font-size: 2.5em;
    color: #2c3e50;
    margin-bottom: 10px;
    font-weight: 300;
}

.header h2 {
    font-size: 1.2em;
    color: #e74c3c;
    font-weight: 600;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.admin-badge {
    background: linear-gradient(45deg, #e74c3c, #c0392b);
    color: white;
    padding: 5px 15px;
    border-radius: 15px;
    font-size: 0.8em;
    font-weight: 600;
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
    gap: 15px;
    flex-wrap: wrap;
}

.nav-menu a {
    color: #2c3e50;
    text-decoration: none;
    padding: 12px 20px;
    border-radius: 8px;
    transition: all 0.3s ease;
    font-weight: 500;
    font-size: 0.9em;
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

.server-stats-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.server-stats-card:hover {
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

.stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
}

.stat-item {
    background: rgba(103, 126, 234, 0.05);
    border-radius: 8px;
    padding: 15px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: all 0.3s ease;
}

.stat-item:hover {
    background: rgba(103, 126, 234, 0.1);
    transform: scale(1.02);
}

.stat-label {
    font-size: 0.9em;
    color: #7f8c8d;
    font-weight: 500;
    text-transform: capitalize;
}

.stat-value {
    font-size: 1.1em;
    color: #2c3e50;
    font-weight: 600;
}

.mount-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
    border-left: 4px solid #2ecc71;
}

.mount-card:hover {
    transform: translateY(-5px);
}

.mount-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    flex-wrap: wrap;
    gap: 15px;
}

.mount-title {
    font-size: 1.6em;
    color: #2c3e50;
    font-weight: 600;
}

.mount-links {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.mount-links a {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 6px 12px;
    border-radius: 15px;
    text-decoration: none;
    font-size: 0.8em;
    font-weight: 500;
    transition: all 0.3s ease;
}

.mount-links a:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
}

.admin-actions {
    background: rgba(231, 76, 60, 0.05);
    border-radius: 10px;
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid rgba(231, 76, 60, 0.1);
}

.admin-actions h4 {
    color: #e74c3c;
    margin-bottom: 15px;
    font-size: 1.1em;
    display: flex;
    align-items: center;
    gap: 8px;
}

.admin-buttons {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
}

.admin-btn {
    background: linear-gradient(45deg, #e74c3c, #c0392b);
    color: white;
    padding: 8px 16px;
    border-radius: 20px;
    text-decoration: none;
    font-size: 0.8em;
    font-weight: 500;
    transition: all 0.3s ease;
    border: none;
    cursor: pointer;
}

.admin-btn:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
}

.admin-btn.danger {
    background: linear-gradient(45deg, #e74c3c, #c0392b);
}

.admin-btn.warning {
    background: linear-gradient(45deg, #f39c12, #e67e22);
}

.admin-btn.info {
    background: linear-gradient(45deg, #3498db, #2980b9);
}

.mount-stats {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
    gap: 12px;
}

.mount-stat-item {
    background: rgba(46, 204, 113, 0.05);
    border-radius: 8px;
    padding: 12px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: all 0.3s ease;
}

.mount-stat-item:hover {
    background: rgba(46, 204, 113, 0.1);
    transform: scale(1.02);
}

.mount-stat-label {
    font-size: 0.85em;
    color: #27ae60;
    font-weight: 500;
    text-transform: capitalize;
}

.mount-stat-value {
    font-size: 1em;
    color: #2c3e50;
    font-weight: 600;
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

.status-indicator {
    display: inline-block;
    width: 12px;
    height: 12px;
    border-radius: 50%;
    background: #2ecc71;
    animation: pulse 2s infinite;
    margin-right: 8px;
}

@keyframes pulse {
    0% { opacity: 1; }
    50% { opacity: 0.5; }
    100% { opacity: 1; }
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
    
    .mount-header {
        flex-direction: column;
        text-align: center;
    }
    
    .stats-grid {
        grid-template-columns: 1fr;
    }
    
    .mount-stats {
        grid-template-columns: 1fr;
    }
    
    .admin-buttons {
        justify-content: center;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🎵 Icecast Streaming Server</h1>
        <h2>🔧 <span class="admin-badge">ADMIN</span> Dashboard</h2>
    </div>

    <div class="nav-menu">
        <a href="stats.xsl" class="active">🏠 Admin Home</a>
        <a href="listmounts.xsl">📋 List Mountpoints</a>
        <a href="moveclients.xsl">↔️ Move Listeners</a>
        <a href="/status.xsl">📊 Public Status</a>
    </div>

    <div class="server-stats-card">
        <div class="card-header">
            <span style="font-size: 2em;">🌐</span>
            <h3 class="card-title">Global Server Statistics</h3>
        </div>
        
        <div class="stats-grid">
            <xsl:for-each select="/icestats">
                <xsl:for-each select="*">
                    <xsl:if test="name()!='source'">
                        <div class="stat-item">
                            <span class="stat-label"><xsl:value-of select="name()" /></span>
                            <span class="stat-value"><xsl:value-of select="." /></span>
                        </div>
                    </xsl:if>
                </xsl:for-each>
            </xsl:for-each>
        </div>
    </div>

    <xsl:for-each select="source">
        <xsl:if test="listeners!=''">
            <div class="mount-card">
                <div class="mount-header">
                    <h3 class="mount-title">
                        <span class="status-indicator"></span>
                        📡 <xsl:value-of select="@mount" />
                    </h3>
                    <div class="mount-links">
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

                <div class="admin-actions">
                    <h4>⚙️ Admin Actions</h4>
                    <div class="admin-buttons">
                        <a class="admin-btn info" href="listclients.xsl?mount={@mount}">👥 List Clients</a>
                        <a class="admin-btn warning" href="moveclients.xsl?mount={@mount}">↔️ Move Clients</a>
                        <a class="admin-btn info" href="updatemetadata.xsl?mount={@mount}">📝 Update Metadata</a>
                        <a class="admin-btn danger" href="killsource.xsl?mount={@mount}">⚠️ Kill Source</a>
                        <xsl:if test="authenticator">
                            <a class="admin-btn info" href="manageauth.xsl?mount={@mount}">🔐 Manage Auth</a>
                        </xsl:if>
                    </div>
                </div>

                <div class="mount-stats">
                    <xsl:for-each select="*">
                        <div class="mount-stat-item">
                            <span class="mount-stat-label"><xsl:value-of select="name()" /></span>
                            <span class="mount-stat-value"><xsl:value-of select="." /></span>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:if>
    </xsl:for-each>

    <div class="footer">
        <p>💜 Support Icecast development at <a target="_blank" href="http://www.icecast.org">www.icecast.org</a>. This page was optimized by <a target="_blank" href="https://github.com/liuzhen9320/app-icecast">liuzhen932</a>.</p>
    </div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
