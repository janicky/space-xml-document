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
                <div class="satellites-section">
                    <h1>Satellites</h1>
                    <hr />
                    <div class="satellites">
                        <xsl:call-template name="satellites" />
                    </div>
                </div>
                <div class="typologies-section">
                    <h1>Typologies</h1>
                    <hr />
                    <div class="typologies">
                        <xsl:call-template name="typologies" />
                    </div>
                </div>
                <div class="statistics-section">
                    <h1>Statistics</h1>
                    <hr />
                    <table class="statistics" border="1">
                        <tbody>
                            <xsl:call-template name="statistics" />
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <!-- Planets -->
    <xsl:template name="planets">
        <xsl:for-each select="//planet">
            <div class="planet">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id" />
                </xsl:attribute>
                <h2>
                    <xsl:value-of select="name" />
                </h2>
                <p>
                    <xsl:value-of select="description" />
                </p>
                <xsl:if test="satellites">
                    <div class="planet__satellites">
                        <b>Satellites: </b>
                        <xsl:for-each select="satellites/satellite">
                            <a>
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
                </xsl:if>
                <xsl:if test="@typology">
                    <div class="planet__typology">
                        <b>Typology: </b>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="concat('#', @typology)" />
                            </xsl:attribute>
                            <xsl:value-of select="@typology" />
                        </a>
                    </div>
                </xsl:if>
            </div>
        </xsl:for-each>
    </xsl:template>

    <!-- Satellites -->
    <xsl:template name="satellites">
        <xsl:for-each select="//satellite">
            <div class="satellite">
                <xsl:attribute name="id">
                    <xsl:value-of select="@id" />
                </xsl:attribute>
                <h2>
                    <xsl:value-of select="name" />
                </h2>
                <p>
                    <xsl:value-of select="description" />
                </p>
                <div class="satellite_planet">
                    <b>Planet: </b>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="concat('#', ../../@id)" />
                        </xsl:attribute>
                        <xsl:value-of select="../../name" />
                    </a>
                </div>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Typologies -->
    <xsl:template name="typologies">
        <xsl:for-each select="//typology">
            <div class="typology">
                <xsl:attribute name="id">
                    <xsl:value-of select="name" />
                </xsl:attribute>
                <h2>
                    <xsl:value-of select="name" />
                    <xsl:value-of select="concat(' (', planets/@count, ')')" />
                </h2>
                <ul>
                    <xsl:for-each select="planets/planet">
                        <li>
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="concat('#', @id)" />
                                </xsl:attribute>
                                <xsl:value-of select="name" />
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </div>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Statistics -->
    <xsl:template name="statistics">
        <xsl:for-each select="//statistics/statistic">
            <tr>
                <td>
                    <b>
                        <xsl:value-of select="@name" />
                    </b>
                </td>
                <td>
                    <xsl:value-of select="." />
                </td>
            </tr>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
