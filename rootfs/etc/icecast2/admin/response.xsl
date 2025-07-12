<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />
<xsl:template match="/iceresponse">
<html>
<head>
<title>Server Response | Icecast Streaming Media Server</title>
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

.response-card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    transition: transform 0.3s ease;
}

.response-card:hover {
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

.response-icon {
    font-size: 2em;
    background: linear-gradient(45deg, #667eea, #764ba2);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.response-content {
    padding: 20px;
    background: rgba(103, 126, 234, 0.05);
    border-radius: 10px;
    border-left: 4px solid #667eea;
}

.response-item {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    padding: 15px;
    background: rgba(255, 255, 255, 0.6);
    border-radius: 8px;
    transition: all 0.3s ease;
}

.response-item:hover {
    background: rgba(255, 255, 255, 0.8);
    transform: scale(1.02);
}

.response-item:last-child {
    margin-bottom: 0;
}

.response-item-icon {
    font-size: 1.5em;
    min-width: 40px;
    text-align: center;
    margin-right: 15px;
}

.response-item-content {
    flex: 1;
}

.response-label {
    font-size: 0.9em;
    color: #7f8c8d;
    font-weight: 500;
    margin-bottom: 5px;
}

.response-value {
    font-size: 1.1em;
    color: #2c3e50;
    font-weight: 600;
}

.success {
    color: #27ae60;
}

.error {
    color: #e74c3c;
}

.warning {
    color: #f39c12;
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
    
    .response-item {
        flex-direction: column;
        text-align: center;
    }
    
    .response-item-icon {
        margin-right: 0;
        margin-bottom: 10px;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🎵 Icecast Streaming Server</h1>
        <h2>Administration Response</h2>
    </div>

    <div class="nav-menu">
        <a href="stats.xsl">🏠 Admin Home</a>
        <a href="listmounts.xsl">📋 List Mountpoints</a>
        <a href="moveclients.xsl">🔄 Move Listeners</a>
        <a href="/status.xsl">📊 Index</a>
    </div>

    <div class="response-card">
        <div class="card-header">
            <span class="response-icon">📋</span>
            <h3 class="card-title">Server Response</h3>
        </div>
        
        <div class="response-content">
            <xsl:for-each select="/iceresponse">
                <div class="response-item">
                    <div class="response-item-icon">💬</div>
                    <div class="response-item-content">
                        <div class="response-label">Message</div>
                        <div class="response-value"><xsl:value-of select="message" /></div>
                    </div>
                </div>
                
                <div class="response-item">
                    <div class="response-item-icon">
                        <xsl:choose>
                            <xsl:when test="return = '1'">✅</xsl:when>
                            <xsl:when test="return = '0'">❌</xsl:when>
                            <xsl:otherwise>⚠️</xsl:otherwise>
                        </xsl:choose>
                    </div>
                    <div class="response-item-content">
                        <div class="response-label">Return Code</div>
                        <div class="response-value">
                            <xsl:choose>
                                <xsl:when test="return = '1'">
                                    <span class="success"><xsl:value-of select="return" /> (Success)</span>
                                </xsl:when>
                                <xsl:when test="return = '0'">
                                    <span class="error"><xsl:value-of select="return" /> (Error)</span>
                                </xsl:when>
                                <xsl:otherwise>
                                    <span class="warning"><xsl:value-of select="return" /> (Unknown)</span>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </div>
                </div>
            </xsl:for-each>
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
