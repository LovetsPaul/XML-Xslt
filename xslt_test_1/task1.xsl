<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8" />
    <xsl:template match="/">
        <flyings>
            <xsl:for-each select="SourceDoc/HTML[1]/BODY[1]/TABLE[1]/TR[2]/TD[1]/TABLE[1]/TR[1]/TD[1]/TABLE[1]/TR[1]/TD[3]/TABLE[1]/TR/TD">
                <xsl:if test="B[4] != '' ">
                    <xsl:variable name="departname" select="substring-before( normalize-space( substring-after( text()[contains(., 'Depart')], 'Depart' ) ), ' ' )" />
                    <xsl:variable name="departcode" select="substring-before( substring-after( normalize-space( substring-after(text()[contains(., 'Depart')], 'Depart' ) ), '('), ')' )" />
                    <xsl:variable name="arrivename" select="substring-before( normalize-space( substring-after( text()[contains(., 'Arrive')], 'Arrive' ) ), ' ' )" />
                    <xsl:variable name="arrivecode" select="substring-before( substring-after( normalize-space( text()[contains(., 'Arrive')] ), '(' ), ')' )" />
                    <xsl:variable name="mo">
                       <xsl:value-of select="substring-before(normalize-space(substring(STRONG[1], 8)), ' ')"/>
                    </xsl:variable>
                    <xsl:variable name="month">
                        <xsl:choose>
                            <xsl:when test="$mo = 'January'">01</xsl:when>
                            <xsl:when test="$mo = 'February'">02</xsl:when>
                            <xsl:when test="$mo = 'March'">03</xsl:when>
                            <xsl:when test="$mo = 'April'">04</xsl:when>
                            <xsl:when test="$mo = 'May'">05</xsl:when>
                            <xsl:when test="$mo = 'June'">06</xsl:when>
                            <xsl:when test="$mo = 'July'">07</xsl:when>
                            <xsl:when test="$mo = 'August'">08</xsl:when>
                            <xsl:when test="$mo = 'September'">09</xsl:when>
                            <xsl:when test="$mo = 'Octember'">10</xsl:when>
                            <xsl:when test="$mo = 'November'">11</xsl:when>
                            <xsl:when test="$mo = 'December'">12</xsl:when>
                        </xsl:choose>
                    </xsl:variable>
                    <xsl:variable name="departDate" select="normalize-space(substring(STRONG[1], 4))" />
                    <xsl:variable name="fullDateDepart" select="concat( normalize-space(substring-after($departDate, $mo)), concat( $month, substring($departDate, 1, 2)))"/>  
                    <flightitem>
                        <flightinfo>
                            <airline>
                                <xsl:value-of select="substring(B[4], 19, 2)" />
                            </airline>
                            <flightnumber>
                                <xsl:value-of select="substring(B[4], 21)" />
                            </flightnumber>
                            <totalflighttime>
                                <xsl:value-of select="normalize-space( substring( text()[contains(., 'Total flight time:')], 23) )" />
                            </totalflighttime>
                        </flightinfo>
                        <flightdateinfo>
                            <departdate valDepartDate="{$fullDateDepart}">
                                <xsl:value-of select="concat(STRONG[1],' - ', normalize-space(B[2]))" />
                            </departdate>
                            <arrivedate>
                                <xsl:value-of select="concat(STRONG[1],' - ', normalize-space(B[3]))" />
                            </arrivedate>
                        </flightdateinfo>
                        <citydepartinfo>
                            <citydepartname>
                                <xsl:choose>
                                    <xsl:when test="contains($departname, ',')">
                                        <xsl:value-of select="substring-before($departname, ',')" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="$departname" />
                                    </xsl:otherwise>
                                </xsl:choose>
                            </citydepartname>
                            <citydepartcode>
                                <xsl:value-of select="$departcode" />
                            </citydepartcode>
                        </citydepartinfo>
                        <cityarriveinfo>
                            <cityarrivename>
                                <xsl:value-of select="$arrivename" />
                            </cityarrivename>
                            <cityarrivecode>
                                <xsl:value-of select="$arrivecode" />
                            </cityarrivecode>
                        </cityarriveinfo>
                        <fareinfo>
                            <mainfare>
                                <xsl:value-of select="following::BIG/B/STRONG" />
                            </mainfare>
                            <phonefare>
                                <xsl:value-of select="normalize-space( substring-after(following::SPAN[@class='grey']/B, 'fare') )" />
                            </phonefare>
                        </fareinfo>
                    </flightitem>
                </xsl:if>
            </xsl:for-each>
        </flyings>
    </xsl:template>
</xsl:stylesheet>