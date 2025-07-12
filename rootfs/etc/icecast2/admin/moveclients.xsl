<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />

<xsl:template match="/icestats">
<html>
<head>
<title>Move Listeners | Icecast Streaming Media Server</title>
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

.current-mount {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 8px 16px;
    border-radius: 10px;
    font-weight: 600;
    font-family: 'Courier New', monospace;
    display: inline-block;
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

/* Move Section */
.move-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.move-section h3 {
    font-size: 1.5em;
    color: #2c3e50;
    margin-bottom: 25px;
    font-weight: 600;
    text-align: center;
}

/* Destination Cards */
.destination-card {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(5px);
    border-radius: 12px;
    padding: 25px;
    margin-bottom: 20px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    border: 2px solid rgba(103, 126, 234, 0.1);
    transition: all 0.3s ease;
}

.destination-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(103, 126, 234, 0.15);
    border-color: rgba(103, 126, 234, 0.3);
}

.destination-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
    flex-wrap: wrap;
    gap: 15px;
}

.destination-path {
    font-size: 1.2em;
    font-weight: 600;
    color: #2c3e50;
}

.destination-from, .destination-to {
    font-family: 'Courier New', monospace;
    background: rgba(103, 126, 234, 0.1);
    padding: 4px 8px;
    border-radius: 6px;
    font-weight: 600;
}

.destination-to {
    background: rgba(46, 204, 113, 0.1);
    color: #27ae60;
}

.listener-info {
    display: flex;
    align-items: center;
    gap: 8px;
    color: #667eea;
    font-weight: 500;
    margin-bottom: 15px;
}

.listener-info::before {
    content: "👥";
    font-size: 1.2em;
}

.move-button {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 12px 24px;
    border-radius: 20px;
    text-decoration: none;
    font-weight: 600;
    display: inline-block;
    transition: all 0.3s ease;
    font-size: 0.95em;
}

.move-button:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
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
    
    .destination-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .destination-path {
        font-size: 1em;
    }
    
    .move-button {
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
        <h2>🔧 <span class="admin-badge">ADMIN</span> Move Listeners</h2>
        <xsl:variable name="currentmount"><xsl:value-of select="current_source" /></xsl:variable>
        <p style="margin-top: 15px;">Moving listeners from <span class="current-mount"><xsl:value-of select="current_source" /></span></p>
    </div>

    <!-- Navigation Menu -->
    <div class="nav-menu">
        <a href="stats.xsl"><span>📊</span> Admin Home</a>
        <a href="listmounts.xsl"><span>📋</span> Mountpoint List</a>
        <a href="moveclients.xsl" class="active"><span>🔀</span> Move Listeners</a>
        <a href="/status.xsl"><span>🏠</span> Public Home</a>
    </div>

    <!-- Move Section -->
    <div class="move-section">
        <h3>🎯 Select Destination Mountpoint</h3>
        
        <xsl:variable name="currentmount"><xsl:value-of select="current_source" /></xsl:variable>
        <xsl:for-each select="source">
        <div class="destination-card">
            <div class="destination-header">
                <div class="destination-path">
                    📢 <span class="destination-from"><xsl:copy-of select="$currentmount" /></span>
                    ➡️ <span class="destination-to"><xsl:value-of select="@mount" /></span>
                </div>
            </div>
            
            <div class="listener-info">
                <xsl:value-of select="listeners" /> listener(s) currently connected
            </div>
            
            <a class="move-button" href="moveclients.xsl?mount={$currentmount}&amp;destination={@mount}">
                🚀 Move All Clients
            </a>
        </div>
        </xsl:for-each>
    </div>

    <div class="footer">
        <p>💜 Support Icecast development at <a target="_blank" href="https://www.icecast.org">www.icecast.org</a>. This page was optimized by <a target="_blank" href="https://github.com/liuzhen9320/app-icecast">liuzhen932</a>.</p>
    </div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>