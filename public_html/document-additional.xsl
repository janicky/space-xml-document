<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:date="http://exslt.org/dates-and-times" 
    extension-element-prefixes="date"
    version="2.0">
    <xsl:output method="xml" indent="yes" />
    
    <!-- Root -->
    <xsl:template match="/">
        <space>
            <planets>
                <xsl:call-template name="planets" />
            </planets>
            <missions>
                <xsl:call-template name="missions"/>
            </missions>
            <planets-list>
                <xsl:call-template name="planets-list"/>
            </planets-list>
            <typologies>
                <xsl:call-template name="typologies" />
            </typologies>
            <statistics>
                <xsl:call-template name="statistics" />
            </statistics>
        </space>
    </xsl:template>
    
    <!-- Planets with sort -->
    <xsl:template name="planets">
        <xsl:for-each select="//planet">
            <xsl:sort select="name" order="ascending"/>
            <xsl:sort select="apoapsis" order="descending" data-type="number" />
            <planet>
               <xsl:copy-of select="./@*" />
               <xsl:copy-of select="./*" />
               <xsl:call-template name="planet-satellites">
                   <xsl:with-param name="body" select="@id" />
               </xsl:call-template>
            </planet>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Satellites for specified body -->
    <xsl:template name="planet-satellites">
        <xsl:param name="body" />
        <xsl:variable name="satellites" select="//satellite[@body=$body]" />
        <xsl:if test="$satellites">
            <satellites>
               <xsl:for-each select="$satellites">
                   <satellite>
                       <xsl:copy-of select="./@id" />
                       <xsl:copy-of select="./*" />
                   </satellite>
               </xsl:for-each>
            </satellites>
        </xsl:if>
    </xsl:template>
    
    <!-- Planets list with commas -->
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
    
    <!-- Missions with targets -->
    <xsl:template match="missions" name="missions">
        <xsl:for-each select="//mission">
            <mission>
                <xsl:copy-of select="./@*" />
                <xsl:copy-of select="./*" />
                <targets>
                    <xsl:call-template name="mission-targets">
                        <xsl:with-param name="mission" select="@id" />
                    </xsl:call-template>
                </targets>
            </mission>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Targets for mission -->
    <xsl:template name="mission-targets">
        <xsl:param name="mission" />
        <xsl:variable name="targets" select="//satellite/last_mission[@id=$mission] | //planet/last_mission[@id=$mission]" />
        <xsl:for-each select="$targets">
            <target>
                <xsl:attribute name="type">
                    <xsl:value-of select="name(../.)" />
                </xsl:attribute>
                <xsl:copy-of select="../@id" />
                <xsl:value-of select="../name" />
            </target>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Statistics -->
    <xsl:template name="statistics">
        <statistic name="planets-count">
            <xsl:value-of select="count(//planet)" />
        </statistic>
        <statistic name="satellites-count">
            <xsl:value-of select="count(//satellite)" />
        </statistic>
        <statistic name="missions-count">
            <xsl:value-of select="count(//mission)" />
        </statistic>
        <statistic name="created-at">
            <xsl:value-of select="current-date()" />
        </statistic>
    </xsl:template>
    
    <!-- Typologies -->
    <xsl:template name="typologies">
        <xsl:for-each-group select="//planet" group-by="@typology">
            <typology>
                <name>
                    <xsl:value-of select="current-grouping-key()" />
                </name>
                <planets>
                    <xsl:value-of select="count(//planet[@typology=current-grouping-key()])" />
                </planets>
            </typology>
        </xsl:for-each-group>
    </xsl:template>
</xsl:stylesheet>
