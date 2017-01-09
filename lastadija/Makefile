build: index.xml index.xsl stuff.xml stuff.xsl
	mkdir -p ru lv
	xsltproc --noout --stringparam lang lv index.xsl index.xml
	xsltproc --noout --stringparam lang ru index.xsl index.xml
	xsltproc --noout --stringparam lang lv stuff.xsl stuff.xml
	xsltproc --noout --stringparam lang ru stuff.xsl stuff.xml
        