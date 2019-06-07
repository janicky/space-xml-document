<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="/">
        <space>
            <planets>
                <xsl:call-template name="planets-alphabetically"/>
            </planets>
            <missions>
                <xsl:call-template name="missions"/>
            </missions>
            <planets-list>
                <xsl:call-template name="planets-list"/>
            </planets-list>
        </space>
    </xsl:template>
    <xsl:template name="planets-list">
        <xsl:for-each select="//planet">
            <xsl:value-of select="name"/>
            <xsl:if test="./symbol">
                <xsl:text>&#160;(</xsl:text>
                <xsl:value-of select="./symbol" />
                <xsl:text>)</xsl:text>
            </xsl:if>
            <xsl:if test="not(position()=last())">, </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="planets-alphabetically">
        <xsl:for-each select="//planet">
            <xsl:sort order="ascending"/>
            <planet>
               <xsl:copy-of select="./@*" />
               <xsl:copy-of select="./*" />
               
               <xsl:variable name="idref" select="@id" />
               <satellites>
                   <xsl:for-each select="//satellite[@body=$idref]">
                       <satellite>
                           <xsl:copy-of select="./@id" />
                           <xsl:copy-of select="./*" />
                       </satellite>
                   </xsl:for-each>
               </satellites>
            </planet>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="missions" name="missions">
        <xsl:for-each select="//mission">
            <xsl:value-of select="name"/>
            <xsl:if test="not(position()=last())">, </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
