<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />

<xsl:template match="/icestats">
<html>
<head>
<title>List Clients | Icecast Streaming Media Server</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<style>
/* Base Styles */
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
    line-height: 1.6;
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

.admin-badge {
    background: linear-gradient(45deg, #e74c3c, #c0392b);
    color: white;
    padding: 5px 15px;
    border-radius: 15px;
    font-size: 0.8em;
    font-weight: 600;
}

/* Navigation */
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
    padding: 12px 24px;
    border-radius: 8px;
    transition: all 0.3s ease;
    font-weight: 500;
    background: rgba(103, 126, 234, 0.1);
    display: flex;
    align-items: center;
    gap: 8px;
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

/* Mount Point Cards */
.mount-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.mount-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
    margin-bottom: 25px;
    padding-bottom: 20px;
    border-bottom: 2px solid rgba(103, 126, 234, 0.1);
}

.mount-title {
    font-size: 1.8em;
    color: #2c3e50;
    font-weight: 600;
}

.mount-actions {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

.mount-action {
    display: inline-block;
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 10px 20px;
    border-radius: 20px;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.3s ease;
    font-size: 0.9em;
}

.mount-action:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
}

/* Listeners Table */
.listeners-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    border-radius: 10px;
    overflow: hidden;
}

.listeners-table th {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    text-align: left;
    padding: 15px 20px;
    font-weight: 600;
}

.listeners-table td {
    padding: 15px 20px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.listeners-table tr:nth-child(even) {
    background: rgba(103, 126, 234, 0.03);
}

.listeners-table tr:hover {
    background: rgba(103, 126, 234, 0.08);
}

.kick-link {
    color: #e74c3c;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s;
    padding: 5px 10px;
    border-radius: 5px;
}

.kick-link:hover {
    background: rgba(231, 76, 60, 0.1);
    text-decoration: underline;
}

/* Footer */
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

/* Responsive */
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
        align-items: center;
    }
    
    .mount-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .mount-actions {
        width: 100%;
        justify-content: center;
    }
    
    .listeners-table {
        display: block;
        overflow-x: auto;
    }
    
    .mount-action {
        width: 100%;
        text-align: center;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🎵 Icecast Streaming Server</h1>
        <h2>🔧 <span class="admin-badge">ADMIN</span> Listener Statistics</h2>
    </div>

    <!-- Navigation Menu -->
    <div class="nav-menu">
        <a href="stats.xsl"><span>📊</span> Admin Home</a>
        <a href="listmounts.xsl"><span>📋</span> List Mountpoints</a>
        <a href="moveclients.xsl"><span>🔀</span> Move Listeners</a>
        <a href="/status.xsl"><span>🏠</span> Index</a>
    </div>

    <xsl:for-each select="source">
    <div class="mount-card">
        <!-- Mount Point Header -->
        <div class="mount-header">
            <h2 class="mount-title">📢 Mount Point: <xsl:value-of select="@mount" /></h2>
            <div class="mount-actions">
                <xsl:choose>
                    <xsl:when test="authenticator">
                        <a class="mount-action" href="/auth.xsl">🔑 Login</a>
                    </xsl:when>
                    <xsl:otherwise>
                        <a class="mount-action" href="{@mount}.m3u">🎵 M3U</a>
                        <a class="mount-action" href="{@mount}.xspf">📀 XSPF</a>
                        <a class="mount-action" href="{@mount}.vclt">🎬 VCLT</a>
                    </xsl:otherwise>
                </xsl:choose>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="nav-menu" style="margin-top: 15px; margin-bottom: 25px;">
            <xsl:variable name="themount"><xsl:value-of select="@mount" /></xsl:variable>
            <a href="listclients.xsl?mount={@mount}">👥 List Clients</a>
            <a href="moveclients.xsl?mount={@mount}">🔀 Move Listeners</a>
            <a href="updatemetadata.xsl?mount={@mount}">🔄 Update Metadata</a>
            <a href="killsource.xsl?mount={@mount}">⛔ Kill Source</a>
        </div>

        <!-- Listeners Table -->
        <table class="listeners-table">
            <thead>
                <tr>
                    <th>IP Address</th>
                    <th>Connected</th>
                    <th>User Agent</th>
                    <th>Action</th>
                </tr>
            </thead>
            <xsl:variable name="themount" ><xsl:value-of select="@mount" /></xsl:variable>
            <tbody>
                <xsl:for-each select="listener">
                <tr>
                    <td><xsl:value-of select="IP" /></td>
                    <td><xsl:value-of select="Connected" /></td>
                    <td><xsl:value-of select="UserAgent" /></td>
                    <td>
                        <a class="kick-link" href="killclient.xsl?mount={$themount}&amp;id={ID}">
                            🚫 Kick
                        </a>
                    </td>
                </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </div>
    </xsl:for-each>

    <div class="footer">
        <p>💜 Support Icecast development at <a target="_blank" href="http://www.icecast.org">www.icecast.org</a>. This page was optimized by <a target="_blank" href="https://github.com/liuzhen9320/app-icecast">liuzhen932</a>.</p>
    </div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
