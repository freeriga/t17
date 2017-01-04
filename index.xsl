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
    <style>
      img { width: 50px; height: 50px; }
    </style>
    <xsl:apply-templates select="people/person"/>
  </xsl:template>

  <xsl:template match="people/person">
    <img src="{avatar}"/>
    <xsl:value-of select="short-name"/>
  </xsl:template>
</xsl:stylesheet>
