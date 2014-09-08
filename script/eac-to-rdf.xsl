<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:eac="urn:isbn:1-931666-33-4" xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/"
	xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsd="http://www.w3.org/2001/XMLSchema#" xmlns:nwda="https://github.com/ewg118/nwda-editor#" exclude-result-prefixes="eac xsl xlink" version="2.0">
	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<rdf:RDF xmlns:arch="http://purl.org/archival/vocab/arch#" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:foaf="http://xmlns.com/foaf/0.1/"
			xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:vcard="http://www.w3.org/2006/vcard/ns#" xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
			xmlns:nwda="https://github.com/ewg118/nwda-editor#">
			<arch:Archive rdf:about="aew:{descendant::eac:entityId[@localType='OCLCRepositoryCode']}">
				<xsl:choose>
					<xsl:when test="descendant::eac:nameEntry[@localType='fullName']">
						<foaf:name>
							<xsl:value-of select="descendant::eac:nameEntry[@localType='fullName']/eac:part"/>
						</foaf:name>
					</xsl:when>
					<xsl:otherwise>
						<foaf:name>
							<xsl:value-of select="descendant::eac:nameEntry[@localType='displayName']/eac:part"/>
						</foaf:name>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="descendant::eac:cpfRelation[@xlink:role='homePage']">
						<foaf:homepage rdf:resource="{descendant::eac:cpfRelation[@xlink:role='homePage']/@xlink:href}"/>
					</xsl:when>
					<xsl:otherwise>
						<foaf:homepage rdf:resource=""/>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="descendant::eac:item[@localType='emailAddress']">
						<vcard:hasEmail rdf:resource="mailto:{descendant::eac:item[@localType='emailAddress']}"/>
					</xsl:when>
					<xsl:otherwise>
						<vcard:hasEmail rdf:resource=""/>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="descendant::eac:list[@localType='mailingAddress']">
						<xsl:apply-templates select="descendant::eac:list[@localType='mailingAddress']"/>
					</xsl:when>
					<xsl:otherwise>
						<vcard:hasAddress>
							<rdf:Description>
								<vcard:street-address/>
								<vcard:locality/>
								<vcard:postal-code/>
							</rdf:Description>
						</vcard:hasAddress>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:choose>
					<xsl:when test="number(substring(descendant::eac:item[@localType='phone'], 1, 3))">
						<vcard:hasTelephone>
							<vcard:Voice>
								<vcard:hasValue rdf:resource="tel:+{replace(descendant::eac:item[@localType='phone'], '-', '')}"/>
							</vcard:Voice>
						</vcard:hasTelephone>
					</xsl:when>
					<xsl:otherwise>
						<vcard:hasTelephone>
							<vcard:Voice>
								<vcard:hasValue rdf:resource=""/>
							</vcard:Voice>
						</vcard:hasTelephone>
					</xsl:otherwise>
				</xsl:choose>
				
				<xsl:if test="number(substring(descendant::eac:item[@localType='fax'], 1, 3))">
					<vcard:hasTelephone>
						<vcard:Fax>
							<vcard:hasValue rdf:resource="tel:+{replace(descendant::eac:item[@localType='fax'], '-', '')}"/>
						</vcard:Fax>
					</vcard:hasTelephone>
				</xsl:if>
				<!-- visitation, scope, copy requests -->
				<xsl:choose>
					<xsl:when test="descendant::eac:resourceRelation[@xlink:role='onSiteVisitPage']">
						<nwda:visitation rdf:resource="{descendant::eac:resourceRelation[@xlink:role='onSiteVisitPage']/@xlink:href}"/>
					</xsl:when>
					<xsl:when test="descendant::eac:localDescriptions[@localType='onSiteVisit']">
						<nwda:visitation>
							<xsl:value-of select="normalize-space(descendant::eac:localDescriptions[@localType='onSiteVisit'])"/>
						</nwda:visitation>
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="descendant::eac:resourceRelation[@xlink:role='requestCopiesPage']">
						<nwda:facsimile rdf:resource="{descendant::eac:resourceRelation[@xlink:role='requestCopiesPage']/@xlink:href}"/>
					</xsl:when>
					<xsl:when test="descendant::eac:localDescriptions[@localType='requestCopies']">
						<nwda:facsimile>
							<xsl:value-of select="normalize-space(descendant::eac:localDescriptions[@localType='requestCopies'])"/>
						</nwda:facsimile>
					</xsl:when>
				</xsl:choose>
				<xsl:choose>
					<xsl:when test="descendant::eac:resourceRelation[@xlink:role='collectionScopePage']">
						<dcterms:description rdf:resource="{descendant::eac:resourceRelation[@xlink:role='collectionScopePage']/@xlink:href}"/>
					</xsl:when>
					<xsl:when test="descendant::eac:localDescriptions[@localType='collectionScope']">
						<dcterms:description>
							<xsl:value-of select="normalize-space(descendant::eac:localDescriptions[@localType='collectionScope'])"/>
						</dcterms:description>
					</xsl:when>
				</xsl:choose>
			</arch:Archive>
		</rdf:RDF>
	</xsl:template>
	
	<xsl:template match="eac:list[@localType='mailingAddress']">
		<xsl:variable name="count" select="count(eac:item)"/>
		
		<vcard:hasAddress>
			<rdf:Description>
				<xsl:choose>
					<xsl:when test="number(eac:item[last()])">
						<xsl:for-each select="eac:item[position() &lt; $count - 1]">
							<vcard:street-address>
								<xsl:value-of select="normalize-space(.)"/>
							</vcard:street-address>
						</xsl:for-each>
						
						<vcard:locality>
							<xsl:value-of select="normalize-space(eac:item[$count -1])"/>
						</vcard:locality>						
						<vcard:postal-code>
							<xsl:value-of select="eac:item[last()]"/>
						</vcard:postal-code>
					</xsl:when>
					<xsl:otherwise>
						<xsl:for-each select="eac:item[position() &lt; $count]">
							<vcard:street-address>
								<xsl:value-of select="normalize-space(.)"/>
							</vcard:street-address>
						</xsl:for-each>
						<xsl:analyze-string select="eac:item[last()]" regex="\d{{5}}">
							<xsl:non-matching-substring>
								<vcard:locality>
									<xsl:value-of select="normalize-space(.)"/>
								</vcard:locality>
							</xsl:non-matching-substring>
							<xsl:matching-substring>
								<vcard:postal-code>
									<xsl:value-of select="."/>
								</vcard:postal-code>
							</xsl:matching-substring>							
						</xsl:analyze-string>						
					</xsl:otherwise>
				</xsl:choose>				
			</rdf:Description>
		</vcard:hasAddress>
	</xsl:template>
</xsl:stylesheet>
