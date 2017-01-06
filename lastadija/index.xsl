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
    <html class="map">
      <head>
        <xsl:call-template name="common-meta"/>
        <meta property="fb:app_id" content="716860265144744"/>
        <meta property="og:url" content="https://t17.lv/lastadija/"/>
        <meta property="og:type" content="website"/>
        <meta property="og:locale" content="lv_LV"/>
        <meta property="og:title" content="Tikšanās ar Lastādiju"/>
        <meta property="og:description" content="Vai pazīsti apkaimi aiz Centrāltirgus jeb tuvējo Maskačku? Ar īpašu karti aicinām uz “Tikšanos ar Lastādiju” - Rīgās senāko priekšpilsētu. Kartē apkopoti 25 apkaimei raksturīgu vietu apraksti, kas radīti sarunās ar cilvēkiem, kas šeit dzīvo, strādā un pavada savu ikdienu."/>
        <title>Tikšanās ar Lastādiju</title>
      </head>
      <body>
        <script>
          window.fbAsyncInit = function() {
            FB.init({
              appId      : '716860265144744',
              xfbml      : true,
              version    : 'v2.8'
            });
            FB.AppEvents.logPageView();
          };
        
          (function(d, s, id){
             var js, fjs = d.getElementsByTagName(s)[0];
             if (d.getElementById(id)) {return;}
             js = d.createElement(s); js.id = id;
             js.src = "//connect.facebook.net/lv_LV/sdk.js";
             fjs.parentNode.insertBefore(js, fjs);
           }(document, 'script', 'facebook-jssdk'));
        </script>
        <section class="index-column">
          <h1>
            Tikšanās ar Lastādiju
            <a href="par-karti">❓ Par karti</a>
            <a id="submitlink" href="papildinat-karti">✎ Iesniegt stāstu</a>
          </h1>
          <ul class="stories">
            <aside>
              Vai pazīsti apkaimi aiz Centrāltirgus jeb tuvējo Maskačku? Ar īpašu karti aicinām uz “Tikšanos ar Lastādiju” - Rīgās senāko priekšpilsētu. Kartē apkopoti 25 apkaimei raksturīgu vietu apraksti, kas radīti sarunās ar cilvēkiem, kas šeit dzīvo, strādā un pavada savu ikdienu.
            </aside>
            <xsl:apply-templates select="place" mode="index"/>
          </ul>
        </section>
        <section class="map-column">
          <div class="map" id="mapelement"/>
          <footer>
            veidoja
            <a href="https://www.facebook.com/FREERIGA/"><b>Free Riga</b></a>,
            <a href="http://t17.lv"><b>T17</b></a>
            un
            <b>LU antropoloģijas studenti</b>
            2016, 2017
          </footer>
        </section>
        <script src="../smoothscroll.js"></script>
        <script src="index.js"></script>
      </body>
    </html>
    <xsl:apply-templates select="place" mode="place-file"/>
  </xsl:template>

  <xsl:template match="place" mode="index">
    <li
        class="place"
        data-coords="{./location/latitude}, {./location/longitude}"
        data-has-story="{boolean(./story)}"
        data-id="{@id}">
      <h3>
        <span class="number-container">
          <span class="number"><xsl:number/></span>
        </span>
        <span class="name-container">
          <xsl:choose>
            <xsl:when test="story">
              <a class="name" href="stasts/{@id}" target="{@id}">
                <b><xsl:value-of select="name" /></b>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a class="name" href="stasts/{@id}" target="{@id}">
                <xsl:value-of select="name" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </h3>
      <div class="summary">
        <span>
        </span>
        <p>
          <xsl:apply-templates select="snippet"/>
        </p>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="place" mode="place-file">
    <exsl:document
        href="stasts/{@id}/banner.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="banner">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../../</xsl:with-param>
          </xsl:call-template>
        </head>
        <body>
          <span id="index"><xsl:number/></span>
          <section class="map" id="banner-map"
                   data-coords="{./location/latitude}, {./location/longitude}">
          </section>
          <header>
            <h1>
              <div>Tikšanās ar</div>
              <div>Lastādiju</div>
            </h1>
            <h2>
              <div><xsl:value-of select="name"/></div>
            </h2>
          </header>
          <script src="../../banner.js"></script>
        </body>
      </html>
    </exsl:document>
    <exsl:document
        href="stasts/{@id}/index.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="story">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../../</xsl:with-param>
          </xsl:call-template>
          <title><xsl:value-of select="./name"/> (Tikšanās ar Lastādiju)</title>
          <meta property="og:url" content="https://t17.lv/lastadija/stasts/{@id}/"/>
          <meta property="og:type" content="place"/>
          <meta property="fb:app_id" content="716860265144744"/>
          <meta property="og:locale" content="lv_LV"/>
          <meta property="og:title" content="{name}"/>
          <meta property="og:description" content="{snippet}"/>
          <meta property="og:image"
                content="https://t17.lv/lastadija/stasts/{@id}/banner.png"/>
          <meta property="og:image:width" content="1200"/>
          <meta property="og:image:height" content="630"/>
          <meta property="place:location:latitude" content="{location/latitude}"/>
          <meta property="place:location:longitude" content="{location/longitude}"/>
        </head>
        <body>
          <script>
            window.fbAsyncInit = function() {
              FB.init({
                appId      : '716860265144744',
                xfbml      : true,
                version    : 'v2.8'
              });
              FB.AppEvents.logPageView();
            };
          
            (function(d, s, id){
               var js, fjs = d.getElementsByTagName(s)[0];
               if (d.getElementById(id)) {return;}
               js = d.createElement(s); js.id = id;
               js.src = "//connect.facebook.net/lv_LV/sdk.js";
               fjs.parentNode.insertBefore(js, fjs);
             }(document, 'script', 'facebook-jssdk'));
          </script>
          <header>
            <h1><a href="../..">◂ Tikšanās ar Lastādiju</a></h1>
          </header>
          <article data-coords="{./location/latitude}, {./location/longitude}">
            <h3>
              <span id="index"><xsl:number/></span>.&#160;&#160;<xsl:value-of select="name"/>
            </h3>
            <section class="map" id="mapelement"></section>
            <xsl:choose>
              <xsl:when test="story">
                <p class="snippet"><xsl:apply-templates select="snippet"/></p>
                <xsl:apply-templates select="story"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:apply-templates select="snippet"/>
              </xsl:otherwise>
            </xsl:choose>

            <nav>
              <xsl:if test="preceding-sibling::place[1]">
                <span class="prev">
                  <span class="arrow">←</span>&#160;<a href="../{preceding-sibling::place[1]/@id}"><xsl:value-of select="preceding-sibling::place[1]/name"/></a>
                </span>
              </xsl:if>
              <xsl:if test="following-sibling::place[1]">
                <span class="next">
                  <a href="../{following-sibling::place[1]/@id}"><xsl:value-of select="following-sibling::place[1]/name"/></a>&#160;<span class="arrow">→</span> 
                </span>
              </xsl:if>
            </nav>
            <div
                class="fb-like"
                data-share="true"
                data-width="450"
                data-show-faces="true">
            </div>
          </article>
          <script src="../../stasts.js"></script>
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
