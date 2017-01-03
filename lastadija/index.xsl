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
        <section class="left-column map-width">
          <header>
            <div class="map-width">
              <h1>Tikšanās ar Lastādiju</h1>
              <h2>
                veidoja
                <a href="https://www.facebook.com/FREERIGA/"><b>Free Riga</b></a>,
                <a href="http://t17.lv"><b>T17</b></a>
                un
                <b>LU antropoloģijas studenti</b>
              </h2>
            </div>
          </header>
          <aside>
            Vai pazīsti apkaimi aiz Centrāltirgus jeb tuvējo Maskačku? Ar īpašu karti aicinām uz “Tikšanos ar Lastādiju” - Rīgās senāko priekšpilsētu. Kartē apkopoti 25 apkaimei raksturīgu vietu apraksti, kas radīti sarunās ar cilvēkiem, kas šeit dzīvo, strādā un pavada savu ikdienu.
          </aside>
          <div class="map" id="mapelement"/>
        </section>
        <section class="right-column">
          <nav>
            <a href="par-karti">par karti</a>
            <a id="submitlink" href="papildinat-karti">iesniegt stāstu</a>
          </nav>
          <ul class="stories">
            <xsl:apply-templates select="place" mode="index"/>
          </ul>
        </section>
        <script src="index.js"></script>
      </body>
    </html>
    <xsl:apply-templates select="place" mode="place-file"/>
  </xsl:template>

  <xsl:template match="place" mode="index">
    <li
        class="place"
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
              <a class="name" href="stasts/{@id}.html" target="_blank">
                <b><xsl:value-of select="name" /></b>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a class="name" href="stasts/{@id}.html" target="_blank">
                <xsl:value-of select="name" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </h3>
      <p class="summary">
        <xsl:apply-templates select="snippet"/>
      </p>
    </li>
  </xsl:template>

  <xsl:template match="place" mode="place-file">
    <exsl:document
        href="stasts/{@id}.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="story">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../</xsl:with-param>
          </xsl:call-template>
          <title><xsl:value-of select="./name"/> (Tikšanās ar Lastādiju)</title>
        </head>
        <body>
          <header>
            <h1>Tikšanās ar Lastādiju</h1>
            <h2>
              veidoja
              <a href="https://www.facebook.com/FREERIGA/"><b>Free Riga</b></a>,
              <a href="http://t17.lv"><b>T17</b></a>
              un
              <b>LU antropoloģijas studenti</b>
            </h2>
            <h3>
              <span id="index"><xsl:number/></span>.&#160;&#160;<xsl:value-of select="name"/>
            </h3>
          </header>
          <section class="map" id="mapelement"></section>
          <article data-coords="{./location}">
            <xsl:choose>
              <xsl:when test="story">
                <xsl:apply-templates select="story"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="snippet"/>
              </xsl:otherwise>
            </xsl:choose>

            <nav>
              <xsl:if test="preceding-sibling::place[1]">
                <span class="prev">
                  <span class="arrow">←</span> <a href="{preceding-sibling::place[story][1]/@id}.html"><xsl:value-of select="preceding-sibling::place[1]/name"/></a>
                </span>
              </xsl:if>
              <xsl:if test="following-sibling::place[1]">
                <span class="next">
                  <a href="{following-sibling::place[1]/@id}.html"><xsl:value-of select="following-sibling::place[1]/name"/></a> <span class="arrow">→</span> 
                </span>
              </xsl:if>
            </nav>
          </article>
          <script src="../stasts.js"></script>
        </body>
      </html>
    </exsl:document>
  </xsl:template>

  <xsl:template name="common-meta">
    <xsl:param name="prefix"/>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="{$prefix}../map/leaflet.css"/>
    <link rel="stylesheet" href="{$prefix}../font.css"/>
    <link rel="stylesheet" href="{$prefix}index.css"/>
    <script src="{$prefix}../map/leaflet.js"></script>
  </xsl:template>
  
</xsl:stylesheet>
