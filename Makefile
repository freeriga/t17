index2.html: index.xml index.xsl
	xsltproc index.xsl index.xml > index2.html