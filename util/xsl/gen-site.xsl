<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Apr 28, 2017</xd:p>
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
        <xsl:apply-templates/>
    </xsl:template>



    <xsl:template match="magazines">
        <xsl:result-document href="{ concat($pathroot, '/magazines/index.html') }" method="html"
            version="5.0" encoding="UTF-8" indent="yes">

            <html>
                <head>
                    <title>Magazines</title>
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
                        <h1>Blue Mountain Magazine Catalog</h1>
                    </header>
                    <main>
                        <dl>
                            <xsl:apply-templates select="magazine" mode="index"/>
                        </dl>
                    </main>
                </body>
            </html>
        </xsl:result-document>
        <xsl:apply-templates select="magazine" mode="page"/>
    </xsl:template>

    <xsl:template match="magazine" mode="index">
        <dt>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="link"/>
                </xsl:attribute>
                <xsl:apply-templates select="displayTitle"/>
            </a>
        </dt>
        <dd>Published <xsl:apply-templates select="dateIssued"/>.</dd>
        <dd>
            <xsl:apply-templates select="abstract"/>
        </dd>

    </xsl:template>

    <xsl:template match="issues" mode="index">
        <ul>
            <xsl:apply-templates mode="#current"/>
        </ul>
    </xsl:template>

    <xsl:template match="issue" mode="index">
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="concat( @id, '/index.html')"/>
                </xsl:attribute>
                <xsl:value-of select="concat(citeTitle, ' (', sortKey, ')')"/>
            </a>
        </li>
    </xsl:template>



    <xsl:template match="magazine" mode="page">
        <xsl:result-document href="{ concat($pathroot, '/magazines/', link) }" method="html"
            version="5.0" encoding="UTF-8" indent="yes">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="displayTitle"/>
                    </title>
                    <meta charset="utf-8"/>
                </head>
                <body>
                    <header>
                        <ol>
                            <li>Blue Mountain</li>
                            <li>
                                <a href="../index.html">Magazines</a>
                            </li>
                            <li>
                                <xsl:value-of select="displayTitle"/>
                            </li>
                        </ol>
                        <h1>
                            <xsl:value-of select="displayTitle"/>
                        </h1>
                        <p class="subhead">
                            <xsl:value-of select="dateIssued"/>
                        </p>
                        <xsl:apply-templates select="thumbnail"/>
                    </header>
                    <nav>
                        <ul>
                            <li>
                                <a href="#issues">Issues</a>
                            </li>
                            <li>
                                <a href="#contributors">Contributors</a>
                            </li>
                        </ul>
                    </nav>
                    <section id="issues">
                        <header>
                            <h2>Issues</h2>
                        </header>
                        <xsl:apply-templates select="issues/issue" mode="index"/>
                        <xsl:apply-templates select="issues/issue" mode="page"/>
                    </section>

                    <section id="contributors">
                        <header>
                            <h2>Contributors</h2>
                        </header>
                        <xsl:apply-templates select="contributors" />
                    </section>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


    <xsl:template match="issue" mode="page">
        <xsl:result-document
            href="{ concat($pathroot, '/magazines/', current()/@magid, '/', current()/@id, '/index.html') }"
            method="html" version="5.0" encoding="UTF-8" indent="yes">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="string-join((citeTitle, citeNumber), ' ')"/>
                    </title>
                    <meta charset="utf-8"/>
                </head>
                <body>
                    <header>
                        <ol>
                            <li>Blue Mountain</li>
                            <li>
                                <a href="../../index.html">Magazines</a>
                            </li>
                            <li>
                                <a href="../index.html">
                                    <xsl:value-of select="ancestor::magazine/displayTitle"/>
                                </a>
                            </li>

                        </ol>
                        <h1>
                            <xsl:value-of select="string-join((citeTitle, citeNumber), ' ')"/>
                        </h1>
                        <p class="subhead">
                            <xsl:value-of select="citeDate"/>
                        </p>
                        <xsl:apply-templates select="thumbnail"/>
                    </header>

                    <section id="toc-section">
                        <xsl:apply-templates select="constituents" mode="list"/>
                    </section>

                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="constituents" mode="table">
        <table id="toc">
            <tr>
                <th>Title</th>
                <th>By</th>
            </tr>
            <xsl:apply-templates mode="#current"/>
            
        </table>
    </xsl:template>
    
    <xsl:template match="constituent" mode="table">
        <tr>
            <td><xsl:value-of select="displayTitle"/></td>
            <td></td>
        </tr>
    </xsl:template>
    
    <xsl:template match="constituents" mode="list">
        <dl id="toc">
            <xsl:apply-templates mode="#current" />
        </dl>
    </xsl:template>
    
    <xsl:template match="constituent" mode="list">
        <dt><xsl:value-of select="displayTitle"/></dt>
        <dd>
            <xsl:for-each select="contributor">
                <xsl:value-of select="@displayForm"/>
                <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </dd>
    </xsl:template>
    
    <xsl:template match="contributors">
        <table>
            <xsl:apply-templates />
        </table>
    </xsl:template>
    
    <xsl:template match="contributor">
        <tr>
            <td><xsl:value-of select="@label"/></td>
            <td><xsl:value-of select="@count"/></td>
        </tr>
        
    </xsl:template>

    <xsl:template match="thumbnail">
        <img src="{current()}" alt="thumbnail"/>
    </xsl:template>



</xsl:stylesheet>
