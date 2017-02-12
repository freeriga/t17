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

  <!--
  <xsl:template name="translate-">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">
      </xsl:when>
      <xsl:when test="$lang = 'ru'">
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  -->

  <xsl:variable name="title">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">Tikšanās ar Lastādiju</xsl:when>
      <xsl:when test="$lang = 'ru'">Встреча с Ластадией</xsl:when>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:template name="translate-meeting-with-lastadija">
    <xsl:value-of select="$title"/>
  </xsl:template>

  <xsl:template name="translate-byline">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">
        veidoja
        <a href="https://www.facebook.com/FREERIGA/"><b>Free Riga</b></a>,
        <a href="http://t17.lv"><b>T17</b></a>
        un
        <b>LU antropoloģijas studenti</b>
        2016, 2017
      </xsl:when>
      <xsl:when test="$lang = 'ru'">
        составлена
        при сотрудничестве <a href="https://www.facebook.com/FREERIGA/"><b>Free Рига</b></a>, <a href="http://t17.lv"><b>T17</b></a> со студентами антропологии ЛY
        2016, 2017
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  
  <xsl:variable name="appid">716860265144744</xsl:variable>

  <xsl:variable name="url">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">https://t17.lv/lastadija/lv/</xsl:when>
      <xsl:when test="$lang = 'ru'">https://t17.lv/lastadija/ru/</xsl:when>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="locale">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">lv_LV</xsl:when>
      <xsl:when test="$lang = 'ru'">ru_RU</xsl:when>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:variable name="description">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">Vai pazīsti apkaimi aiz Centrāltirgus jeb tuvējo Maskačku? Ar īpašu karti aicinām uz “Tikšanos ar Lastādiju” - Rīgās senāko priekšpilsētu. Kartē apkopoti 25 apkaimei raksturīgu vietu apraksti, kas radīti sarunās ar cilvēkiem, kas šeit dzīvo, strādā un pavada savu ikdienu.</xsl:when>
      <xsl:when test="$lang = 'ru'">Знакомы ли вы с окрестностью сразу за центральным рынком или началом Maскачки? С помощью специальной карты приглашаем вас на "Встречи с Ластадией" - старейшим пригородом Риги. На карте собраны ​​25 описания характерных мест окрестности, созданных через разговоры с людьми, которые здесь живут, работают и проводят свою повседневную жизнь.</xsl:when>
    </xsl:choose>
  </xsl:variable>
  
  <xsl:template name="translate-about-map">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">Par karti</xsl:when>
      <xsl:when test="$lang = 'ru'">О карте</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="translate-submit-story">
    <xsl:choose>
      <xsl:when test="$lang = 'lv'">Iesniegt stāstu</xsl:when>
      <xsl:when test="$lang = 'ru'">Послать историю</xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="facebook-init-script">
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
         js.src = "//connect.facebook.net/<xsl:value-of select="$locale"/>/sdk.js";
         fjs.parentNode.insertBefore(js, fjs);
       }(document, 'script', 'facebook-jssdk'));
    </script>
  </xsl:template>
  
  <xsl:template match="places">
    <exsl:document
        href="{$lang}/index.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="map" data-lang="{$lang}">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../</xsl:with-param>
          </xsl:call-template>
  
          <meta property="fb:app_id" content="{$appid}"/>
          <meta property="og:url" content="{$url}"/>
          <meta property="og:locale" content="{$locale}"/>
          <meta property="og:title" content="{$title}"/>
          <meta property="og:description" content="{$description}"/>
          <meta property="og:type" content="website"/>
          <meta property="og:image"
                content="https://t17.lv/lastadija/{$lang}/banner.png"/>
          <meta property="og:image:width" content="1200"/>
          <meta property="og:image:height" content="630"/>
  
          <title>
            <xsl:value-of select="$title"/>
          </title>
        </head>
        <body>
          <xsl:call-template name="facebook-init-script"/>
          <section class="index-column">
            <h1>
              <xsl:call-template name="translate-meeting-with-lastadija"/>
              <span class="language-choices">
                <xsl:choose>
                  <xsl:when test="$lang = 'lv'">
                    <a href="../ru">Русский</a>
                  </xsl:when>
                  <xsl:when test="$lang = 'ru'">
                    <a href="../lv">Latviešu</a>
                  </xsl:when>
                </xsl:choose>
              </span>
              <a href="par-karti">
                ❓
                <xsl:call-template name="translate-about-map"/>
              </a>
              <a id="submitlink" href="papildinat-karti">
                ✎
                <xsl:call-template name="translate-submit-story"/>
              </a>
            </h1>
            <ul class="stories">
              <aside>
                <div class="fb-like"
                     data-layout="button_count"
                     data-action="like"
                     data-size="large"
                     data-show-faces="true"
                     data-share="true">
                </div>
                <xsl:value-of select="$description"/>

              </aside>
              <xsl:apply-templates select="place" mode="index"/>
            </ul>
          </section>
          <section class="map-column">
            <div class="map" id="mapelement"/>
            <footer>
              <span>
                <xsl:call-template name="translate-byline"/>
              </span>
            </footer>
          </section>
          <script src="../../smoothscroll.js"></script>
          <script src="../index.js"></script>
        </body>
      </html>
    </exsl:document>
    <exsl:document
        href="{$lang}/banner.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="root-banner" data-lang="{$lang}">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../</xsl:with-param>
          </xsl:call-template>
        </head>
        <body>
          <header>
            <h1>
              <xsl:call-template name="translate-meeting-with-lastadija"/>
            </h1>
          </header>
          <ul class="stories">
            <xsl:apply-templates select="place" mode="index"/>
          </ul>
          <div class="map" id="mapelement"/>
          <script src="../index.js"></script>
        </body>
      </html>
    </exsl:document>
    <xsl:apply-templates select="place" mode="place-file"/>
  </xsl:template>

  <xsl:template match="place" mode="index">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$lang = 'lv'">
          <xsl:value-of select="name"/>
        </xsl:when>
        <xsl:when test="$lang = 'ru'">
          <xsl:value-of select="russian-name"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="has-story">
      <xsl:choose>
        <xsl:when test="$lang = 'lv' and story">true</xsl:when>
        <xsl:when test="$lang = 'ru' and russian-story">true</xsl:when>
      </xsl:choose>
    </xsl:variable>
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
            <xsl:when test="$has-story = 'true'">
              <a class="name" href="stasts/{@id}" target="{@id}">
                <b><xsl:value-of select="$name" /></b>
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a class="name" href="stasts/{@id}" target="{@id}">
                <xsl:value-of select="$name" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </span>
      </h3>
      <div class="summary">
        <span>
        </span>
        <p>
          <xsl:choose>
            <xsl:when test="$lang = 'lv'">
              <xsl:apply-templates select="snippet"/>
            </xsl:when>
            <xsl:when test="$lang = 'ru'">
              <xsl:apply-templates select="russian-snippet"/>
            </xsl:when>
          </xsl:choose>
        </p>
      </div>
    </li>
  </xsl:template>

  <xsl:template match="place" mode="place-file">
    <xsl:variable name="name">
      <xsl:choose>
        <xsl:when test="$lang = 'lv'">
          <xsl:value-of select="name"/>
        </xsl:when>
        <xsl:when test="$lang = 'ru'">
          <xsl:value-of select="russian-name"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="snippet">
      <xsl:choose>
        <xsl:when test="$lang = 'lv'">
          <xsl:value-of select="snippet"/>
        </xsl:when>
        <xsl:when test="$lang = 'ru'">
          <xsl:value-of select="russian-snippet"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="story">
      <xsl:choose>
        <xsl:when test="$lang = 'lv'">
          <xsl:apply-templates select="story"/>
        </xsl:when>
        <xsl:when test="$lang = 'ru'">
          <xsl:apply-templates select="russian-story"/>
        </xsl:when>
      </xsl:choose>
    </xsl:variable>

    <xsl:variable name="has-story">
      <xsl:choose>
        <xsl:when test="$lang = 'lv' and story">true</xsl:when>
        <xsl:when test="$lang = 'ru' and russian-story">true</xsl:when>
      </xsl:choose>
    </xsl:variable>
    
    <exsl:document
        href="{$lang}/stasts/{@id}/banner.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="banner">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../../../</xsl:with-param>
          </xsl:call-template>
        </head>
        <body>
          <span id="index"><xsl:number/></span>
          <section class="map" id="banner-map"
                   data-coords="{./location/latitude}, {./location/longitude}">
          </section>
          <header>
            <h1>
              <div><xsl:value-of select="$title"/></div>
            </h1>
            <h2>
              <div><xsl:value-of select="$name"/></div>
            </h2>
          </header>
          <script src="../../../banner.js"></script>
        </body>
      </html>
    </exsl:document>
    <exsl:document
        href="{$lang}/stasts/{@id}/index.html"
        method="html"
        indent="yes"
        doctype-system="about:legacy-compat"
        encoding="utf-8">
      <html class="story">
        <head>
          <xsl:call-template name="common-meta">
            <xsl:with-param name="prefix">../../../</xsl:with-param>
          </xsl:call-template>
          <title>
            <xsl:value-of select="$name"/> (<xsl:value-of select="$title"/>)
          </title>
          <meta property="og:url" content="https://t17.lv/lastadija/{$lang}/stasts/{@id}/"/>
          <meta property="og:type" content="place"/>
          <meta property="fb:app_id" content="{$appid}"/>
          <meta property="og:locale" content="{$locale}"/>
          <meta property="og:title" content="{$name}"/>
          <meta property="og:description" content="{$snippet}"/>
          <meta property="og:image"
                content="https://t17.lv/lastadija/{$lang}/stasts/{@id}/banner.png"/>
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
              var params = {};
              params[FB.AppEvents.ParameterNames.CONTENT_ID] = "<xsl:value-of select="@id"/>";
              FB.AppEvents.logEvent("View place", null, params);
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
            <h1><a href="../..">◂ <xsl:value-of select="$title"/></a></h1>
          </header>
          <article data-coords="{./location/latitude}, {./location/longitude}">
            <h3>
              <span id="index"><xsl:number/></span>.&#160;&#160;<xsl:value-of select="$name"/>
            </h3>
            <section class="map" id="mapelement"></section>
            <xsl:choose>
              <xsl:when test="$has-story = 'true'">
                <p class="snippet"><xsl:value-of select="$snippet"/></p>
                <xsl:copy-of select="$story"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="$snippet"/>
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
            <div class="fb-like" data-layout="button_count" data-action="like" data-size="large" data-show-faces="true" data-share="true"></div>
          </article>
          <script src="../../../stasts.js"></script>
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
