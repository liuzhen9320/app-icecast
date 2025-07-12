<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />

<xsl:template match="/icestats">
<html>
<head>
<title>Update Metadata | Icecast Streaming Media Server</title>
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
    gap: 15px;
    margin-bottom: 25px;
    padding-bottom: 20px;
    border-bottom: 2px solid rgba(103, 126, 234, 0.1);
}

.mount-title {
    font-size: 1.8em;
    color: #2c3e50;
    font-weight: 600;
}

.mount-subtitle {
    font-size: 1em;
    color: #667eea;
    font-weight: 400;
    margin-top: 5px;
}

/* Form Styles */
.metadata-form {
    background: rgba(255, 255, 255, 0.5);
    backdrop-filter: blur(5px);
    border-radius: 12px;
    padding: 25px;
    border: 2px solid rgba(103, 126, 234, 0.1);
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    display: block;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 8px;
    font-size: 1.1em;
}

.form-label::before {
    content: "🎵";
    margin-right: 8px;
}

.form-input {
    width: 100%;
    padding: 15px 20px;
    border: 2px solid rgba(103, 126, 234, 0.2);
    border-radius: 10px;
    font-size: 1em;
    font-family: inherit;
    background: rgba(255, 255, 255, 0.8);
    backdrop-filter: blur(5px);
    transition: all 0.3s ease;
}

.form-input:focus {
    outline: none;
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(103, 126, 234, 0.1);
    background: rgba(255, 255, 255, 0.95);
}

.form-input::placeholder {
    color: #999;
    font-style: italic;
}

.form-actions {
    display: flex;
    gap: 15px;
    justify-content: flex-end;
    margin-top: 25px;
}

.btn-primary {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    padding: 12px 30px;
    border: none;
    border-radius: 20px;
    font-size: 1em;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
}

.btn-primary:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
}

.btn-primary::before {
    content: "🚀";
}

/* Hidden inputs styling for debugging */
.hidden-inputs {
    margin-top: 15px;
    padding: 10px;
    background: rgba(103, 126, 234, 0.05);
    border-radius: 8px;
    font-size: 0.85em;
    color: #666;
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
    
    .form-actions {
        justify-content: center;
    }
    
    .btn-primary {
        width: 100%;
        justify-content: center;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🎵 Icecast Streaming Server</h1>
        <h2>🔧 <span class="admin-badge">ADMIN</span> Update Metadata</h2>
    </div>

    <!-- Navigation Menu -->
    <div class="nav-menu">
        <a href="stats.xsl"><span>📊</span> Admin Home</a>
        <a href="listmounts.xsl"><span>📋</span> Mountpoint List</a>
        <a href="moveclients.xsl"><span>🔀</span> Move Listeners</a>
        <a href="updatemetadata.xsl" class="active"><span>🔄</span> Update Metadata</a>
        <a href="/status.xsl"><span>🏠</span> Public Home</a>
    </div>

    <xsl:for-each select="source">
    <div class="mount-card">
        <!-- Mount Point Header -->
        <div class="mount-header">
            <div>
                <h2 class="mount-title">📢 Mount Point: <xsl:value-of select="@mount" /></h2>
                <xsl:if test="server_name">
                    <div class="mount-subtitle">Server: <xsl:value-of select="server_name" /></div>
                </xsl:if>
            </div>
        </div>

        <!-- Metadata Form -->
        <div class="metadata-form">
            <form method="get" action="/admin/metadata.xsl">
                <div class="form-group">
                    <label class="form-label" for="song_{@mount}">Current Track Information</label>
                    <input 
                        type="text" 
                        class="form-input" 
                        id="song_{@mount}" 
                        name="song"
                        placeholder="Enter artist - song title, or any metadata information..."
                    />
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn-primary">Update Metadata</button>
                </div>
                
                <!-- Hidden form fields -->
                <input type="hidden" name="mount" value="{@mount}"/>
                <input type="hidden" name="mode" value="updinfo"/>
                <input type="hidden" name="charset" value="UTF-8"/>
                
                <div class="hidden-inputs">
                    <small>📝 Form will submit to: /admin/metadata.xsl with mount=<strong><xsl:value-of select="@mount" /></strong></small>
                </div>
            </form>
        </div>
    </div>
    </xsl:for-each>

    <div class="footer">
        <p>💜 Support Icecast development at <a target="_blank" href="https://www.icecast.org">www.icecast.org</a>. This page was optimized by <a target="_blank" href="https://github.com/liuzhen9320/app-icecast">liuzhen932</a>.</p>
    </div>
</div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>