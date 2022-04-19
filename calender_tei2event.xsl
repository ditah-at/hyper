<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:template match="t:TEI">
        <TEI xmlns="http://www.tei-c.org/ns/1.0">
            <teiHeader>
                <fileDesc>
                    <titleStmt>
                        <title>Title</title>
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
        <listEvent>
           <xsl:call-template name="event"/>
        </listEvent>
                </body>
            </text>
        </TEI>
    </xsl:template>
    
    <xsl:template name="event">
        <xsl:for-each select="./t:text/t:body/t:div/t:div/t:div[@type='day']">
            <event when="{./t:div/t:ab/t:date/@when}" where="Tegernsee">
                <head><xsl:value-of select="normalize-space(./t:div/t:ab[@type='Cisiojanus'])"/></head>
               
                <xsl:if test="./t:div[@type='Kalendereintrag']">
                    <label><xsl:value-of select="normalize-space(./t:div[@type='Kalendereintrag'])"/></label>
                </xsl:if>
                <desc>
                    <listPerson>
                        <personGrp role="saint">
                           
                            <persName><xsl:value-of select="substring-after(./@corresp, '#')"/></persName>
                        </personGrp>
                    </listPerson>
                </desc>
            </event>
        </xsl:for-each>
    </xsl:template>
    
   <!-- <xsl:template name="eintrag">
        <xsl:for-each select="./t:text/t:body/t:div/t:div/t:div/t:div[@type='Kalendereintrag']">
        <label><xsl:value-of select="."/></label>
        </xsl:for-each>
    </xsl:template>-->
    
   <!--<xsl:apply-templates/> <xsl:template name=""> zeichen in eintrag händln </xsl:template> -->
        
   
</xsl:stylesheet>