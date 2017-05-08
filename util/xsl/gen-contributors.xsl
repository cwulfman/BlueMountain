<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 30, 2017</xd:p>
            <xd:p><xd:b>Author:</xd:b> cwulfman</xd:p>
            <xd:p/>
        </xd:desc>
    </xd:doc>

    <xd:doc>
        <xd:desc>
            <xd:p>The root of the path where files should be written. Defaults to
                <xd:i>/tmp</xd:i>.</xd:p>
        </xd:desc>
    </xd:doc>
    <xsl:param name="pathroot" as="xs:string">
        <xsl:text>/tmp/bmtn</xsl:text>
    </xsl:param>

    <xsl:template match="/">
        <xsl:apply-templates mode="index"/>
        <xsl:apply-templates select="contributors/contributor" mode="pages"/>
    </xsl:template>



    <xsl:template match="contributors" mode="index">
        <xsl:result-document href="{ concat($pathroot, '/contributors/index.html') }" method="html"
            version="5.0" encoding="UTF-8" indent="yes">

            <html>
                <head>
                    <title>Contributors</title>
                    <meta charset="utf-8"/>
                </head>
                <body>
                    <nav id="navbar">
                        <ul>
                            <li>
                                <a href="#">Home</a>
                            </li>
                            <li>
                                <a href="#">Catalog</a>
                            </li>
                            <li>
                                <a href="#">Index</a>
                            </li>
                        </ul>
                    </nav>
                    <header>
                        <h1>Blue Mountain Contributor Index</h1>
                    </header>
                    <main>
                        <ol>
                            <xsl:apply-templates mode="index"/>
                        </ol>
                    </main>
                </body>
            </html>

        </xsl:result-document>
    </xsl:template>

    <xsl:template match="contributor" mode="index">
        <li>
            <a href="{ concat($pathroot, '/contributors/',person/@id, '.html') }">
            <xsl:apply-templates select="person" mode="#current"/>
            </a>
        </li>
    </xsl:template>

    <xsl:template match="person" mode="index">
        <xsl:choose>
            <xsl:when test="prefLabel">
                <xsl:value-of select="prefLabel"/>
            </xsl:when>

            <xsl:otherwise>
                <xsl:text>[No Name]</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="contributor" mode="pages">
        <xsl:result-document href="{ concat($pathroot, '/contributors/',person/@id, '.html') }" method="html"
            version="5.0" encoding="UTF-8" indent="yes">
            <html>
                <head>
                    <title><xsl:value-of select="person/prefLabel"/></title>
                    <meta charset="utf-8"/>
                </head>
                <body>
                    <main>
                        <ul>
                        <xsl:apply-templates select="constituent" />
                        </ul>
                    </main>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="constituent">
        <li><xsl:value-of select="displayTitle"/></li>
    </xsl:template>

</xsl:stylesheet>
