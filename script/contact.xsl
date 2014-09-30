<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:arch="http://purl.org/archival/vocab/arch#"
	xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:nwda="https://github.com/ewg118/nwda-editor#"
	exclude-result-prefixes="xsl xs arch dcterms foaf rdf xsd vcard nwda" version="1.0">
	<xsl:output method="xml" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Northwest Digital Archives | contact us</title>
				<link href="nwda.css" rel="stylesheet" type="text/css"/>
				<script src="scripts/AC_RunActiveContent.js" type="text/javascript"/>
				<script src="scripts/AC_ActiveX.js" type="text/javascript"/>
			</head>

			<body>
				<!--#include file="nav.html"-->
				<div id="wrapper">
					<div id="content">
						<h2>contact us</h2>
						<xsl:apply-templates select="descendant::arch:Archive">
							<xsl:sort select="foaf:name"/>
						</xsl:apply-templates>
					</div>
				</div>
				<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
				<!--script type="text/javascript">
					var pageTracker = _gat._getTracker("UA-3516166-1");
					pageTracker._initData();
					pageTracker._trackPageview();
					</script-->
				<script type="text/javascript">
if (typeof(_gat) == "object") {
	var pageTracker = _gat._getTracker("UA-3516166-1");
	pageTracker._setLocalRemoteServerMode();
	pageTracker._trackPageview();
}
</script>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="arch:Archive">
		<div>
			<xsl:choose>
				<xsl:when test="foaf:homepage/@rdf:resource">
					<a href="{foaf:homepage/@rdf:resource}">
						<xsl:value-of select="foaf:name"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="foaf:name"/>
				</xsl:otherwise>
			</xsl:choose>

			<xsl:if test="nwda:visitation or nwda:facsimile or dcterms:description">
				<dl>
					<xsl:apply-templates select="dcterms:description"/>
					<xsl:apply-templates select="nwda:facsimile"/>
					<xsl:apply-templates select="nwda:visitation"/>
				</dl>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template match="nwda:visitation|nwda:facsimile|dcterms:description">
		<dt>
			<xsl:choose>
				<xsl:when test="name()='nwda:visitation'">Visitation Info</xsl:when>
				<xsl:when test="name()='nwda:facsimile'">Copy Info</xsl:when>
				<xsl:when test="name()='dcterms:description'">Collection Info</xsl:when>
			</xsl:choose>
		</dt>
		<dd>
			<xsl:choose>
				<xsl:when test="string(@rdf:resource)">
					<a href="{@rdf:resource}">
						<xsl:value-of select="@rdf:resource"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
				</xsl:otherwise>
			</xsl:choose>
		</dd>
	</xsl:template>

</xsl:stylesheet>
