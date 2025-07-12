<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output omit-xml-declaration="no" method="html" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes" encoding="UTF-8" />

<xsl:template match="/icestats">
<html>
<head>
<title>Manage Auth | Icecast Authentication Manager</title>
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

/* Cards */
.card {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 30px;
    margin-bottom: 30px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
    margin-bottom: 25px;
    padding-bottom: 20px;
    border-bottom: 2px solid rgba(103, 126, 234, 0.1);
}

.card-title {
    font-size: 1.8em;
    color: #2c3e50;
    font-weight: 600;
}

.mount-name {
    font-weight: 500;
    color: #667eea;
}

/* Action Buttons */
.actions-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
    margin-bottom: 30px;
}

.action-btn {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
    background: rgba(103, 126, 234, 0.1);
    color: #2c3e50;
    text-decoration: none;
    padding: 15px;
    border-radius: 10px;
    font-weight: 500;
    transition: all 0.3s ease;
    text-align: center;
}

.action-btn:hover {
    background: rgba(103, 126, 234, 0.2);
    transform: translateY(-3px);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.2);
}

/* Forms */
.form-container {
    background: rgba(103, 126, 234, 0.05);
    border-radius: 12px;
    padding: 25px;
    margin-top: 25px;
}

.form-title {
    font-size: 1.4em;
    color: #2c3e50;
    margin-bottom: 20px;
    padding-bottom: 10px;
    border-bottom: 1px solid rgba(103, 126, 234, 0.1);
}

.form-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 20px;
}

.form-group {
    margin-bottom: 20px;
}

.form-label {
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
    color: #2c3e50;
}

.form-input {
    width: 100%;
    padding: 12px 15px;
    border-radius: 8px;
    border: 1px solid rgba(103, 126, 234, 0.3);
    background: white;
    font-size: 1em;
    transition: all 0.2s;
}

.form-input:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 3px rgba(103, 126, 234, 0.2);
    outline: none;
}

.submit-btn {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    border: none;
    padding: 14px 25px;
    border-radius: 8px;
    font-size: 1em;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    grid-column: span 2;
    margin-top: 10px;
}

.submit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(103, 126, 234, 0.4);
}

/* Tables */
.user-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 25px;
    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
    border-radius: 10px;
    overflow: hidden;
}

.user-table th {
    background: linear-gradient(45deg, #667eea, #764ba2);
    color: white;
    text-align: left;
    padding: 15px 20px;
    font-weight: 600;
}

.user-table td {
    padding: 15px 20px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
}

.user-table tr:nth-child(even) {
    background: rgba(103, 126, 234, 0.03);
}

.user-table tr:hover {
    background: rgba(103, 126, 234, 0.08);
}

.delete-link {
    color: #e74c3c;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s;
    padding: 5px 10px;
    border-radius: 5px;
    display: inline-flex;
    align-items: center;
    gap: 5px;
}

.delete-link:hover {
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

/* Messages */
.message-container {
    padding: 15px 20px;
    border-radius: 8px;
    margin-bottom: 25px;
    background: rgba(46, 204, 113, 0.15);
    color: #27ae60;
    border-left: 4px solid #27ae60;
    display: flex;
    align-items: center;
    gap: 10px;
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
    
    .card-header {
        flex-direction: column;
        align-items: flex-start;
    }
    
    .actions-grid {
        grid-template-columns: 1fr;
    }
    
    .user-table {
        display: block;
        overflow-x: auto;
    }
    
    .form-grid {
        grid-template-columns: 1fr;
    }
    
    .submit-btn {
        grid-column: 1;
    }
}
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>🎵 Icecast Streaming Server</h1>
        <h2>🔒 <span class="admin-badge">ADMIN</span> Authentication Manager</h2>
    </div>

    <!-- Navigation Menu -->
    <div class="nav-menu">
        <a href="stats.xsl"><span>📊</span> Admin Home</a>
        <a href="listmounts.xsl"><span>📋</span> List Mountpoints</a>
        <a href="moveclients.xsl"><span>🔀</span> Move Listeners</a>
        <a href="/status.xsl"><span>🏠</span> Index</a>
    </div>

    <!-- Messages -->
    <xsl:for-each select="iceresponse">
        <div class="message-container">
            <span>ℹ️</span>
            <xsl:value-of select="message" />
        </div>
    </xsl:for-each>

    <xsl:for-each select="source">
    <div class="card">
        <!-- Mount Point Header -->
        <div class="card-header">
            <h2 class="card-title">
                <xsl:if test="server_name">
                    <xsl:value-of select="server_name" /> - 
                </xsl:if>
                <span class="mount-name"><xsl:value-of select="@mount" /></span>
            </h2>
        </div>

        <!-- Action Buttons -->
        <div class="actions-grid">
            <a class="action-btn" href="listclients.xsl?mount={@mount}">
                <span>👥</span> List Clients
            </a>
            <a class="action-btn" href="moveclients.xsl?mount={@mount}">
                <span>🔀</span> Move Listeners
            </a>
            <a class="action-btn" href="updatemetadata.xsl?mount={@mount}">
                <span>🔄</span> Update Metadata
            </a>
            <a class="action-btn" href="killsource.xsl?mount={@mount}">
                <span>⛔</span> Kill Source
            </a>
        </div>

        <!-- Current Users -->
        <div class="form-container">
            <h3 class="form-title">Current Authentication Users</h3>
            <xsl:variable name="themount"><xsl:value-of select="@mount" /></xsl:variable>
            
            <xsl:choose>
                <xsl:when test="User">
                    <table class="user-table">
                        <thead>
                            <tr>
                                <th>User ID</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="User">
                            <tr>
                                <td><xsl:value-of select="username" /></td>
                                <td>
                                    <a class="delete-link" href="manageauth.xsl?mount={$themount}&amp;username={username}&amp;action=delete">
                                        <span>🗑️</span> Delete
                                    </a>
                                </td>
                            </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </xsl:when>
                <xsl:otherwise>
                    <div style="padding: 20px; text-align: center; color: #7f8c8d;">
                        No authentication users configured for this mount point.
                    </div>
                </xsl:otherwise>
            </xsl:choose>
        </div>

        <!-- Add New User Form -->
        <div class="form-container">
            <h3 class="form-title">Add New Authentication User</h3>
            <form method="GET" action="manageauth.xsl" class="form-grid">
                <div class="form-group">
                    <label class="form-label">User ID</label>
                    <input type="text" name="username" class="form-input" placeholder="Enter username" />
                </div>
                
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="text" name="password" class="form-input" placeholder="Enter password" />
                </div>
                
                <button type="submit" name="Submit" value="Add New User" class="submit-btn">
                    <span>➕</span> Add New User
                </button>
                
                <input type="hidden" name="mount" value="{@mount}" />
                <input type="hidden" name="action" value="add" />
            </form>
        </div>
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
