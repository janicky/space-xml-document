<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    version="2.0">
    <xsl:output method="text"/>
    
    <xsl:variable name="line" select="'────────────────────────────────────────────────────────────────────────────────────────────────'" />
    <xsl:variable name="spaces" select="'                                                                                        '" />

    <xsl:template match="/">
        <xsl:call-template name="header">
            <xsl:with-param name="text" select="'HEADER'" />
        </xsl:call-template>
        <xsl:text>...</xsl:text>
    </xsl:template>

    <xsl:template name="header">
        <xsl:param name="text" />
        <xsl:variable name="length" select="(string-length($line) - string-length($text) - 14)" />
        <xsl:variable name="fill" select="substring($spaces, 1, $length)" />
        <xsl:value-of select="concat('┌', $line, '┐')" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="concat('│ ', $text, $fill, ' │')" />
        <xsl:text>&#xa;</xsl:text>
        <xsl:value-of select="concat('└', $line, '┘')" />
        <xsl:text>&#xa;</xsl:text>
    </xsl:template>

</xsl:stylesheet>
