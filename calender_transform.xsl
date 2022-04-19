<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet" xmlns:t="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs ss t" version="2.0">

    <xsl:variable name="table" select="//t:text/t:body/t:table"/>
    
    <xsl:template match="/">
        
<TEI xmlns="http://www.tei-c.org/ns/1.0">
    <teiHeader>
        <fileDesc>
            <titleStmt>
                <title>Title<placeName ana="grote_diocese"></placeName></title>
            </titleStmt>
            <publicationStmt>
                <p>Publication Information</p>
            </publicationStmt>
            <sourceDesc>
                <p>Information about the source</p>
            </sourceDesc>
        </fileDesc>
    </teiHeader>
    <text>
        <body>
            
            <xsl:for-each select="//t:text/t:body/t:table">
                <div type="calendar_month" ana="month"><!-- muss in Nachbearbeitung angepasst werden, weil nicht in Daten -->
                    <xsl:variable name="milestone_folio" select="./t:head"/>
                    <milestone unit="pag" n="{substring-after($milestone_folio, 'fol. ')}"/> 
                    <div type="calendar">
                        <head>
                            <xsl:copy-of select="./t:row[1]/t:cell[1]/node()"></xsl:copy-of>
                        </head>
                    </div>
                    
                    <xsl:for-each select="./t:row[not(@n=1)]">
                        <xsl:if test="./t:cell[5][string-length()>0]">
                            
                            <div type="day">
                                <xsl:attribute name="n">
                                    <xsl:variable name="num"><xsl:number count="$table"/></xsl:variable><!-- für Monatszählung -->
                                    <xsl:text>--</xsl:text><xsl:number value="($num + 2)" format="1"/><!-- für Monatszählung, weil Kalender beginnt erst im März -->
                                    <xsl:text>-</xsl:text><xsl:number level="single" count="t:row[not(position()=1)]" format="1"/><!-- für Tageszählung -->
                                </xsl:attribute>
                                <div type="Intervallzone_Anfang">
                                    <ab type="Goldene_Zahl"><xsl:copy-of select="./t:cell[1]/node()"/></ab>
                                    <ab type="Mond_Stunden"><xsl:copy-of select="./t:cell[2]/node()"/></ab>
                                    <ab type="Mond_Minuten"><xsl:copy-of select="./t:cell[3]/node()"/></ab>
                                    <ab type="Buchstaben_unklar"><xsl:copy-of select="./t:cell[4]/node()"/></ab>
                                    <ab type="Ferialzählung"><xsl:copy-of select="./t:cell[5]/node()"/></ab>
                                    <ab type="römische_Datierung"><xsl:copy-of select="./t:cell[6]/node()"/></ab>
                                    <ab type="leer"/>
                                </div>
                                <div type="_Kalendereintrag">
                                    <ab><xsl:copy-of select="./t:cell[8]/node()"/></ab>
                                </div>
                                
                                <div type="Intervallzone_Ende">
                                    <ab type="Lunarbuchstabe"><xsl:copy-of select="./t:cell[9]/node()"/></ab>
                                    <ab type="Tagesnummerierung"><xsl:copy-of select="./t:cell[10]/node()"/></ab>
                                </div>
                                
                            </div>
                            
                        </xsl:if>
                    </xsl:for-each>
                    
                </div>
            </xsl:for-each>
            
        </body>
    </text>
</TEI>
    </xsl:template>

</xsl:stylesheet>
