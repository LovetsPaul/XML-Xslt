<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" />
    <xsl:template match="alldocs">
        <xsl:for-each select="doc">
            <xsl:for-each select="document(@path)">
                <xsl:copy>
                    <xsl:copy-of select="." />                   
                </xsl:copy>
            </xsl:for-each>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>