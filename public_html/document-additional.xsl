<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml"/>
    <xsl:template match="/">
        <space>
            <planets-list>
                <xsl:call-template name="planets-list"/>
            </planets-list>
            <satellites-alphabetically>
                <xsl:call-template name="satellites-alphabetically"/>
            </satellites-alphabetically>
            <missions>
                <xsl:call-template name="missions"/>
            </missions>
        </space>
    </xsl:template>
    <xsl:template match="planets" name="planets-list">
        <xsl:for-each select="//planet">
            <xsl:value-of select="name"/>
            <xsl:if test="not(position()=last())">, </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="satellites" name="satellites-alphabetically">
        <xsl:for-each select="//satellite">
            <xsl:sort order="ascending"/>
            <satellite>
               <xsl:value-of select="name"/> 
            </satellite>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="missions" name="missions">
        <xsl:for-each select="//mission">
            <xsl:value-of select="name"/>
            <xsl:if test="not(position()=last())">, </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
