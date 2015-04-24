<?xml version="1.0" encoding="UTF-8"?>
<p:pipeline xmlns:p="http://www.orbeon.com/oxf/pipeline" xmlns:oxf="http://www.orbeon.com/oxf/processors" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<p:param type="input" name="file"/>
	<p:param type="output" name="data"/>

	<p:processor name="oxf:url-generator">
		<p:input name="config" href="#file"/>
		<p:output name="data" id="model"/>
	</p:processor>

	<p:processor name="oxf:exception-catcher">
		<p:input name="data" href="#model"/>
		<p:output name="data" id="url-data-checked"/>
	</p:processor>

	<!-- Check whether we had an exception -->
	<p:choose href="#url-data-checked">
		<p:when test="/exceptions">
			<!-- Extract the message -->
			<p:processor name="oxf:xslt">
				<p:input name="data" href="#url-data-checked"/>
				<p:input name="config">
					<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:arch="http://purl.org/archival/vocab/arch#"
						xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
						xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:nwda="https://github.com/Orbis-Cascade-Alliance/nwda-editor#"
						exclude-result-prefixes="xsl xs" version="2.0">
						<xsl:template match="/">
							<xsl:copy-of select="document('../template.xml')"/>
						</xsl:template>						
					</xsl:stylesheet>
				</p:input>
				<p:output name="data" ref="data"/>
			</p:processor>
		</p:when>
		<p:otherwise>
			<!-- Just return the document -->
			<p:processor name="oxf:identity">
				<p:input name="data" href="#url-data-checked"/>
				<p:output name="data" ref="data"/>
			</p:processor>
		</p:otherwise>
	</p:choose>
</p:pipeline>
