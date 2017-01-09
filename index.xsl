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

  <xsl:template match="site">
    <html>
      <head>
        <meta charset="utf-8"/>
        <title>
          <xsl:value-of select="homepage/title/text[@lang=$lang]"/>
        </title>
      </head>
      <body>
        <section>
          <xsl:apply-templates select="homepage/header/text[@lang=$lang]"/>
        </section>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="people/person">
    <img src="{avatar}"/>
    <xsl:value-of select="short-name"/>
  </xsl:template>
</xsl:stylesheet>
