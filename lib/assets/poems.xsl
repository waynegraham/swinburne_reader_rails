<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
    
    <!-- Utility components -->
    <xsl:template match="div">
        <!-- TODO fix xml:id use -->
        <div class="{@xml:id}"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="p">
        <xsl:choose>
            <xsl:when test="@rend">
                <p class="{@rend}"><xsl:apply-templates></xsl:apply-templates></p>
            </xsl:when>
            <xsl:otherwise>
                <p><xsl:apply-templates/></p>
            </xsl:otherwise>
        </xsl:choose>
       
    </xsl:template>
    
    <xsl:template match="emph">
        <em><xsl:apply-templates/></em>
    </xsl:template>
    
    <xsl:template match="lb">
        <br/>
    </xsl:template>
    
    <xsl:template match="hi">
        <span class="{@rend}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="pb">
        <span class="pb" id="{@n}"><xsl:value-of select="@n"/></span>
    </xsl:template>
    
    <!-- title page -->
    <xsl:template match="titlePage">
        <section id="title-page"><xsl:apply-templates /></section>
    </xsl:template>
    
    <xsl:template match="docTitle">
        <div class="doc-title"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="titlePart">
        <div class="title-part {@type}"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="byline">
        <div class="byline">
            <xsl:apply-templates />
        </div>
    </xsl:template>
    
    <xsl:template match="docAuthor">
        <div class="doc-author"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="docImprint">
        <div class="doc-imprint"><xsl:apply-templates/></div>
    </xsl:template>
    
    <!-- Poems -->
    <xsl:template match="div[@type='poem']">
        <div class="container">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="div[@type='verso']">
        <!-- TODO: put this in the div logic -->
        <div class="col-md-6 col-md-offset-3">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
        
    <xsl:template match="div[@type='recto']">
        <!-- TODO: put this in the div logic -->
        <div class="col-md-6 col-md-offset-3">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="head">
        <h1 class="{@rend}"><xsl:apply-templates/></h1>
    </xsl:template>
       
    <xsl:template match="lg">
        <div class="linegroup">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="l">
        <!-- TODO: get more sophisticated -->
        <p id="{@n}" class="line {@rend}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="sp">
        <div class="speech"><xsl:apply-templates/></div>
    </xsl:template>
    
    <xsl:template match="speaker">
        <span class="speaker {@rend}"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="dateline">
        <!-- TODO -->
    </xsl:template>
    
    <xsl:template match="note">
        <!-- TODO -->
    </xsl:template>
    
    <!-- apparatus -->
    <xsl:template match="app">
        <span data-lem="{lem[@wit]}" data-reading-type="{rdgGrp[@type]}">
            <xsl:apply-templates select="lem"/>
            <span class="readings">
                <xsl:for-each select="rdgGrp/rdg">
                    <span class="witness" data-wit="{@wit}"><xsl:value-of select="node()"/></span>
                </xsl:for-each>
            </span>
        </span> 
    </xsl:template>
    

    
</xsl:stylesheet>