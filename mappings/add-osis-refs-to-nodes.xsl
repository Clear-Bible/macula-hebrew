<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:macula="http://www.w3.org/"
    exclude-result-prefixes="xs"
    version="2.0">
    <!-- declare macula namespace -->
    <xsl:namespace-alias stylesheet-prefix="xs"
        result-prefix="xsl"/>
    
    <xsl:function name="macula:osisBook">
        <xsl:param name="nodeBookId"/>
        <xsl:if test="string-length($nodeBookId) > 0">
            <xsl:variable name="nodeBookNumber">
                <xsl:value-of select="substring($nodeBookId, 1, 2)"/></xsl:variable>
            <xsl:choose>
                <xsl:when test="$nodeBookNumber = '01'">
                    <xsl:value-of select="'Gen'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '02'">
                    <xsl:value-of select="'Exo'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '03'">
                    <xsl:value-of select="'Lev'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '04'">
                    <xsl:value-of select="'Num'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '05'">
                    <xsl:value-of select="'Deu'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '06'">
                    <xsl:value-of select="'Jos'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '07'">
                    <xsl:value-of select="'Jdg'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '08'">
                    <xsl:value-of select="'Rut'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '09'">
                    <xsl:value-of select="'1Sa'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '10'">
                    <xsl:value-of select="'2Sa'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '11'">
                    <xsl:value-of select="'1Ki'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '12'">
                    <xsl:value-of select="'2Ki'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '13'">
                    <xsl:value-of select="'1Ch'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '14'">
                    <xsl:value-of select="'2Ch'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '15'">
                    <xsl:value-of select="'Ezr'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '16'">
                    <xsl:value-of select="'Neh'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '17'">
                    <xsl:value-of select="'Est'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '18'">
                    <xsl:value-of select="'Job'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '19'">
                    <xsl:value-of select="'Psa'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '20'">
                    <xsl:value-of select="'Pro'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '21'">
                    <xsl:value-of select="'Ecc'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '22'">
                    <xsl:value-of select="'Sng'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '23'">
                    <xsl:value-of select="'Isa'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '24'">
                    <xsl:value-of select="'Jer'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '25'">
                    <xsl:value-of select="'Lam'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '26'">
                    <xsl:value-of select="'Ezk'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '27'">
                    <xsl:value-of select="'Dan'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '28'">
                    <xsl:value-of select="'HOS'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '29'">
                    <xsl:value-of select="'Jol'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '30'">
                    <xsl:value-of select="'Amo'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '31'">
                    <xsl:value-of select="'Oba'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '32'">
                    <xsl:value-of select="'Jon'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '33'">
                    <xsl:value-of select="'Mic'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '34'">
                    <xsl:value-of select="'Nam'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '35'">
                    <xsl:value-of select="'Hab'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '36'">
                    <xsl:value-of select="'Zep'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '37'">
                    <xsl:value-of select="'Hag'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '38'">
                    <xsl:value-of select="'Zec'"/>
                </xsl:when>
                <xsl:when test="$nodeBookNumber = '39'">
                    <xsl:value-of select="'Mal'"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="'###'"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="macula:osisId">
        <xsl:param name="nodeId" />
        <xsl:if test="string-length($nodeId) > 0">
            <xsl:value-of select="concat(macula:osisBook($nodeId),
                '.',
                xs:integer(substring($nodeId, 3, 3)),
                '.',
                xs:integer(substring($nodeId, 6, 3)),
                '!',
                xs:integer(substring($nodeId, 9, 3))
                )"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:function name="macula:osisVerseId">
        <xsl:param name="nodeId" />
        <xsl:if test="string-length($nodeId) > 0">
            <xsl:value-of select="concat(macula:osisBook($nodeId),
                '.',
                xs:integer(substring($nodeId, 3, 3)),
                '.',
                xs:integer(substring($nodeId, 6, 3))
                )"/>
        </xsl:if>
    </xsl:function>
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>    
    
    <xsl:template match="m">
        <xsl:variable name="osisId" select="macula:osisId(data(./@n))"/>
        <xsl:copy>
            <xsl:attribute name="osisId"><xsl:value-of select="$osisId"/></xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="Sentence">
        <xsl:variable name="osisId" select="macula:osisVerseId(data(./Trees/Tree/Node/@nodeId))"/>
        <xsl:copy>
            <xsl:attribute name="osisId"><xsl:value-of select="$osisId"/></xsl:attribute>
            <xsl:apply-templates select="@*|node()" />
        </xsl:copy>
    </xsl:template>
    
</xsl:stylesheet>