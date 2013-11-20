<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3" xmlns:mets="http://www.loc.gov/mets" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html"/>

    <!-- Driver template for testing. -->
    <xsl:template match="mods:relatedItem">
        <div>
            <span class="title">
                <xsl:choose>
                    <xsl:when test="mods:titleInfo">
                        <xsl:apply-templates select="mods:titleInfo"/>
                    </xsl:when>
                    <xsl:otherwise>[untitled]</xsl:otherwise>
                </xsl:choose>
            </span>
            <span class="creator">
                <xsl:value-of select="mods:name/mods:displayForm" separator=", "/>
            </span>
        </div>
    </xsl:template>
    <xsl:template match="mods:titleInfo">
        <xsl:if test="mods:nonSort">
            <xsl:value-of select="concat(mods:nonSort, ' ')"/>
        </xsl:if>
        <xsl:value-of select="mods:title/text()"/>
    </xsl:template>
    <xsl:template match="host">
        <i>
            <xsl:apply-templates select="mods:mods/mods:titleInfo"/>
        </i>
        <xsl:text>, </xsl:text>
        <xsl:apply-templates select="mods:mods/mods:part[@type='issue']"/>
        <xsl:text> (</xsl:text>
        <xsl:apply-templates select="mods:mods/mods:originInfo"/>
        <xsl:text>)</xsl:text>
    </xsl:template>
    <xsl:template match="mods:part">
        <xsl:if test="mods:detail[@type='volume']">
            <xsl:apply-templates select="mods:detail[@type='volume']"/>
            <xsl:text>, </xsl:text>
        </xsl:if>
        <xsl:if test="mods:detail[@type='number']">
            <xsl:apply-templates select="mods:detail[@type='number']"/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="mods:detail">
        <xsl:choose>
            <xsl:when test="mods:caption">
                <xsl:value-of select="mods:caption"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="mods:number"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="mods:originInfo">
        <xsl:value-of select="mods:dateIssued[empty(@keyDate)]"/>
    </xsl:template>
</xsl:stylesheet>