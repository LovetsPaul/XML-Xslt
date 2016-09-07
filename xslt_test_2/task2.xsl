<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8" />
    
    <xsl:key name="group" match="flyings/flightitem" use="citydepartinfo/citydepartname" />
    
    <xsl:template match="flyings">
        <group-list>
            <xsl:apply-templates select="flightitem[generate-id(.) = generate-id(key('group',citydepartinfo/citydepartname))]" />
        </group-list>
    </xsl:template>
    
    <xsl:template match="flightitem">
        <group-by-departname>
            <xsl:for-each select="key('group',citydepartinfo/citydepartname)">
                <xsl:sort select="substring(./flightdateinfo/departdate/@valDepartDate, 1, 4)" order="ascending" data-type="number" />
                <xsl:sort select="substring(./flightdateinfo/departdate/@valDepartDate, 5, 2)" order="ascending" data-type="number" />
                <xsl:sort select="substring(./flightdateinfo/departdate/@valDepartDate, 7, 2)" order="ascending" data-type="number" />
                <xsl:copy-of select="."/>
            </xsl:for-each>
        </group-by-departname>
    </xsl:template>
    
</xsl:stylesheet>