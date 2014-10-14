<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
	xmlns:nwda="https://github.com/ewg118/nwda-editor#" exclude-result-prefixes="xsl xs arch dcterms foaf rdf xsd vcard nwda" version="1.0">
	<xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" indent="yes"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>Northwest Digital Archives | contact us</title>
				<link href="nwda.css" rel="stylesheet" type="text/css"/>
				<script src="scripts/AC_RunActiveContent.js" type="text/javascript">//</script>
				<script src="scripts/AC_ActiveX.js" type="text/javascript">//</script>
				<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js">//</script>
				<script src="scripts/contact_functions.js" type="text/javascript">//</script>
				<style text="text/css">
					.archive-div{
						margin-bottom:10px;
					}
					.toggle-button{
						padding:0;
					}</style>
			</head>

			<body>
				<xsl:comment>#include file="nav.html"</xsl:comment>
				<div id="left">
					<script type="text/javascript">
						AC_FL_RunContent(
						'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
						'width','335',
						'height','575',
						'src','slideshow_as2',
						'quality','high',
						'pluginspage','http://www.macromedia.com/go/getflashplayer',
						'movie','slideshow_as2' );
						//end AC code
					</script>
					<noscript>
						<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="335"
							height="575">
							<param name="movie" value="slideshow_as2.swf"/>
							<param name="quality" value="high"/>
							<embed src="slideshow_as2.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="335" height="575"/>
						</object>
					</noscript>
					<p>
						<a href="images1.html">about these images</a>
					</p>
				</div>
				<div id="wrapper">
					<div id="content">
						<h2>contact us</h2>
						<xsl:apply-templates select="descendant::arch:Archive">
							<xsl:sort select="foaf:name" order="ascending" data-type="text"/>
						</xsl:apply-templates>
					</div>
				</div>
				<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
				</script>

				<xsl:comment>
					<script type="text/javascript">
					var pageTracker = _gat._getTracker("UA-3516166-1");
					pageTracker._initData();
					pageTracker._trackPageview();
					</script>
				</xsl:comment>

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
		<div class="archive-div">
			<xsl:choose>
				<xsl:when test="foaf:homepage/@rdf:resource">
					<a href="{foaf:homepage/@rdf:resource}">
						<xsl:value-of select="normalize-space(foaf:name)"/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="normalize-space(foaf:name)"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="nwda:visitation or nwda:facsimile or dcterms:description">
				<xsl:text> </xsl:text>
				<a href="#" class="toggle-button">+/-</a>
				<div style="display:none">
					<dl>
						<xsl:apply-templates select="dcterms:description"/>
						<xsl:apply-templates select="nwda:facsimile"/>
						<xsl:apply-templates select="nwda:visitation"/>
					</dl>
				</div>
			</xsl:if>
		</div>
	</xsl:template>

	<xsl:template match="nwda:visitation|nwda:facsimile|dcterms:description">
		<dt>
			<strong>
				<xsl:choose>
					<xsl:when test="name()='nwda:visitation'">Visitation Info</xsl:when>
					<xsl:when test="name()='nwda:facsimile'">Copy Info</xsl:when>
					<xsl:when test="name()='dcterms:description'">Collection Info</xsl:when>
				</xsl:choose>
			</strong>
		</dt>
		<dd>
			<!-- insert a class attribute for URL parsing -->
			<xsl:if test="not(string(@rdf:resource))">
				<xsl:attribute name="class">info-text</xsl:attribute>
			</xsl:if>
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
