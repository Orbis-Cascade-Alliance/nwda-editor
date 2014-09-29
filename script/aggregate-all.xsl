<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xsl xs" version="2.0">
	<xsl:strip-space elements="*"/>
	
	<xsl:template match="/">
		<xsl:variable name="collection" select="concat(/config/file_path, '/?select=*.xml')"/>
		<rdf:RDF xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
			xmlns:nwda="https://github.com/ewg118/nwda-editor#">
			<xsl:for-each select="collection($collection)">
				<xsl:copy-of select="document(document-uri(.))/rdf:RDF/*"/>
			</xsl:for-each>
		</rdf:RDF>
	</xsl:template>
</xsl:stylesheet>
