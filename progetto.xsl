<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet


    version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <!-- Identity template SOLO per nodi NON TEI -->
<xsl:template match="@*|node()[not(self::tei:*)]">
    <xsl:copy>
        <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
</xsl:template>


    <xsl:output method="html" encoding="UTF-8"/>

    <!-- TEMPLATE RADICE -->
    <xsl:template match="/">
        <xsl:apply-templates select="tei:TEI"/>
    </xsl:template>


    <!-- TEMPLATE PRINCIPALE (TUTTO L'OUTPUT HTML STA QUI!!) -->
    <xsl:template match="tei:TEI">

<html>
    <head>
    <title>Progetto di Codifica di Testi</title>

    <link rel="stylesheet"
          href="https://code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css" />

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

    <script src="script/script.js"></script>

    <link rel="stylesheet" href="script/style.css" />
</head>


<body>

    <header>
        <nav>
            <div class="navbar">
                <a class="nameproject" href='https://github.com/angelodel80/corsoCodifica'>Codifica di Testi</a>
                <a href="#">Home</a>

                <a href="#menu-articoli">Paragrafi</a>

                <div class="dropdown">
                    <button class="dropbtn">Pagine
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-content">
                        <a href="#Pag1">Pagina 1</a>
                        <a href="#Pag2">Pagina 2</a>
                        <a href="#Pag3">Pagina 3</a>
                        <a href="#Pag4">Pagina 4</a>
                        <a href="#Pag5">Pagina 5</a>
                        <a href="#Pag6">Pagina 6</a>
                        <a href="#Pag7">Pagina 7</a>
                        <a href="#Pag8">Pagina 8</a>
                        
                    </div>
                </div>

                <a href="#about">About</a>
            </div>
        </nav>
    </header>

    <div class="logo">
        <a href='https://rassegnasettimanale.animi.it/' target="_blank">
            <img src="logo.png" alt="La rassegna settimanale di politica"/>
        </a>
    </div>

    <!-- DESCRIZIONE DOCUMENTO -->

    <div class="desc-carousel">

    <!--     DESCRIZIONE FONTE  -->
    <div class="desc-slide active">
    <h2>Descrizione della Fonte:</h2>

    <!-- IMPRINT (pubPlace, publisher, date) -->
    <p>
        <xsl:apply-templates select="//tei:imprint/tei:pubPlace"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="//tei:imprint/tei:publisher"/>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="//tei:imprint/tei:date"/>
    </p>

   <!-- TITOLO e SOTTOTITOLO -->
<p>
    <strong>Titolo:</strong>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="//tei:titleStmt/tei:title[@type='main']"/>
</p>

<p>
    <strong>Sottotitolo:</strong>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="//tei:titleStmt/tei:title[@type='sub']"/>
</p>

    <!-- FONDATORI -->
    <p>
        <strong>Fondatori: </strong>
        <xsl:for-each select="//tei:titleStmt/tei:respStmt[tei:resp='Fondatori:']/tei:persName">
            <xsl:apply-templates select="."/>
            <xsl:if test="position()!=last()">, </xsl:if>
        </xsl:for-each>
    </p>

    <!-- SERIE (volumi e capitoli) -->
    <strong>Serie codificata:</strong>
    <xsl:apply-templates select="//tei:seriesStmt"/>
</div>


    <br/>

    <!--  DESCRIZIONE MANOSCRITTO -->
    <div class="desc-slide">
        <h2>Descrizione del Manoscritto:</h2>
        <xsl:apply-templates select="//tei:objectDesc"/>
    </div>

    <br/>

    <!--   DESCRIZIONE CODIFICA -->
    <div class="desc-slide">
        <h2>Descrizione della Codifica:</h2>
        <xsl:apply-templates select="//tei:projectDesc"/>
    </div>


     <!-- INDICATORI -->
    <div class="desc-indicators">
        <span class="dot active"></span>
        <span class="dot"></span>
        <span class="dot"></span>
    </div>

</div>


    <!-- MENU FENOMENI -->

    <div id="fenomeni">
        <ul class='bottoni_fenomeni'>
            <button type="button" id="persone">Nomi di Persona</button>
            <button type="button" id="luoghi">Nomi di Luoghi</button>
            <button type="button" id="date">Date</button>
            <button type="button" id="organizzazioni">Nomi di Organizzazioni</button>
            <button type="button" id="citazioni">Citazioni</button>
            <button type="button" id="opere">Opere</button>
            <button type="button" id="popoli">Popoli</button>
            <button type="button" id="foreign">Lingue Straniere</button>
            
        </ul>
    </div>


<!-- MENU ARTICOLI → PARAGRAFI -->

<div id="menu-articoli">
    <h2>Articoli e Paragrafi</h2>

    <xsl:for-each select="//tei:group/tei:text">
        <div class="articolo-block">

            <!-- TITOLI DEGLI ARTICOLI -->
            <h3 class="titolo-articolo" onClick="togglePargrafi(this)">
                <xsl:choose>
                    <xsl:when test=".//tei:head">
                        <xsl:value-of select=".//tei:head[1]"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@xml:id"/>
                    </xsl:otherwise>
                </xsl:choose>
            </h3>

            <!-- LISTA DEI PARAGRAFI -->
            <ul class="lista-paragrafi hidden">
    <xsl:for-each select=".//tei:ab[@xml:id]">
        <li>
            <a href="#{@xml:id}">
                <xsl:attribute name="onclick">
                    <xsl:text>evidenziaParagrafo('</xsl:text>
                    <xsl:value-of select="@xml:id"/>
                    <xsl:text>')</xsl:text>
                </xsl:attribute>

                <xsl:text>Paragrafo </xsl:text>
                <xsl:value-of select="position()"/>
            </a>
        </li>
    </xsl:for-each>
</ul>


        </div>
    </xsl:for-each>
</div>


    <!-- PAGINE DEL TESTO -->
    
    <div class="text">

        <!-- PAGINA 1 -->
        <h2 id="Pag1">Pagina 1:</h2>
        <div id="img1">
            <div class="container">
                <div class="box">
                    <a href='./pages/img1.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img1.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr1']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img1']/*"/>

                </div>

                <hr/>
            </div>
        </div>


        <!-- PAGINA 2 -->
        <h2 id="Pag2">Pagina 2:</h2>
        <div id="img2">
            <div class="container">
                <div class="box">
                    <a href='./pages/img2.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img2.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr2']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img2']/*"/>

                </div>

                <hr/>
            </div>
        </div>

         <!-- PAGINA 3 -->
        <h2 id="Pag3">Pagina 3:</h2>
        <div id="img3">
            <div class="container">
                <div class="box">
                    <a href='./pages/img3.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img3.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr3']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img3']/*"/>

                </div>

                <hr/>
            </div>
        </div>

        <!-- PAGINA 4 -->
        <h2 id="Pag4">Pagina 4:</h2>
        <div id="img4">
            <div class="container">
                <div class="box">
                    <a href='./pages/img4.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img4.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr4']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img4']/*"/>

                </div>

                <hr/>
            </div>
        </div>

         <!-- PAGINA 5 -->
        <h2 id="Pag5">Pagina 5:</h2>
        <div id="img5">
            <div class="container">
                <div class="box">
                    <a href='./pages/img5.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img5.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr5']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img5']/*"/>

                </div>

                <hr/>
            </div>
        </div>

 <!-- PAGINA 6 -->
        <h2 id="Pag6">Pagina 6:</h2>
        <div id="img6">
            <div class="container">
                <div class="box">
                    <a href='./pages/img6.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img6.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr6']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img6']/*"/>

                </div>

                <hr/>
            </div>
        </div>
      
       <!-- PAGINA 7 -->
        <h2 id="Pag7">Pagina 7:</h2>
        <div id="img7">
            <div class="container">
                <div class="box">
                    <a href='./pages/img7.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img7.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr7']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img7']/*"/>

                </div>

                <hr/>
            </div>
        </div>

    
      <!-- PAGINA 8 -->
        <h2 id="Pag8">Pagina 8:</h2>
        <div id="img8">
            <div class="container">
                <div class="box">
                    <a href='./pages/img8.png' target="_blank">
                        <div class="facsimile-wrapper">
    <img src="./pages/img8.png" class="facsimile"/>

    <div class="overlay">
        <xsl:apply-templates select="//tei:surface[@xml:id='imgr8']/tei:zone"/>
    </div>
</div>

                    </a>
                </div>

                <div class="boxtext">
              <xsl:apply-templates select="//tei:div[@xml:id='img8']/*"/>

                </div>

                <hr/>
            </div>
        </div>


 

        

    </div>


    <!-- ABOUT / FOOTER -->

    <div id="about">
        <footer>
            <h1 class="footer-title">INFORMAZIONI AGGIUNTIVE:</h1>

            <div class="footer-container">

                <div class="box">
                    <h2>Informazioni dell'Edizione: </h2>
                    <ul class="info-list">
                    <xsl:apply-templates select="//tei:editionStmt/*"/>
                    </ul>
                </div>

                <div class="box logo-box">
                    <img src="https://apre.it/wp-content/uploads/2021/01/logo_uni-pisa.png"
                         alt="Logo Università di Pisa"
                         style="width:300px; float: center;"/>
                </div>

                <div class="box">
                    <h2>Informazioni sulla Pubblicazione: </h2>
                    <ul class="info-list">
                    <xsl:apply-templates select="//tei:publicationStmt/*"/>
                    </ul>
                </div>

            </div>

            <p  class="footer-repo">
                Repository <a href="https://github.com//">GitHub</a>
            </p>

        </footer>
    </div>

</body>
</html>

    </xsl:template> 



    <xsl:template match="tei:lb"><br/></xsl:template>

    <!-- Template aggiunta id per paragrafi -->
    <!-- TEMPLATE PER TUTTI GLI <ab> (inclusi i pezzi divisi) -->
<xsl:template match="tei:ab">
    <div class="paragrafo" id="{@xml:id}">
        <xsl:apply-templates/>
    </div>
</xsl:template>

<xsl:template match="tei:pb">
    <div class="page-break">
        <a>
            <xsl:attribute name="href">
                <xsl:text>#Pag</xsl:text>
                <xsl:value-of select="@n"/>
            </xsl:attribute>
            <xsl:value-of select="@n"/>
        </a>
    </div>
</xsl:template>


<!-- Titoli TEI -->
<xsl:template match="tei:head">
    <h2>
        <xsl:attribute name="class">
            <xsl:text>titolo</xsl:text>
            <xsl:if test="@rend">
                <xsl:text> </xsl:text>
                <xsl:value-of select="@rend"/>
            </xsl:if>
        </xsl:attribute>
        <xsl:apply-templates/>
    </h2>
</xsl:template>


<!--CHIAVI--> <!-- per cercare partendo dal valore di @ref -->

<xsl:key name="personById" match="tei:person" use="@xml:id"/>
<xsl:key name="placeById" match="tei:place" use="@xml:id"/>
<xsl:key name="orgById"   match="tei:org"   use="@xml:id"/>
<xsl:key name="titleById" match="tei:title" use="@xml:id"/>


<!-- METODO 
1) Se c'è un link associato all'ID ==> recupera link con chiave
2) Se @ref è un URL ==> crea link diretto
3) Altrimenti genera uno span evidenziabile 
-->

<!-- PERSONE -->
<xsl:template match="tei:persName">
    <xsl:variable name="targetId" select="substring-after(@ref, '#')"/>

    <!-- Estrae il link associato all'ID con la chiave personById-->
    <xsl:variable name="externalLink"
        select="key('personById', $targetId)/@corresp"/>

    <xsl:choose>

        <!-- Se esiste un link -->
        <xsl:when test="$externalLink">
            <a class="persName"
               href="{$externalLink}"
               target="_blank"
               xmlns="">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <!-- Altrimenti se ha link diretto lancia quello -->
        <xsl:when test="@ref and not(starts-with(@ref, '#'))">
            <a class="persName" href="{@ref}" target="_blank" xmlns="">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <!-- Se non c'è link, rimane evidenziabile -->
        <xsl:otherwise>
            <span class="persName" xmlns="">
                <xsl:apply-templates/>
            </span>
        </xsl:otherwise>

    </xsl:choose>
</xsl:template>




<!-- LUOGHI -->
<xsl:template match="tei:placeName">
    <xsl:variable name="id" select="substring-after(@ref, '#')"/>

    <!-- Estrae il link associato all'ID con la chiave placeById -->
    <xsl:variable name="link" select="key('placeById', $id)/@corresp"/>

    <xsl:choose>
        <!-- Se esiste un link -->
        <xsl:when test="$link">
            <a xmlns="" class="placeName" href="{$link}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <!-- Altrimenti se ha link diretto lancia quello -->
        <xsl:when test="@ref and not(starts-with(@ref, '#'))">
            <a xmlns="" class="placeName" href="{@ref}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <!-- Se non c'è link rimane evidenziabile -->
        <xsl:otherwise>
            <span class="placeName" xmlns="">
                <xsl:apply-templates/>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- ORGANIZZAZIONI -->
<xsl:template match="tei:orgName">
    <xsl:variable name="id" select="substring-after(@ref, '#')"/>

<!-- Estrae il link associato all'ID con la chiave orgById' -->
    <xsl:variable name="link" select="key('orgById', $id)/@corresp"/>

    <xsl:choose>
     <!-- Se esiste un link -->
        <xsl:when test="$link">
            <a xmlns="" class="orgName" href="{$link}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

         <!-- Altrimenti se ha link diretto lancia quello -->
        <xsl:when test="@ref and not(starts-with(@ref, '#'))">
            <a xmlns="" class="orgName" href="{@ref}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <!-- Se non c'è link rimane evidenziabile -->
        <xsl:otherwise>
            <span class="orgName" xmlns="">
                <xsl:apply-templates/>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- Evidenzia le citazioni nel testo -->
<xsl:template match="tei:quote">
    <span class="citazione">
        <xsl:apply-templates/>
    </span>
</xsl:template>

<!-- Evidenzia le date nel testo -->
<xsl:template match="tei:date">
    <span class="date">
        <xsl:apply-templates/>
    </span>
</xsl:template>



<xsl:template match="tei:addName[@type='epithet']">
    <xsl:apply-templates/>
</xsl:template>

<!-- Evidenzia le lingue diverse dalla lingua del documento originale nel testo -->
<xsl:template match="tei:foreign">
    <span class="foreign">
        <xsl:apply-templates/>
    </span>
</xsl:template>


<!-- Evidenzia i titoli di opere nel testo (stessa gestione di place, org e person)-->
<xsl:template match="tei:title">
    <xsl:variable name="id" select="substring-after(@ref, '#')"/>
    <xsl:variable name="link" select="key('titleById', $id)/@corresp"/>

    <xsl:choose>
        <xsl:when test="$link">
            <a xmlns="" class="opere" href="{$link}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <xsl:when test="@ref and not(starts-with(@ref, '#'))">
            <a xmlns="" class="opere" href="{@ref}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <xsl:otherwise>
            <span class="opere" xmlns="">
                <xsl:apply-templates/>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- Evidenzia casa editrice -->
<xsl:template match="tei:publisher">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:rs[@type='people']">
  <span class="popoli">
    <xsl:apply-templates/>
  </span>
</xsl:template>


<!-- MOSTRA SEMPRE L’ORIGINALE -->
<xsl:template match="tei:sic">
        <xsl:apply-templates/>
</xsl:template>

<!-- LA CORREZIONE È NASCOSTA DI DEFAULT -->
<xsl:template match="tei:corr">
        <xsl:apply-templates/>
</xsl:template>


<!-- Inserisce l’immagine del facsimile tratta da <graphic> -->
<xsl:template match="tei:surface">
    <img xmlns="" src="{tei:graphic/@url}" />
</xsl:template>


<!-- Template per disegnare tutte le zone: POINTS O ULX/ULY/LRX/LRY -->
<xsl:template match="tei:zone">
    <div class="zone-overlay">
        <xsl:attribute name="data-corresp">
            <xsl:value-of select="@corresp"/>
        </xsl:attribute>

        <xsl:attribute name="style">

            <!-- Zona definita con ULX/ULY/LRX/LRY -->
            <xsl:if test="@ulx">
                <xsl:text>left:</xsl:text><xsl:value-of select="@ulx"/>px;
                <xsl:text>top:</xsl:text><xsl:value-of select="@uly"/>px;

                <xsl:text>width:</xsl:text>
                <xsl:value-of select="@lrx - @ulx"/>px;

                <xsl:text>height:</xsl:text>
                <xsl:value-of select="@lry - @uly"/>px;
            </xsl:if>

            <!-- Zona definita con POINTS -->
            <xsl:if test="@points">
                <xsl:variable name="pts" select="normalize-space(@points)"/>

                <xsl:variable name="p1" select="substring-before($pts,' ')"/>
                <xsl:variable name="p2" select="substring-before(substring-after($pts,' '),' ')"/>

                <xsl:variable name="x1" select="number(substring-before($p1,','))"/>
                <xsl:variable name="y1" select="number(substring-after($p1,','))"/>

                <xsl:variable name="x2" select="number(substring-before($p2,','))"/>
                <xsl:variable name="y2" select="number(substring-after($p2,','))"/>

                <!-- Normalizza coordinate per creare un rettangolo sempre valido -->
                <xsl:variable name="left"   select="min(($x1,$x2))"/>
                <xsl:variable name="top"    select="min(($y1,$y2))"/>
                <xsl:variable name="width"  select="abs($x2 - $x1)"/>
                <xsl:variable name="height" select="abs($y2 - $y1)"/>

                left:<xsl:value-of select="$left"/>px;
                top:<xsl:value-of select="$top"/>px;
                width:<xsl:value-of select="$width"/>px;
                height:<xsl:value-of select="$height"/>px;
            </xsl:if>

        </xsl:attribute>
    </div>
</xsl:template>



<xsl:template match="tei:lg">
        <xsl:apply-templates/>
</xsl:template>


<xsl:template match="tei:l">
        <xsl:apply-templates/>
</xsl:template>




<!-- Serie / Volumi e capitoli codificati -->
<xsl:template match="tei:seriesStmt">
    <!-- Raggruppa i biblScope ogni volta che incontra un nuovo volume -->
    <xsl:for-each-group select="tei:biblScope"
                        group-starting-with="tei:biblScope[@unit='volume']">

        <p>
            <xsl:text>Volume </xsl:text>
            <!-- il primo elemento del gruppo è sempre il volume -->
            <xsl:value-of select="current-group()[1]"/>
            <xsl:text>: capitoli </xsl:text>

            <!-- gli altri elementi del gruppo sono i capitoli -->
            <xsl:for-each select="current-group()[position() &gt; 1]">
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">
                    <xsl:text>, </xsl:text>
                </xsl:if>
            </xsl:for-each>
        </p>

    </xsl:for-each-group>
</xsl:template>

<!-- Per evidenziare pubPlace (stessa logica di pers, org ecc)-->
<xsl:template match="tei:pubPlace">
    <xsl:variable name="id" select="substring-after(@ref, '#')"/>
    <xsl:variable name="link" select="key('placeById', $id)/@corresp"/>

    <xsl:choose>
       
        <xsl:when test="$link">
            <a xmlns="" class="placeName" href="{$link}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        
        <xsl:when test="@ref and not(starts-with(@ref, '#'))">
            <a xmlns="" class="placeName" href="{@ref}" target="_blank">
                <xsl:apply-templates/>
            </a>
        </xsl:when>

        <xsl:otherwise>
            <span xmlns="" class="placeName">
                <xsl:apply-templates/>
            </span>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- Object Desc -->
<xsl:template match="tei:objectDesc">
    <div class="objectdesc">
        <xsl:apply-templates select="tei:supportDesc"/>
        <xsl:apply-templates select="tei:layoutDesc"/>
    </div>
</xsl:template>

<!-- Support Desc -->
<xsl:template match="tei:supportDesc">
    <div class="supporto">

        <p>
            <strong>Materiale:</strong>
            <xsl:text> </xsl:text>
            <xsl:value-of select="@material"/>
        </p>

        <xsl:apply-templates select="tei:support"/>
        <xsl:apply-templates select="tei:condition"/>
    </div>
</xsl:template>

<!-- Support -->
<xsl:template match="tei:support">
    <p>
        <strong>Supporto:</strong>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
    </p>
</xsl:template>

<!-- Condition -->
<xsl:template match="tei:condition">
    <p>
        <strong>Condizioni:</strong>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
    </p>
</xsl:template>

<!-- Layout -->
<xsl:template match="tei:layoutDesc">
    <div class="layout">
        <p>
            <strong>Layout:</strong>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="tei:layout"/>
        </p>
    </div>
</xsl:template>

<xsl:template match="tei:layout">
    <xsl:apply-templates/>
</xsl:template>


<!-- Lista -->
<xsl:template match="tei:list">
    <ul>
        <xsl:apply-templates/>
    </ul>
</xsl:template>

<!-- ELlementi della lista -->
<xsl:template match="tei:item">
    <li>
        <xsl:apply-templates/>
    </li>
</xsl:template>

<xsl:template match="tei:p">
    <p>
        <xsl:apply-templates/>
    </p>
</xsl:template>


<xsl:template match="tei:milestone[@unit='rule']">
    <hr class="milestone-rule"/>
</xsl:template>

</xsl:stylesheet>
