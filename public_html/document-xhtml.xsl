<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output 
        method="html" 
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" 
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
            <head>
              <title>Space - planets &amp; satellites</title>
            </head>
            <body>
                <div class="planets-section">
                    <h1>Planets</h1>
                    <hr />
                    <div class="planets">
                        <xsl:call-template name="planets" />
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template name="planets">
        <xsl:for-each select="//planet">
            <div class="planet">
                <h2>
                    <xsl:value-of select="name" />
                </h2>
                <p>
                    <xsl:value-of select="description" />
                </p>
                <div class="planet__satellites">
                    <b>Satellites: </b>
                    <xsl:for-each select="satellites/satellite">
                        <a class="satellite">
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('#', @id)" />
                            </xsl:attribute>
                            <xsl:value-of select="name" />
                        </a>
                        <xsl:if test="not(position()=last())">
                            <xsl:text>, </xsl:text>
                        </xsl:if>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
