<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:exsl="http://exslt.org/common"
    xmlns="http://www.w3.org/1999/xhtml"
    extension-element-prefixes="exsl">

  <xsl:template match="stuff">
    <xsl:apply-templates match="about-map"/>
    <xsl:apply-templates match="story-form"/>
  </xsl:template>

  <xsl:template match="story-form">
    <exsl:document
        href="{$lang}/papildinat-karti/index.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html>
        <head>
          <link rel="stylesheet" href="../../papildinat-karti.css"/>
          <link rel="stylesheet" href="../../../font.css"/>
          <title><xsl:value-of select="title[@lang=$lang]"/></title>
        </head>
        <body>
          <header>
            <h1>
              <xsl:value-of select="title[@lang=$lang]"/>
            </h1>
            <h2>
              <a href="..">
                <xsl:value-of select="/stuff/title[@lang=$lang]"/>
              </a>
            </h2>
          </header>
          <xsl:apply-templates select="p[@lang=$lang] | snippet-examples | form"/>
        </body>
      </html>
    </exsl:document>
  </xsl:template>

  <xsl:template match="snippet-examples">
    <ul><xsl:apply-templates select="example[@lang=$lang]"/></ul>
  </xsl:template>
  
  <xsl:template match="snippet-examples/example">
    <li title="{snippet}"><span><xsl:value-of select="name"/></span></li>
  </xsl:template>
  
  <xsl:template match="about-map">
    <xsl:variable name="title">
      <xsl:value-of select="title[@lang=$lang]"/>
    </xsl:variable>
    
    <exsl:document
        href="{$lang}/par-karti/index.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html>
        <head>
          <link rel="stylesheet" href="../../par-karti.css"/>
          <link rel="stylesheet" href="../../../font.css"/>
          <title><xsl:value-of select="$title"/></title>
        </head>
        <body>
          <article>
            <xsl:apply-templates select="text[@lang=$lang]"/>
          </article>
          <div class="people">
            <xsl:apply-templates select="people/person"/>
          </div>
        </body>
      </html>
    </exsl:document>
  </xsl:template>

  <xsl:template match="about-map/people/person">
    <div class="person">
      <img src="{avatar}"/>
      <div>
        <div class="name"><xsl:value-of select="name"/></div>
        <div class="job"><xsl:value-of select="job[@lang=$lang]"/></div>
      </div>
    </div>
  </xsl:template>
  
  <xsl:template match="p">
    <p><xsl:apply-templates/></p>
  </xsl:template>

  <xsl:template match="b">
    <b><xsl:apply-templates/></b>
  </xsl:template>

  <xsl:template match="form">
    <form method="POST" action="{@action}">
      <xsl:apply-templates />
    </form>
  </xsl:template>

  <xsl:template match="input">
    <label>
      <span><xsl:apply-templates/></span>
      <input name="{@name}"
             autofocus="{@autofocus}"
             placeholder="{@placeholder}"/>
    </label>
  </xsl:template>

  <xsl:template match="textarea">
    <label>
      <span><xsl:apply-templates/></span>
      <textarea name="{@name}"/>
    </label>
  </xsl:template>

  <xsl:template match="submit">
    <input type="submit" value="{.}"/>
  </xsl:template>
  
</xsl:stylesheet>
