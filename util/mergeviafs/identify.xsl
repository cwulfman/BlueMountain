<?xml version="1.0" encoding="utf-8"?>

<!-- Stylesheet for inserting viaf ids into Blue Mountain mets -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:local="http://diglib.princeton.edu"
    exclude-result-prefixes="xs mods mets" version="2.0">
    
    
    <xsl:variable name="viaftable" select="document('names.xml')" />
    
    <xsl:variable name="bmtnid" select="substring-after(.//mods:relatedItem[@type='host']/@xlink:href, 'urn:PUL:bluemountain:')"/>
    
    <xsl:output
        method="xml"
        encoding="UTF-8"
        indent="yes" />
    
    <xsl:function name="local:viafid-from-displayForm">
        <xsl:param name="name-string" as="xs:string?"/>
        <xsl:choose>
            <xsl:when test="$name-string">
                <xsl:value-of select="$viaftable//name[@bmtnid = $bmtnid and . = $name-string]/@viaf"/>
            </xsl:when>
        </xsl:choose>
    </xsl:function>
    
    
    
    <xsl:template match="mods:name">
        <xsl:variable name="display-string" select="mods:displayForm/text()" />
        <xsl:variable name="viafid" select="local:viafid-from-displayForm($display-string)"/>
        <mods:name>
            <xsl:attribute name="type" select="@type"/>
            <xsl:if test="$viafid">
                <xsl:attribute name="authority">viaf</xsl:attribute>
                <xsl:attribute name="valueURI"><xsl:value-of select="$viafid"/></xsl:attribute>
            </xsl:if>
            <xsl:apply-templates />
        </mods:name>
        
    </xsl:template>
    
    <xsl:template match="/">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="mets:mets/@xsi:schemaLocation">
        <xsl:attribute name="xsi:schemaLocation">http://www.loc.gov/METS/ http://www.loc.gov/standards/mets/mets.xsd http://www.loc.gov/mix/ http://schema.ccs-gmbh.com/docworks/version20/mix_jp2.xsd http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd</xsl:attribute>
    </xsl:template>
    
    <!--  Identity Transform --> 
    <xsl:template match="@*|*|processing-instruction()|comment()">
        <xsl:copy>
            <xsl:apply-templates select="*|@*|text()|processing-instruction()|comment()"/>
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>
