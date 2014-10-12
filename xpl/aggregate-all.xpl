<?xml version="1.0" encoding="UTF-8"?>
<p:config xmlns:p="http://www.orbeon.com/oxf/pipeline" xmlns:oxf="http://www.orbeon.com/oxf/processors">

	<p:param type="input" name="data"/>
	<p:param type="output" name="data"/>

	<p:processor name="oxf:directory-scanner">
		<p:input name="config">
			<config>
				<base-directory>oxf:/repository_records</base-directory>
				<include>*.xml</include>
			</config>
		</p:input>
		<p:output name="data" id="directory-scan"/>
	</p:processor>

	<p:processor name="oxf:unsafe-xslt">
		<p:input name="data" href="#directory-scan"/>
		<p:input name="config">
			<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xsl xs" version="2.0">
				
				<xsl:template match="/">					
				<rdf:RDF xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
					xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
					xmlns:nwda="https://github.com/ewg118/nwda-editor#">
					<xsl:for-each select="//file">
						<xsl:copy-of select="document(concat('oxf:/repository_records/', @name))/rdf:RDF/*"/>
					</xsl:for-each>
				</rdf:RDF>
				</xsl:template>
			</xsl:stylesheet>
		</p:input>
		<p:output name="data" ref="data"/>
	</p:processor>
</p:config>
