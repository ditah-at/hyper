<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs" version="2.0">
    <xsl:variable name="month" select="/t:TEI/t:text/t:body/t:div[@type = 'calendar_month']"/>
    <xsl:variable name="day" select="/t:TEI/t:text/t:body//t:div[@type = 'day']"/>

    <xsl:template match="/t:TEI">

        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <title/>

                <style>
                    @font-face { 
                    font-family: 'Cardo Regular';
                    src: url('Cardo104s.ttf') format('truetype'); 
                    }
                    body {
                    font-family: 'Cardo Regular';
                    line-height: 1.5;
                    font-size: 2.2em;
                    }
                    td {
                    vertical-align: top;
                    font-size: 1.8em;
                    }
                    .red {
                    color: #B40404;
                    }
                    .underline {
                    /*text-decoration: underline;
                    color: #DF7401; */
                    border-bottom: 2px solid #DF7401;
                    }
                    /* Hier werden noch nicht alle Instanzen angezeigt */
                    .vertical {
                    border-right: 2px solid #DF7401;
                    }
                    .kuerzg {
                    font-family: sans-serif;
                    font-size: 0.9em;
                    color: #848484;
                    font-style: italic;
                    }
                    .note {
                    font-family: sans-serif;
                    font-size: 0.9em;
                    color: #00FFFF;
                    }
                    .bold {
                    color: #800000;
                    }
                </style>
            </head>
            <body>
               <!-- <xsl:apply-templates select="/t:TEI/t:text/t:body"></xsl:apply-templates>-->
                <xsl:apply-templates select="$month"/>

            </body>
        </html>

    </xsl:template>




<!-- Auswahl der Elemente, die auf einer Ebene sind -->
    <xsl:template match="$month"><!--$month-->

       <!-- <xsl:for-each-group select="./t:div[@type = 'calendar_month']" group-by="t:div[@type = 'calendar_month']/@ana"> -->
           <xsl:for-each select="t:*">
            <xsl:choose>
                <xsl:when test="name(.) = 'milestone'">
                    <hr/>
                    <h1><xsl:text>Folio: </xsl:text>
                    <xsl:value-of select="@n"/></h1>
                </xsl:when>

                <xsl:when test="name(.) = 'div' and @type = 'calendar'">
                    <h3> <xsl:apply-templates select="t:head"/></h3>
                    <h1><xsl:value-of select="t:div[@type='calendar']/t:lb/@n"/></h1>
                    <table>
                        <!--<xsl:apply-templates select="child::t:div[@type='day']"/>-->
                        
                        <xsl:for-each select="./following-sibling::t:div[@type='day']">
                            <tr>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Goldene_Zahl']" />
                                    
                                </td>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Mond_Stunden']" />
                                    
                                </td>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Mond_Minuten']" />
                                    
                                </td>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Buchstaben_unklar']" />
                                    
                                </td>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Ferialzählung']" />
                                    
                                </td>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'römische_Datierung']" />
                                    
                                </td>
                                <td>
                                    
                                    <xsl:apply-templates select="t:div[@type = '_Kalendereintrag']/t:ab" />
                                    
                                    <!-- Weiter mit apply-templates, um die Abarbeitung nicht zu stoppen / unterbrechen 
                    <xsl:apply-templates select="$month/t:div/t:div[@type = '_Kalendereintrag']/t:ab/t:lb"/> -->
                                </td>
                                
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Ende']/t:ab[@type = 'Lunarbuchstabe']" />
                                    
                                </td>
                                <td>
                                    <xsl:apply-templates select="t:div[@type = 'Intervallzone_Ende']/t:ab[@type = 'Tagesnummerierung']" />
                                    
                                </td>
                                <td>
                                    <xsl:value-of select="t:div[@type = 'day']/t:lb/@n" />
                                    
                                </td>
                                
                            </tr>
                        </xsl:for-each>
                    </table>    
                </xsl:when>
                <xsl:when test="name(.) = 'div' and @type = 'calendar_text'">
                    <h3> <xsl:apply-templates select="t:head"/></h3>
                        <xsl:apply-templates select="self::t:div[@type = 'calendar_text']"/>
                </xsl:when>
            </xsl:choose>
           </xsl:for-each>
        <!--</xsl:for-each-group>-->
    </xsl:template>


  <!-- Aufbau der tabellenartigen Tagesstruktur -->
    <!--<xsl:template match="t:div[@type='day']"><!-\-$month/-\->
        
  <!-\- Jede row mit for-each ... -\->
       <xsl:for-each select="">
                 <tr>
                    <td>
                        <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Goldene_Zahl']" />
                        
                    </td>
                     <td>
                         <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Mond_Stunden']" />
                         
                     </td>
                     <td>
                         <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Mond_Minuten']" />
                         
                     </td>
                     <td>
                         <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Buchstaben_unklar']" />
                         
                     </td>
                    <td>
                        <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'Ferialzählung']" />
                       
                    </td>
                    <td>
                        <xsl:apply-templates select="t:div[@type = 'Intervallzone_Anfang']/t:ab[@type = 'römische_Datierung']" />

                    </td>
                    <td>
                        
                        <xsl:apply-templates select="t:div[@type = '_Kalendereintrag']/t:ab" />
                        
                        <!-\- Weiter mit apply-templates, um die Abarbeitung nicht zu stoppen / unterbrechen 
                    <xsl:apply-templates select="$month/t:div/t:div[@type = '_Kalendereintrag']/t:ab/t:lb"/> -\->
                    </td>
                     
                     <td>
                         <xsl:apply-templates select="t:div[@type = 'Intervallzone_Ende']/t:ab[@type = 'Lunarbuchstabe']" />
                         
                     </td>
                     <td>
                         <xsl:apply-templates select="t:div[@type = 'Intervallzone_Ende']/t:ab[@type = 'Tagesnummerierung']" />
                         
                     </td>
                    
             </tr>
       </xsl:for-each>
    </xsl:template>-->


    <!-- Tagesstruktur: Kalendereintrag -->
    <xsl:template match="t:div[@type = '_Kalendereintrag']/t:ab">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'Goldene_Zahl']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'Mond_Stunden']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'Mond_Minuten']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'Buchstaben_unklar']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'Ferialzählung']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'römische_Datierung']">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ab[@type = 'Lunarbuchstabe']">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="t:ab[@type = 'Tagesnummerierung']">
        <xsl:apply-templates/>
    </xsl:template>


    <!-- Einzhelelemente -->
    
    <xsl:template match="t:milestone">
        <hr/>
        <h1><xsl:text>Folio: </xsl:text>
            <xsl:value-of select="@n"/></h1>
    </xsl:template>
    
    <xsl:template match="t:ab">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!--<xsl:template match="t:div[@type='calendar']/t:lb/@n">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:div[@type = 'day']/t:lb/@n">
        <xsl:apply-templates/>
    </xsl:template>-->
    
    <!-- Hochstellung -->
    <xsl:template match="t:hi[@rend ='super']">
        <sup>
            <xsl:value-of select="."/>
        </sup>  
    </xsl:template>
    
    <!-- Tiefstellung -->
    <xsl:template match="t:hi[@rend ='sub']">
        <sub>
            <xsl:value-of select="."/>
        </sub>  
    </xsl:template>
    
    <!-- Rubrizierung Help -->
    <xsl:template match="t:hi[@rend ='bold']">
        <span class="bold">
            <xsl:value-of select="."/>
        </span>  
    </xsl:template>
    
    <!-- Rubrizierungen 
    <xsl:template match="*[@rend ='red']">
        <span class="red">
            <xsl:value-of select="."/>
        </span>  
        
    </xsl:template>
        <xsl:template match="t:hi[@rend ='vertical_dash:red']">
        <span class="vertical">
            <xsl:value-of select="."/>
        </span>  
    </xsl:template>
    
 
   <xsl:template match="t:hi[@rend ='underline:red']">
        <span class="underline">
            <xsl:value-of select="."/>
        </span>  
        <xsl:apply-templates/>
    </xsl:template> 
    
    -->
    
    
    <xsl:template match="t:abbr">
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="t:ex">
        <span class="kuerzg">
        <xsl:text>/</xsl:text><xsl:value-of select="."/>
        </span>
    </xsl:template>

    <xsl:template match="t:note">
        <span class="note">
            <xsl:text>[</xsl:text><xsl:value-of select="."/><xsl:text>]</xsl:text>
        </span>  
    </xsl:template>
    
    <!-- Character -->
   
    <xsl:template match="t:g">
        <xsl:param name="url"><xsl:text></xsl:text></xsl:param>
        <xsl:variable name="zeichenID">
            <xsl:value-of select="substring(@ref,2)"/>
        </xsl:variable>
        <xsl:value-of select="preceding::t:encodingDesc/child::t:charDecl/child::t:glyph[@xml:id=$zeichenID]/child::t:mapping[@subtype='html_entity']"/>
    </xsl:template>
    
    

       <!-- <xsl:template match="t:g[@ref ='#slong']">
            ###<xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='slong']/t:mapping[@subtype='unicode_symbol']"/>
    </xsl:template>

    <xsl:template match="t:g[@ref ='#dbloblhyph']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='dbloblhyph']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combuml']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combuml']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#pplig']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='pplig']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    <xsl:template match="t:g[@ref ='#slongflour']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='slongflour']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
  
    <xsl:template match="t:g[@ref ='#usbase']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='usbase']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#rrot']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='rrot']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#bar']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='bar']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcurlbar']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcurlbar']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#ttailstrok']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='ttailstrok']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcircdbl']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcircdbl']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#qcentrslstrok']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='qcentrslstrok']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#pbardes']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='pbardes']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#pflour']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='pflour']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#rtailstrok']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='rtailstrok']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#lozengedot']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='lozengedot']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>

    <xsl:template match="t:g[@ref ='#etsalsh']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='etsalsh']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#etfin']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='etfin']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>

    <xsl:template match="t:g[@ref ='#libradut']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='libradut']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#dtail']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='dtail']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#renvoi']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='renvoi']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#jbar']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='jbar']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#qtrmoon']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='qtrmoon']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#sagit']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='sagit']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#ctlig']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='ctlig']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>  
    
    <xsl:template match="t:g[@ref ='#ppflourlig']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='ppflourlig']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>  
    
    <xsl:template match="t:g[@ref ='#ercurl']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='e']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>  
    
    <xsl:template match="t:g[@ref ='#inodot']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='inodot']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcomma_r']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcomma_r']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#bar_n']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='bar_n']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#dipledot']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='dipledot']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#bar_e']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='bar_e']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcurlbar_art']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcurlbar_art']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#tridotright']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='tridotright']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#esup']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='esup']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#ustbase']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='ustbase']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#bar_mber']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='bar_mber']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcomma_e']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcomma_e']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcomma_er']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcomma_er']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#au']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='au']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#combcomma_ri']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='combcomma_ri']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>
    
    <xsl:template match="t:g[@ref ='#Jesu']">
        <xsl:value-of select="//t:encodingDesc/t:charDecl/t:glyph[@xml:id='Jesu']/t:mapping[@subtype='unicode_symbol']"/>    
    </xsl:template>-->
    
</xsl:stylesheet>
