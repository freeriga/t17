<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns="http://www.w3.org/1999/xhtml"
    extension-element-prefixes="exsl">
  
  <xsl:output
      method="html"
      indent="yes"
      doctype-system="about:legacy-compat"
      encoding="utf-8"/>

  <xsl:template match="places">
    <html class="tiksanas">
      <head>
        <xsl:call-template name="common-meta"/>
        <title>Tikšanās ar Lastādiju</title>
      </head>
      <body>
        <header>
          <h1 title="Vai pazīsti apkaimi aiz Centrāltirgus jeb tuvējo Maskačku? Ar īpašu karti aicinām uz “Tikšanos ar Lastādiju” - Rīgās senāko priekšpilsētu. Kartē apkopoti 25 apkaimei raksturīgu vietu apraksti, kas radīti sarunās ar cilvēkiem, kas šeit dzīvo, strādā un pavada savu ikdienu.">Tikšanās ar Lastādiju</h1>
          <h2>
            veidoja
            <a href="https://www.facebook.com/FREERIGA/"><b>Free Riga</b></a>,
            <a href="http://t17.lv"><b>T17</b></a>
            un
            <b>LU antropoloģijas studenti</b>
          </h2>
          <a href="about">par karti</a>
          <a id="submitlink" href="submit">papildināt karti</a>
        </header>
        <section class="map" id="mapelement"></section>
        <section class="stories">
          <xsl:apply-templates select="place" mode="index"/>
        </section>
        <script src="index.js"></script>
      </body>
    </html>
    <xsl:apply-templates select="place" mode="place-file"/>
  </xsl:template>

  <xsl:template match="place" mode="index">
    <article
        data-coords="{./location}"
        data-has-story="{boolean(./story)}"
        data-id="{@id}">
      <h3>
        <span class="number-container">
          <span class="number"><xsl:number/></span>
        </span>
        <span class="name-container">
          <xsl:choose>
            <xsl:when test="story">
              <a class="name" href="{@id}.html" target="_blank">
                <xsl:value-of select="name" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <span class="name"><xsl:value-of select="name" /></span>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </h3>
      <p class="summary">
        <xsl:apply-templates select="snippet"/>
      </p>
    </article>
  </xsl:template>

  <xsl:template match="place" mode="place-file">
    <exsl:document
        href="{@id}.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html>
        <head>
          <xsl:call-template name="common-meta"/>
          <title><xsl:value-of select="./name"/> (Tikšanās ar Lastādiju)</title>
        </head>
        <body class="story">
          <header>
            <h1>
              <xsl:value-of select="name"/>
            </h1>
            <h2>
              <a href="./" style="font-weight: 500">Tikšanās ar Lastādiju</a>
            </h2>
          </header>
          <section class="map" id="mapelement"></section>
          <aside data-coords="{./location}">
            <span id="index"><xsl:number/></span>
            <xsl:apply-templates select="story"/>

            <xsl:choose>
              <xsl:when test="following-sibling::place[story][1]">
                
                Nākamā vieta: <a href="{following-sibling::place[story][1]/@id}.html"><xsl:value-of select="following-sibling::place[story][1]/name"/></a>
              </xsl:when>
              <xsl:otherwise>
                <a href="./">

                Atpakaļ uz karti</a>
              </xsl:otherwise>
            </xsl:choose>
          </aside>
          <script src="place.js"></script>
        </body>
      </html>
    </exsl:document>
  </xsl:template>

  <xsl:template name="common-meta">
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="../map/leaflet.css"/>
    <link rel="stylesheet" href="../font.css"/>
    <link rel="stylesheet" href="index.css"/>
    <script src="../map/leaflet.js"></script>
  </xsl:template>
  
</xsl:stylesheet>
