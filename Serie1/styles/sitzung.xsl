<?xml version="1.0" encoding="UTF-8"?>
<!--  Ministerratsprotokolle Stylesheet -->
<!--  Autor: heinz.rosenkranz@a7111.com -->
<!--  Edit: vittorio.muth@infodock.eu 20190202: Entfernen der Bandherausgeberangabe, Logo mit Link zur Editionsstartseite -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Common Parameters -->
<xsl:param name="Text">#301010;</xsl:param>   <!-- Standard Textcolor --> 
<xsl:param name="iText">#e0e4e4;</xsl:param>   <!-- Inverse Textcolor --> 
<xsl:param name="menu">#606060;</xsl:param>   <!-- Menu Textcolor --> 
<xsl:param name="title">#801010;</xsl:param>   <!--  Title color --> 
<xsl:param name="navi">#183668;</xsl:param>   <!--  Topnavi color blue: 183668   brown: 603230 --> 
<xsl:param name="media">#707080;</xsl:param>   <!--  Mediabox color --> 


<!-- Define common URI prefix 
<xsl:param name="uri-prefix">//www.austriaca.at/ministerrat/serie-1/</xsl:param>-->
<xsl:param name="uri-prefix">/ministerrat/serie-1/</xsl:param>


<!-- Define Base URI (common Book ID -->
<xsl:param name="base-uri" select="/MR/@id"/>

<!-- Get Book Index (_index.xml) -->
<xsl:param name="index-file">../<xsl:value-of select="//@id"/>/_index.xml</xsl:param>
<xsl:param name="book-index" select="document($index-file)/Definitionen"/>


<!--   ROOT TEMPLATE    -->
<xsl:template match="/">
<html>
<head>
	<xsl:call-template name="makeMetadata"/>
	<xsl:call-template name="makeCSS"/>
	<script src="/ministerrat/serie-1/_styles/host_min_serie1.js" type="text/javascript"></script>
</head>

<body>
<div>
	<!--  Outer Table for centered Content -->
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td> </td> <!-- spacer left -->
		<td width="1120">
			<!-- Header -->
			<a href="/ministerrat">
			<img src="/ministerrat/serie-1/_styles/logo10.jpg" alt="Logo"/><br />
			</a>
			<!-- Inner Table: Left-Menu - Content Area - Right Mediabox -->
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
			<tr valign="top">
				<td class="noprint" width="225"> <xsl:call-template name="makeMenu"/> </td>
				<td width="15">   </td>
				<td class="content" width="650"> 
					<xsl:call-template name="makeTopNavi"/>
					<br/>
					<xsl:call-template name="makeContent"/> 
				</td>
				<td width="20">   </td>
				<td width="210" class="info">	<xsl:call-template name="makeMedia"/>	</td>
			</tr>
			</table>
		</td>
		<td> </td> <!-- spacer right -->
	</tr>
	</table>
</div>
</body>
</html>
</xsl:template>


<!-- Make the Left-Menu -->
<xsl:template name="makeMenu">
<div class="menu">
	<div style="text-align:center; margin-top:3px; padding:5px; background:#e0e4e4">
		<xsl:apply-templates select="$book-index/Titelei"/>
	</div>
	<div style="margin-top:12px;">
		<span style="margin-top:12px; background:#e0e4e4">
			<a class="menu"  title="  Zurück zur Startseite  " href="javascript: history.back();">
				<!-- xsl:attribute name="href"><xsl:value-of select="$base-uri"/>.xml</xsl:attribute -->
				  ◄  zurück    
			</a>
		</span>
		    
		<a class="menu" target="_new" title="  Diese Sitzung als PDF-Dokument  ">
			<xsl:attribute name="href">
				<!-- pdf/<xsl:value-of select="MR/Sitzung/@id"/>.pdf<xsl:value-of select="MR/@url"/ -->
				pdf/<xsl:value-of select="MR/Sitzung/@id"/>.pdf#zoom=100
			</xsl:attribute>
			Sitzung-PDF  <!--<img src="https://hw.oeaw.ac.at/ministerrat/serie-1/_img/pdf.gif" border="0"/> -->
		</a>
	</div>
	<hr/>
	<div class="headline2">Tagesordnung </div>
	<table border="0" cellpadding="1">
		<xsl:for-each select="//Agenda">
			<xsl:choose>
				<!-- Used in rare case of intermediate Agenda-Headlines (Hefte) -->
				<xsl:when test="@name = '' ">
					<tr valign="top">
						<td class="menu" colspan="2"><xsl:value-of select="@nr"/></td>
					</tr>
				</xsl:when>
				<!-- Standard usage -->
				<xsl:otherwise>
					<tr valign="top">
						<td class="menu" align="right"><xsl:value-of select="@nr"/></td>
						<td class="menu">
							<a class="menu">
								<xsl:attribute name="href">#<xsl:value-of select="@nr"/></xsl:attribute>
								<xsl:value-of select="@name"/>
							</a>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>			
		</xsl:for-each>
	</table>
	<br /><br />
	<a href="https://www.oeaw.ac.at/inz/" target="_new" title="Institut für Neuzeit - und Zeitgeschichteforschung">
		<img src="/ministerrat/serie-1/_img/INZ_Logo2.jpg" border="0"/>
	</a>
</div>
</xsl:template>


<!-- Make CONTENT -->
<xsl:template name="makeContent">
	<!--<h1><xsl:apply-templates select="/MR/Titel/Name"/> </h1>
	<h2><xsl:apply-templates select="/MR/Titel/Titel/Name"/> </h2> -->
	<xsl:for-each select="//Sitzung">
		<p style="font-size:15px; font-weight:bold">
			Nr.   <xsl:value-of select="substring-after(@id, '-z')"/>   
			<xsl:value-of select="Name/@formal"/>
		</p>
		<div style="margin-left:50px; font-size:12px">
			<i><xsl:apply-templates select="Teilnehmer"/></i> 
			<br />
			<!-- Topside Agenda Overview List -->
			<xsl:for-each select="Agenda[@nr != '' ]">
				<b><xsl:value-of select="@nr"/></b> <xsl:value-of select="@name"/>.  
			</xsl:for-each>
		</div>
		<p>
			<xsl:if test="@mrz">MRZ. <xsl:value-of select="@mrz"/> </xsl:if>
			<xsl:if test="@mkz">MKZ. <xsl:value-of select="@mkz"/> </xsl:if>
			<xsl:if test="@mcz">MCZ. <xsl:value-of select="@mcz"/> </xsl:if>
			– KZ. <xsl:value-of select="@kz"/>
		</p>
		<p><xsl:apply-templates select="Name"/> </p>
	</xsl:for-each>
	<!-- Resolve Agenda -->
	<xsl:for-each select="//Agenda">
		<a> <xsl:attribute name="name"><xsl:value-of select="@nr"/></xsl:attribute> </a>
		<xsl:apply-templates/>
		<br />
	</xsl:for-each>
	<xsl:apply-templates select="//Floskel"/>
	<!--<br/><br/>-->
	<!-- autor ein/ausblenden -->
	<!--<div align="right"><xsl:value-of select="//Autor"/></div>-->
	<!--<b/><br />-->
	
	<!--  Footnotes -->
	<!-- Enable Lines below to show footnotes at the end of document -->
	<!-- xsl:if test="//p[@type = 'Fussnote']">
		<table border="0" cellpadding="0" width="95%">
			<xsl:for-each select="//p[@type = 'Fussnote']">
				<tr valign="top">
					<td width="30" align="right"><sup><xsl:value-of select="@nr"/></sup></td>
					<td width="15"/>
					<td class="comment"><i><xsl:apply-templates/></i></td>
				</tr>
			</xsl:for-each>
		</table>
	</xsl:if -->

	<!-- Make Trailer -->
	<br />
	<hr class="ruler" />
	<div class="comment">
		<xsl:if test="//Autor">
			<b>Zitierregel: </b><!--<br />-->
			<xsl:apply-templates select="$book-index/Zitat"/>
			Sitzung. Nr. <xsl:value-of select="substring-after(//Sitzung/@id, '-z')"/>, <!-- <br /> -->
			URL: https://hw.oeaw.ac.at<xsl:value-of select="$uri-prefix"/><xsl:value-of select="//@id"/>/<xsl:text/>
			<xsl:value-of select="//Sitzung/@id"/>.xml			
		</xsl:if>
	</div>
	<!--<p>
		<xsl:attribute name="style">font-weight:bold; color:<xsl:value-of select="$title"/>;</xsl:attribute>
		Die Protokolle des österreichischen Ministerrates 1848–1867<br />
		Herausgegeben vom Institut für Neuzeit - und Zeitgeschichteforschung <br />
		und der Österreichischen Akademie der Wissenschaften in Wien <br />
		<xsl:apply-templates select="//Publikation"/>
	</p> -->
	<p class="comment">
	Lizenz: Open Access, Alle Rechte vorbehalten <!--<a href="https://creativecommons.org/licenses/by-sa/4.0/legalcode.de" target="_blank">https://creativecommons.org/licenses/by-sa/4.0/legalcode.de</a>-->
	</p>
	<p>
		<img src="/ministerrat/serie-1/_img/oeaw-logo.gif" alt="OEAW-Logo" align="left"/>
		<br/>Verlag der Österreichischen Akademie der Wissenschaften <br />Austrian Academy of Sciences Press 
	</p>
	<p class="comment">
	<a href="/ministerrat/impressum.htm" target="_blank">Impressum</a>
	</p>	
	
</xsl:template>

<!-- Make the Mediacollection -->
<xsl:template name="makeMedia">
<!--	<div class="headline"><b>Schlagworte</b></div>
	<div>
		<xsl:attribute name="style">background:<xsl:value-of select="$iText"/> padding:6px;</xsl:attribute>
		<xsl:call-template name="makeKeywords"/>
	</div>
	<br />
	<div class="headline"><b>Zitierte Archive</b></div>
	<div>
		<xsl:attribute name="style">background:<xsl:value-of select="$iText"/> padding:6px;</xsl:attribute>
		<xsl:for-each select="//src">
			<xsl:choose>
				<xsl:when test=". = 'ebd.' "></xsl:when>
				<xsl:otherwise><xsl:value-of select="."/><br /></xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</div>
	<br />
	<div class="headline"><b>Zitierte Publikationen</b></div>
	<div>
		<xsl:attribute name="style">background:<xsl:value-of select="$iText"/> padding:6px;</xsl:attribute>
		<xsl:for-each select="//bib"><xsl:apply-templates select="."/><br /> </xsl:for-each>
	</div>
	<br /> -->
</xsl:template>


<!--   XSLT  Library   -->

<!-- Suche nach Stichwörter im Text -->
<xsl:template name="makeKeywords">
	<xsl:for-each select="//Titel/Name">
		<xsl:apply-templates select="."/> • 
	</xsl:for-each>
	<xsl:for-each select="//Sitzung/Name/@formal"><xsl:value-of select="."/> • </xsl:for-each>
	<!-- xsl:for-each select="//dfn">  •  <xsl:value-of select="."/></xsl:for-each -->
	<xsl:for-each select="//bio">
		<xsl:choose>
			<xsl:when test="@Name"> 
				<span style="cursor:help;">
					<xsl:attribute name="title"> <xsl:value-of select="text()"/> </xsl:attribute>
					<xsl:value-of select="@Name"/>
					<xsl:if test="@Vorname">, <xsl:value-of select="@Vorname"/></xsl:if>
				</span> • 
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/> •  
			</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	<xsl:for-each select="//geo">
		<xsl:text/>  • 
		<span style="cursor:help;">
			<xsl:attribute name="title"> <xsl:value-of select="text()"/> </xsl:attribute>
			<xsl:value-of select="@Ort"/>
			<xsl:if test="@Objekt">, <xsl:value-of select="@Objekt"/></xsl:if>
			<!-- xsl:if test="@Land"> (<xsl:value-of select="@Land"/>)</xsl:if -->
		</span>
	</xsl:for-each>
</xsl:template>
<xsl:template name="makeMetaKeywords">
	<xsl:for-each select="//Titel/Name"><xsl:value-of select="."/>   </xsl:for-each>
	<xsl:for-each select="//Sitzung/Name/@formal"><xsl:value-of select="."/> • </xsl:for-each>
	<xsl:for-each select="//bio[text()] | //geo | //dfn"> •  <xsl:value-of select="."/> </xsl:for-each>
</xsl:template>

<!-- Formatierungen -->
<xsl:template match="b"> <b><xsl:apply-templates /></b> </xsl:template>
<xsl:template match="i"> <i><xsl:apply-templates /></i> </xsl:template>
<xsl:template match="u"> <u><xsl:apply-templates /></u> </xsl:template>
<xsl:template match="em"> <em><xsl:apply-templates /></em> </xsl:template>
<xsl:template match="sup"> <sup><xsl:apply-templates /></sup> </xsl:template>
<xsl:template match="sub"> <sub><xsl:apply-templates /></sub> </xsl:template>
<!--<xsl:template match="br"> <br /> </xsl:template>-->
<xsl:template match="br[not(parent::Zitat)]"> <br /> </xsl:template>
<xsl:template match="hr"><hr/></xsl:template>
<xsl:template match="a">
	<a target="_blank">
		<xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
		<xsl:apply-templates/>
	</a>
</xsl:template>

<xsl:template match="bib">
	<span class="normal"><xsl:apply-templates /></span>
</xsl:template>
<xsl:template match="aut | pub">
	<span style="font-variant:small-caps; color:#005050"><xsl:apply-templates /></span>
</xsl:template>
<xsl:template match="src">
	<span class="normal" style="color:#805020"><xsl:apply-templates /></span>
</xsl:template>
<xsl:template match="zit">
	<span class="normal"><xsl:apply-templates /></span>
</xsl:template>
<xsl:template match="mrp">
	<!-- span class="normal" style="color:#000090"><xsl:apply-templates /></span -->
	<xsl:variable name="roman"> I1- II2- III3- IV4- V5- VI6-</xsl:variable>
	<xsl:variable name="nr" select="translate(substring-after(., 'Nr. '), '.)', '')"/>
	<xsl:variable name="band" select="substring-before(substring-after(., '/'), ',')"/>
	<xsl:variable name="abt0" select="substring-before(substring-after(., 'ÖMR.'), '/')"/>
	<xsl:variable name="abt" select="substring-before(substring-after($roman, $abt0), '-')"/>
	<xsl:variable name="obj">
		../a<xsl:value-of select="$abt"/>-b<xsl:value-of select="$band"/>/
		a<xsl:value-of select="$abt"/>-b<xsl:value-of select="$band"/>-z<xsl:value-of select="$nr"/>.xml
	</xsl:variable>
	<span class="normal">
		<a target="_blank">
			<xsl:attribute name="href"><xsl:value-of select="$obj"/> </xsl:attribute>
			<xsl:apply-templates/>
		</a>
	</span>
</xsl:template>

<!-- Image Templates -->
<xsl:template match="img">
	<img alt="" border="0" vspace="9">
		<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
	</img>
</xsl:template>
<xsl:template match="img[@inline]">
	<img alt="" border="0" style="margin-bottom:-5px">
		<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
	</img>
</xsl:template>
<xsl:template match="img[@align]">
	<img border="0">
		<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
		<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
	</img>
</xsl:template>
<xsl:template match="img[@width]">
	<a target="_blank">
		<xsl:attribute name="href"><xsl:value-of select="@src"/></xsl:attribute>
		<img alt=" zum Vergrößern anklicken "  border="0">
			<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
		</img>
	</a>
</xsl:template>
<xsl:template match="img[@align][@width]">
	<a target="_blank">
		<xsl:attribute name="href"><xsl:value-of select="@src"/></xsl:attribute>
		<img alt=" zum Vergrößern anklicken "  border="0">
			<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
			<xsl:attribute name="align"><xsl:value-of select="@align"/></xsl:attribute>
			<xsl:attribute name="width"><xsl:value-of select="@width"/></xsl:attribute>
		</img>
	</a>
</xsl:template>

<xsl:template match="p">
	<p style="margin-top:6px; margin-bottom:3px; ">
		<xsl:apply-templates />
	</p>
</xsl:template>
<xsl:template match="p[@align]">
	<p>
		<xsl:attribute name="style">margin-top:3px; margin-bottom:3px; text-align:<xsl:value-of select="@align"/></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>
<xsl:template match="p[@style]">
	<p>
		<xsl:attribute name="style"><xsl:value-of select="@style"/></xsl:attribute>
		<xsl:apply-templates />
	</p>
</xsl:template>
<xsl:template match="p[parent:: Agenda][1]">
	<p style="margin-top:6px; margin-bottom:3px; ">
		<b style="cursor:help">
			<xsl:attribute name="title"> <xsl:value-of select="../@name"/> </xsl:attribute>
			<xsl:value-of select="../@nr"/>
		</b>
		 <xsl:apply-templates />
	</p>
</xsl:template>


<!-- Footnote Templates (direct placement) -->
<xsl:template match="p[@type = 'Fussnote']">
	<table border="0" cellpadding="0" width="95%">
		<tr valign="top">
			<td width="30" align="right"><sup><xsl:value-of select="@nr"/></sup></td>
			<td width="15"/>
			<td class="comment"><i><xsl:apply-templates/></i></td>
		</tr>
	</table>
</xsl:template>
<!-- Footnotes -->
<!-- Enable Filter Template below to prevent direct placement of footnotes -->
<!-- xsl:template match="p[@type = 'Fussnote']"/ -->

<!-- Match Footnote Processing-Instruction -->
<xsl:template match="processing-instruction()[name() = 'nn']">
	<xsl:param name="nr" select="normalize-space(.)"/>
	<sup style="color:#800000; font-weight:bold; cursor:help;">
		<xsl:attribute name="title"> <xsl:value-of select="//p[@nr = $nr]"/> </xsl:attribute>
		<xsl:value-of select="$nr"/>
	</sup>
</xsl:template>

<!-- Match Page Processing-Instruction -->
<xsl:template match="processing-instruction()[name() = 'page']">
	<xsl:param name="seite" select="normalize-space(.)"/>
	<a><xsl:attribute name="name">Page<xsl:value-of select="$seite"/></xsl:attribute></a>
	<p style="color:#606060; background-color:#FFE8D0; "> BUCHSEITE <xsl:value-of select="$seite"/> </p>
</xsl:template>



<!--   HTML Preparation Utilities   -->
<!--   ====================   -->
<!--  HTML Metadata  -->
<xsl:template name="makeMetadata">
	<title>MRP <xsl:value-of select="//Name"/></title>
	<!-- meta content="text/html; charset=utf-8" http-equiv="Content-Type"></meta -->
	<meta name="description" content="Die Protokolle des österreichischen Ministerrates 1848-1867"></meta>
	<meta name="keywords">
		<xsl:attribute name="content"><xsl:call-template name="makeMetaKeywords"/></xsl:attribute>
	</meta>
	<!-- Dublin-Core Metatags -->
    <meta name="DC.Type" content="text"/> 
	<meta name="DC.Title" content="Die Protokolle des österreichischen Ministerrates 1848-1867"/>
    <meta name="DC.Subject">
		<xsl:attribute name="content"><xsl:call-template name="makeMetaKeywords"/></xsl:attribute>
    </meta>
	<meta name="DC.Description" content="{//Kurzdefinition}"/>
	<meta name="DC.Format" content="text/html"/> 
	<meta name="DC.Identifier" content="https://hw.oeaw.ac.at/ministerrat"/> 
	<meta name="DC.Language" content="de"/> 
	<meta name="DC.Creator" content="Verlag der Österreichischen Akademie der Wissenschaften"/> 
	<meta name="DC.Publisher" content="Verlag der Österreichischen Akademie der Wissenschaften"/> 
	<meta name="DC.Rights" content="Österreichische Akademie der Wissenschaften"/>
	<meta name="DC.Relation" content="Elektronische Publikation"/> 
	<meta name="DC.Date" content="2019"/> 
</xsl:template>

<xsl:template name="makeCSS">
	<style type="text/css">
body { font-family:Arial Unicode MS, Arial; font-size:13px; color:<xsl:value-of select="$Text"/> }
td 	{ font-family:Arial Unicode MS, Arial; font-size:13px; color:<xsl:value-of select="$Text"/> }
em 	{ font-style:normal; letter-spacing: 0.1em }
pre 	{ font-family:Cambria, Times New Roman; }
sup, sub {  font-size:11px; }
h1 { font-size:24px; text-align:center; margin-bottom:0px; color:<xsl:value-of select="$title"/>; }
h2 { font-size:18px; text-align:center; margin-top:0px; color:<xsl:value-of select="$title"/>; }
.ruler { line-height:9px; color:<xsl:value-of select="$iText"/> }
.menu  { font-size:12px; color:<xsl:value-of select="$menu"/>; }
.content { font-family:Cambria, Times New Roman; font-size:15px;  text-align:justify; padding-top:6px }
.comment { font-family:Cambria, Times New Roman; font-size:13px; }
.normal { font-style:normal; }
.info  { font-size:10px; color:<xsl:value-of select="$menu"/>;}
.headline { padding:3px; color:<xsl:value-of select="$iText"/> background:<xsl:value-of select="$media"/> margin-top:3px; letter-spacing: 0.1em }
.headline2 { color:<xsl:value-of select="$menu"/> font-weight:bold; margin-top:12px; margin-bottom:6px; }
.button { border: solid 1px #c8c8c8; color:<xsl:value-of select="$navi"/> text-align:center; font-weight:bold; }
.button1 { background:<xsl:value-of select="$navi"/> color:<xsl:value-of select="$iText"/> text-align:center; font-weight:bold; }
.key1 { color:<xsl:value-of select="$menu"/> border:solid 1px <xsl:value-of select="$media"/> text-align:center; }
.key2 { color:<xsl:value-of select="$iText"/> background:<xsl:value-of select="$media"/>  text-align:center; }
a { text-decoration: none }
a:link { color:#000090 }
a:visited { color:#000090 }
a:hover { color:darkRed; text-decoration:none; }
a.menu:link { color:<xsl:value-of select="$menu"/> }
a.menu:visited { color:<xsl:value-of select="$menu"/> }
a.menu:hover { color:darkRed; text-decoration:none; } 
a.action:link { color:<xsl:value-of select="$navi"/> }
a.action:visited { color:<xsl:value-of select="$navi"/> }
a.action:hover { color:darkRed; text-decoration:none; } 
.noprint { display:block; }
@media print { .noprint { display:none } }	
	</style>
</xsl:template>


<!--  Top Navigation  -->
<xsl:template name="makeTopNavi">
<div style="margin-top:-0px">
		<form name="fulltext" method="post" target="resultwindow" onsubmit="search('ministerrat_1', document.getElementsByName('search_entry')[0].value); return false;" style="margin-top: -4px">
			<script src="/adoe/_styles/host.js" type="text/javascript"/>
			<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr>

					<td class="" style="width:300px;">
						<input type="hidden" name="searching" value="simple"/>
						<input size="30" name="search_entry" value="Suche in XML" onfocus="this.select();" onmouseup="return false;" style="font-size:13px; height:21x; border:solid 1px #c8c8c8; width:250px; margin-left: 1px; padding-left:4px;"/>
					</td>
					<td></td>
					<td class="button">
						<a class="action" href="javascript: search('ministerrat_1', document.getElementsByName('search_entry')[0].value)">Suche</a>
					</td>
					<td>  </td>
					<td class="button"><a class="action" href="javascript: pagePrint();">  Druck  </a></td>
					<td>  </td>
					<td class="button"><a class="action" href="/ministerrat/serie-1/_styles/hilfe.htm" target="_blank">  Hilfe  </a></td>
				</tr>
			</table>
		</form>

<!--<form name="fulltext" method="post" target="resultwindow" onsubmit="ftsearch();" style="margin-top:-6px">
	<table border="0" width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td  class="button">
			<input type="hidden" name="searching" value="simple"/>
			<input size="40"  name="search_entry" value="Suchbegriff" onfocus="this.select();" onmouseup="return false;" 
					style="font-size:13px; height:18px; border:solid 0px #c8c8c8; "/>
		</td>
		<td>  </td>
		<td class="button"><a class="action" href="javascript: search(document.getElementsByName('search_entry')[0].value)">  Suche  </a></td>
		<td>  </td>
		<td class="button"><a class="action" href="javascript: extendedSearch();">  Erweiterte Suche  </a></td>
		<td>  </td> 
		<td class="button"><a class="action" href="javascript: pagePrint();">  Ausdruck  </a></td>
		<td>  </td>
		<td class="button"><a class="action" href="https://hw.oeaw.ac.at/ministerrat/serie-1/_styles/hilfe.htm" target="_blank">  Hilfe  </a></td>
	</tr>
	</table>
</form> -->
</div>
</xsl:template>

</xsl:stylesheet>
