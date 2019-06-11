<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    <xsl:output method="text"/>
    
    <xsl:variable name="line" select="'────────────────────────────────────────────────────────────────────────────────────────────────'" />
    <xsl:variable name="spaces" select="'                                                                                        '" />

    <xsl:template match="/">
        <xsl:call-template name="planets" />
    </xsl:template>
    
    <xsl:template name="planets">
        <xsl:call-template name="header">
            <xsl:with-param name="text" select="'PLANETS'" />
        </xsl:call-template>
        <xsl:call-template name="column">
            <xsl:with-param name="text" select="'ID'" />
            <xsl:with-param name="length" select="15" />
        </xsl:call-template>
        <xsl:call-template name="column">
            <xsl:with-param name="text" select="'NAME'" />
            <xsl:with-param name="length" select="20" />
        </xsl:call-template>
        <xsl:call-template name="column">
            <xsl:with-param name="text" select="'DISC. DATE'" />
            <xsl:with-param name="length" select="15" />
        </xsl:call-template>
        <xsl:call-template name="column">
            <xsl:with-param name="text" select="'APOAPSIS [km]'" />
            <xsl:with-param name="length" select="20" />
        </xsl:call-template>
        <xsl:call-template name="column">
            <xsl:with-param name="text" select="'PERIAPSIS [km]'" />
            <xsl:with-param name="length" select="20" />
        </xsl:call-template>
        <xsl:call-template name="newline" />
        <xsl:for-each select="//planets/planet">
            <xsl:call-template name="column">
                <xsl:with-param name="text" select="@id" />
                <xsl:with-param name="length" select="15" />
            </xsl:call-template>
            <xsl:call-template name="column">
                <xsl:with-param name="text" select="name" />
                <xsl:with-param name="length" select="20" />
            </xsl:call-template>
            <xsl:call-template name="column">
                <xsl:with-param name="text" select="discovery_date" />
                <xsl:with-param name="length" select="15" />
            </xsl:call-template>
            <xsl:call-template name="column">
                <xsl:with-param name="text" select="parameters/apoapsis" />
                <xsl:with-param name="length" select="20" />
            </xsl:call-template>
            <xsl:call-template name="column">
                <xsl:with-param name="text" select="parameters/periapsis" />
                <xsl:with-param name="length" select="20" />
            </xsl:call-template>
            <xsl:call-template name="newline" />
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="header">
        <xsl:param name="text" />
        <xsl:variable name="length" select="(string-length($line) - string-length($text) - 14)" />
        <xsl:variable name="fill" select="substring($spaces, 1, $length)" />
        <xsl:value-of select="concat('┌', $line, '┐')" />
        <xsl:call-template name="newline" />
        <xsl:value-of select="concat('│ ', $text, $fill, ' │')" />
        <xsl:call-template name="newline" />
        <xsl:value-of select="concat('└', $line, '┘')" />
        <xsl:call-template name="newline" />
    </xsl:template>
    
    <xsl:template name="newline">
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

    <xsl:template name="column">
        <xsl:param name="length" />
        <xsl:param name="text" />
        <xsl:variable name="fill" select="substring($spaces, 1, ($length - string-length($text) - 1))" />
        <xsl:value-of select="concat(' ', $text, $fill)" />
        
    </xsl:template>
</xsl:stylesheet>
