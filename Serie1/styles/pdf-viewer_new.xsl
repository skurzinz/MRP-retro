<?xml version="1.0" encoding="UTF-8"?>
<!--  Ministerratsprotokolle Stylesheet -->
<!--  Autor: heinz.rosenkranz@a7111.com -->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- Common Parameters -->
<xsl:param name="Text">#301010;</xsl:param>   <!-- Standard Textcolor --> 
<xsl:param name="iText">#d0d0d0;</xsl:param>   <!-- Inverse Textcolor --> 
<xsl:param name="menu">#505050;</xsl:param>   <!-- Menu Textcolor --> 
<xsl:param name="title">#801010;</xsl:param>   <!--  Title color --> 
<xsl:param name="navi">#183668;</xsl:param>   <!--  Topnavi color blue: 183668   brown: 603230 --> 
<xsl:param name="media">#808090;</xsl:param>   <!--  Mediabox color --> 
<xsl:param name="roman">
1I-2II-3III-4IV-5V-6VI-7VII-8VIII-9IX-10X-
11XI-12XII-13XIII-14XIV-15XV-16XVI-17XVII-18XVIII-19XIX-20XX-
21XXI-22XXII-23XXIII-24XXIV-25XXV-26XXVI-27XXVII-28XXVIII-29XXIX-30XXX-
31XXXI-32XXXII-33XXXIII-34XXXIV-35XXXV-36XXXVI-37XXXVII-38XXXVIII-39XXXIX-40XL-
41XLI-42XLII-43XLIII-44XLIV-45XLV-46XLVI-47XLVII-48XLVIII-49XLIX-50L-
51LI-52LII-53LIII-54LIV-55LV-56LVI-57LVII-58LVIII-59LIX-60LX-
61LXI-62LXII-63LXIII-64LXIV-65LXV-66LXVI-67LXVII-68LXVIII-69LXIX-70LXX-
71LXXI-72LXXII-73LXXIII-74LXXIV-75LXXV-76LXXVI-77LXXVII-78LXXVIII-79LXXIX-80LXXX-
81LXXXI-82LXXXII-83LXXXIII-84LXXXIV-85LXXXV-86LXXXVI-87LXXXVII-88LXXXVIII-89LXXXIX-90XC-
</xsl:param>

<!--   ROOT TEMPLATE    -->
<xsl:template match="/">
<html>
<head>
	<xsl:call-template name="makeMetadata"/>
	<xsl:call-template name="makeCSS"/>
	
	<!-- MSIE Page Browsing  -->
	<!-- Insert drowaway-query to URL to enforce a iFrame-refresh -->
	<script src="/ministerrat/serie-1/_styles/jquery-latest.pack.js"></script>																										
	<script src="/ministerrat/serie-1/_styles/navigation.js"></script>
</head>

<body>
	<div>
		<!--  Outer Table for centered Content -->
		<table border="0" width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>&#160;</td> <!-- spacer left -->
			<td width="1300">
				<!-- Header Logo -->
				<img alt="Logo">
					<!-- xsl:attribute name="src"><xsl:value-of select="mrp/@base-uri"/>_img/logo10.jpg</xsl:attribute -->
					<xsl:attribute name="src">_styles/logo10.jpg</xsl:attribute><xsl:attribute name="style">margin-bottom:6px;</xsl:attribute>
				</img>
				<br />
				<!-- Inner Table: Left-Nav  - Top-Nav + Content Area -->
				<table border="0" width="100%" cellpadding="0" cellspacing="0">
				<tr valign="top">
					<!-- Left-Navigation -->
					<td class="menu" width="225"> 
						<xsl:apply-templates mode="menu"/> 
						<xsl:call-template name="makeRecommendation"/> 
					</td>
					<td width="25"> &#160; </td>
					<td class="content"> 
						<!-- Top-Navigation -->
						<div style="line-height:28px"><xsl:call-template name="makeTopNavi"/></div>
						<br/>
						<div id="toc" style="text-align:center;width:100%;display:block;border:0px solid #c0c0c0;">
							<span id="prev" class="nav"><a href="#" onclick="turnPage(-1);return false;" class="nav ui-link" title="1 Seite zurückblättern">&lt;=</a>&#160;S.&#160;</span>
							<span id="actu" class="nav">1</span>
							<span id="next" class="nav">&#160;<a href="#" onclick="turnPage(1);return false;" class="nav ui-link" title="1 Seite weiterblättern">=&gt;</a></span>
</div>
						<!-- The content -->
						<xsl:call-template name="makeContent"/> 
					</td>
				</tr>
				</table>
			</td>
			<td>&#160;</td> <!-- spacer right -->
		</tr>
		</table>
	</div>
</body></html>
</xsl:template>



<!-- TEMPLATES -->
<xsl:template match="HWATTRIBUTES" mode="menu">
	<!--Dieses Template ignoriert die weiteren XML-Tags innerhalb der Hyperwave-XML-Tags-->
</xsl:template>
<xsl:template match="HWATTRIBUTES" mode="topNavi">
	<!--Dieses Template ignoriert die weiteren XML-Tags innerhalb der Hyperwave-XML-Tags-->
</xsl:template>


<!-- Titelei Menüspalte -->
<xsl:template match="Titelei" mode="menu">
	<div style="text-align:center; padding:5px; background:#e0e4e4">
		<xsl:apply-templates select="//Titelei"/>
	</div>
	<br/>
</xsl:template>
<xsl:template match="title">
	<b><xsl:apply-templates/></b>
</xsl:template>

		<!-- Zurück Funktion, eingefügt von gg, 07.06.17 -->
	<xsl:template match="back" mode="menu">
		<div style="width:100px; background:#e0e4e4">
			<a class="menu" href="javascript:history.back()" title="&#160; Zurück zur Startseite &#160;">
				<xsl:if test="@href">
					<xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
				</xsl:if>
			&#160; ◄ &#160;Startseite <!-- text eingefügt von gg, 31.05.16 -->
		</a>
		</div>
		<!--<hr/>-->
		<!-- auskommentiert von gg, 31.05.16 -->
	</xsl:template>

<!-- Menüspalte Auswahllisten -->
<!--    Ab 12 Optionen pro Select-Element eine Dropdown-Liste  -->
<xsl:template match="select" mode="menu">
	<div style="background:#e0e4e4; padding:5px; margin-top: 15px;">  <!-- background, eingefügt von gg, 31.05.16, margin-top:12px; entfernt -->
		<b><xsl:value-of select="@name"/></b><br />
		<xsl:choose>
			<xsl:when test="count(option) &gt; 12"> <!-- *** -->
				<xsl:call-template name="makeDropdown"/> <br/>
				<xsl:for-each select="sequence">
					<div style="margin-top:12px;"><xsl:call-template name="sequenceGenerator"/></div>
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise> <xsl:call-template name="makeList"/> </xsl:otherwise>
		</xsl:choose>
	</div>
	<br />
</xsl:template>

<!-- Kopfzeile Dropdown-Liste (Bandauswahl) -->
<xsl:template name="makeTopNavi">
	<b>Verfügbare Bände</b> &#160;&#160;
	<select style="vertical-align:middle; font-size:12px">
		<xsl:attribute name="onchange">javascript: window.location.href = this.options[this.selectedIndex].value;</xsl:attribute>
		<option value="">...</option>
		<optgroup label="Die Bände der 1.Serie"></optgroup>
			<option value="/ministerrat/serie-1/a0-b0-pdf.xml">Einleitungsband: Ministerratsprotokolle 1848–1867</option>
			<option value="/ministerrat/serie-1/a1-pdf.xml">I. Ministerien des Revolutionsjahres 1848</option>
			<optgroup label="II. Ministerium Schwarzenberg 1848–1852">
				<option value="/ministerrat/serie-1/a2-b1-pdf.xml">Band 1 (5. Dez. 1848–7. Jan. 1850) - Protokoll Nr. 1-248</option>
				<option value="/ministerrat/serie-1/a2-b2-pdf.xml">Band 2 (8. Jan. 1850–30. April 1850) - Protokoll Nr. 249-333</option>
				<option value="/ministerrat/serie-1/a2-b3-pdf.xml">Band 3 (1. Mai 1850–30. Sept. 1850) - Protokoll Nr. 334-405</option>
				<option value="/ministerrat/serie-1/a2-b4-pdf.xml">Band 4 (14. Okt. 1850–30. Mai. 1851) - Protokoll Nr. 406-507</option>
				<option value="/ministerrat/serie-1/a2-b5-pdf.xml">Band 5 (4. Juni. 1851–5. April. 1852) - Protokoll Nr. 508-646</option>
			</optgroup> 
			<optgroup label="III. Ministerium Buol-Schauenstein 1852–1859">
				<option value="/ministerrat/serie-1/a3-b1-pdf.xml">Band 1 (14. April 1852 – 13. März 1853 ) - Protokoll Nr. 1-102</option>
				<option value="/ministerrat/serie-1/a3-b2-pdf.xml">Band 2 (15. März 1853 – 9. Okt. 1853) - Protokoll Nr. 103-165 </option>
				<option value="/ministerrat/serie-1/a3-b3-pdf.xml">Band 3 (11. Okt. 1853 – 19. Dez. 1854 ) - Protokoll Nr. 166-263</option>
				<option value="/ministerrat/serie-1/a3-b4-pdf.xml">Band 4 (23. Dez. 1854 – 12. April 1856) - Protokoll Nr. 264-334</option>
				<option value="/ministerrat/serie-1/a3-b5-pdf.xml">Band 5 (26. April 1856 – 5. Feb. 1857) - Protokoll Nr. 335-384</option>
				<option value="/ministerrat/serie-1/a3-b6-pdf.xml">Band 6 (3. März 1857 – 29. April 1858) - Protokoll Nr. 385-449</option>
				<option value="/ministerrat/serie-1/a3-b7-pdf.xml">Band 7 (4. Mai 1858 – 12. Mai 1859 ) - Protokoll Nr. 450-516</option>
			</optgroup> 
			<optgroup label="IV. Ministerium Rechberg 1859–1861">
				<option value="/ministerrat/serie-1/a4-b1-pdf.xml">Band 1 (19. Mai 1859 – 2./3. März 1860) - Protokoll Nr. 1-119</option>
				<option value="/ministerrat/serie-1/a4-b2-pdf.xml">Band 2 (6. März 1860 – 16. Okt. 1860) - Protokoll Nr. 120-219</option>
				<option value="/ministerrat/serie-1/a4-b3-pdf.xml">Band 3 (21. Okt. 1860 – 2. Feb. 1861) - Protokoll Nr. 220-282</option>
			</optgroup> 
			<optgroup label="V. Erzherzog Rainer und Mensdorff 1861–1865">
				<option value="/ministerrat/serie-1/a5-b1-pdf.xml">Band 1 (7. Feb 1861 – 30. April 1861 ) - Protokoll Nr. 1-58</option>
				<option value="/ministerrat/serie-1/a5-b2-pdf.xml">Band 2 (1. Mai 1861 – 2. Nov. 1861 ) - Protokoll Nr. 59-146</option>
				<option value="/ministerrat/serie-1/a5-b3-pdf.xml">Band 3 (5. Nov. 1861 – 6. Mai 1862 ) - Protokoll Nr. 147-229</option>
				<option value="/ministerrat/serie-1/a5-b4-pdf.xml">Band 4 (8. Mai 1862 – 31. Okt. 1862) - Protokoll Nr. 230-276</option>
				<option value="/ministerrat/serie-1/a5-b5-pdf.xml">Band 5 (3. Nov 1862 – 30. April 1863 ) - Protokoll Nr. 277-348</option>
				<option value="/ministerrat/serie-1/a5-b6-pdf.xml">Band 6 (4. Mai 1863 – 12. Okt. 1863) - Protokoll Nr. 349-403</option>
				<option value="/ministerrat/serie-1/a5-b7-pdf.xml">Band 7 (15. Okt. 1863 – 23. Mai 1864 ) - Protokoll Nr. 404-473</option>
				<option value="/ministerrat/serie-1/a5-b8-pdf.xml">Band 8 (25. Mai 1864 – 26. Nov. 1864 ) - Protokoll Nr. 474-516</option>
				<option value="/ministerrat/serie-1/a5-b9-pdf.xml">Band 9 (9. Dez 1864 – 11. Juli 1865 ) - Protokoll Nr. 517-586</option>
			</optgroup> 
			<optgroup label="IV. Ministerium Belcredi 1865–1867">
				<option value="/ministerrat/serie-1/a6-b1-pdf.xml">Band 1 (29. Juli 1865 – 26. März 1866 ) - Protokoll Nr. 1-56</option>
				<option value="/ministerrat/serie-1/a6-b2-pdf.xml">Band 2 (8. April 1866 – 6. Feb. 1867) - Protokoll Nr. 57-126</option>
			</optgroup> 
		<optgroup label="Die Bände der 2. Serie">	
				<option value="/ministerrat/serie-2/oe_hu_mrp_I1.xml">Band I/1 - Protokoll Nr. 1-66 (1867-1870) </option>
				<option value="/ministerrat/serie-2/oe_hu_mrp_I2.xml">Band I/2 - Protokoll Nr. 1-54 (1870-1871)</option>
				<option value="/ministerrat/serie-2/oe_hu_mrp_IV.xml">Band IV - Protokoll Nr. 1-73 (1883-1895)</option>
				<option value="/ministerrat/serie-2/oe_hu_mrp_V.xml">Band V - Protokoll Nr. 1-75 (1896-1907)</option>
				<option value="/ministerrat/serie-2/oe_hu_mrp_VI.xml">Band VI - Protokoll Nr. 1-47 (1908-1914)</option>
				<option value="/ministerrat/serie-2/oe_hu_mrp_VII.xml">Band VII - Protokoll Nr. 1-41 (1914-1918)</option>
		</optgroup> 
	</select>
<form name="fulltext" method="post" target="resultwindow" onsubmit="search(document.getElementsByName('search_entry')[0].value);return false;" style="margin-top: 10px">
<script src="/ministerrat/serie-1/_styles/host.js" type="text/javascript"/>
				<table border="0" width="250px" cellpadding="0" cellspacing="0">
					<tr>
						
						<td class="">
							<input type="hidden" name="searching" value="simple"/>
							<input size="30" name="search_entry" value="Suche" onfocus="this.select();" onmouseup="return false;" style="font-size:13px; height:21x; border:solid 1px #c8c8c8; width:160px; margin-left: 1px; padding-left:4px;"/>
						</td>
						<td></td>
						<td class="">
							<a class="action" href="javascript: search(document.getElementsByName('search_entry')[0].value)">Suche</a>
						</td>
					</tr>
				</table>
			</form>
</xsl:template>


<!-- Dropdown-Liste -->
<!--    Optionen ohne @value werden ignoriert -->
<!--    Optionen mit @action verlinken zum PDF-Reader -->
<xsl:template name="makeDropdown">
	<select style="margin-top:6px; width:220px; font-size:12px">
		<xsl:attribute name="onchange">javascript: window.location.href = this.options[this.selectedIndex].value;</xsl:attribute>
		<xsl:if test="@action">
			<xsl:attribute name="onchange">javascript: show(this.options[this.selectedIndex].value)</xsl:attribute>
		</xsl:if>
		<xsl:for-each select="option">
			<xsl:if test="@value">
				<option>
					<xsl:attribute name="value"><xsl:value-of select="//mrp/@base-uri"/><xsl:value-of select="@value"/></xsl:attribute>
					<xsl:value-of select="."/>
				</option>
			</xsl:if>
		</xsl:for-each>
	</select>
</xsl:template>

<!-- Simple Liste -->
<!--    Optionen ohne @value werden hellgrau angezeigt -->
<!--    Optionen mit @action verlinken zum PDF-Reader -->
<xsl:template name="makeList">
	<xsl:for-each select="option | sequence">
		<xsl:variable name="uri"><xsl:value-of select="//mrp/@base-uri"/><xsl:value-of select="@value"/></xsl:variable>
		<div style="margin-top:6px">
			<xsl:choose>
				<xsl:when test="@start"><xsl:call-template name="sequenceGenerator"/></xsl:when>
				<xsl:when test="@value">
					<a class="menu">
						<xsl:attribute name="href"><xsl:value-of select="$uri"/></xsl:attribute>
						<xsl:if test="../@action">
							<!-- xsl:attribute name="href">
javascript: document.getElementById('pdfReader').setAttribute('src', '<xsl:value-of select="$uri"/>')
							</xsl:attribute -->
							<xsl:attribute name="href">javascript: show('<xsl:value-of select="$uri"/>')</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates select="."/>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<span style="color:gray"><xsl:apply-templates select="@name"/></span> 
				</xsl:otherwise>
			</xsl:choose>
		</div>
	</xsl:for-each>
</xsl:template>


<!-- Sequenz Generator:  -->
<!-- Generate a consecutive numbering N -->
<xsl:template name="sequenceGenerator">
	<xsl:variable name="uri"><xsl:value-of select="//mrp/@base-uri"/><xsl:value-of select="@value"/></xsl:variable>
	<span style="display: inline-block; width:140px; white-space:nowrap"><xsl:value-of select="@name"/></span> 
	<select style="width:70px; font-size:12px; text-align:right">
		<!-- standard Onchange -->
		<xsl:attribute name="onchange">javascript: window.location.href = this.options[this.selectedIndex].value;</xsl:attribute>
		<!-- PDF Onchange -->
		<xsl:if test="../@action">
			<xsl:attribute name="onchange">javascript: show(this.options[this.selectedIndex].value)</xsl:attribute>
		</xsl:if>
		<xsl:call-template name="generateOption">
			<xsl:with-param name="uri" select="$uri"/>
			<xsl:with-param name="start" select="@start"/>
			<xsl:with-param name="end" select="@end"/>
			<xsl:with-param name="init" select="0"/>
		</xsl:call-template>
	</select>
</xsl:template>
<!-- recursive part -->
<xsl:template name="generateOption">
	<xsl:param name="uri"/>
	<xsl:param name="start"/>
	<xsl:param name="end"/>
	<xsl:param name="init"/>
	<!-- Preset first Selection with Default-Value -->
	<xsl:if test="$init = '0' ">
		<option>
			<xsl:attribute name="value">
				<xsl:value-of select="//mrp/@base-uri"/><xsl:value-of select="//mrp/startseite/@href"/>
			</xsl:attribute>
			...&#160; <!-- eingefügt von gg, 02.06.2017, original: ?&#160; -->
		</option>
	</xsl:if>
	<!-- Construct Selection -->
	<option>
		<xsl:choose>
			<!-- File numbering: a2-b1-zN.pdf -->
			<xsl:when test="@paging='none' ">
				<xsl:attribute name="value"><xsl:value-of select="$uri"/><xsl:value-of select="$start"/>.pdf</xsl:attribute>
				<xsl:value-of select="$start"/>&#160;
			</xsl:when>
			<!-- Page numbering: a2-protokolle.pdf#page=N -->
			<xsl:otherwise>
				<xsl:attribute name="value"><xsl:value-of select="$uri"/>#page=<xsl:value-of select="$start"/></xsl:attribute>
				<xsl:choose>
					<!-- display roman pagination in selector -->
					<xsl:when test="@paging='roman' ">
						<xsl:value-of select="substring-before(substring-after($roman, $start), '-')"/>&#160;
					</xsl:when>
					<!-- otherwise display default decimal pagination -->
					<xsl:otherwise><xsl:value-of select="$start"/>&#160;</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</option>
	<!-- repeat until end -->
	<xsl:if test="$start &lt; $end">
		<xsl:call-template name="generateOption">
			<xsl:with-param name="uri" select="$uri"/>
			<xsl:with-param name="start" select="$start + 1"/>
			<xsl:with-param name="end" select="$end"/>
			<xsl:with-param name="init" select="1"/>
		</xsl:call-template>
	</xsl:if>
</xsl:template>


<!-- Make Recommendation -->
<xsl:template name="makeRecommendation">
	<hr/>
	<b>Empfohlene Links </b><br />
	. : &#160; <a class="menu" href="http://www.oeaw.ac.at/" target="_new" title=" Österreichische Akademie der Wissenschaften ">ÖAW </a> <br />
	. : &#160; <a class="menu" href="http://verlag.oeaw.ac.at/" target="_new" title=" Verlag der ÖAW ">Verlag </a> <br />
	. : &#160; <a class="menu" href="http://verlag.oeaw.ac.at/kategorie_225.ahtml" target="_new" title=" Druckausgabe ">Print Edition </a> <br />
	. : &#160; <a class="menu" href="http://verlag.oeaw.ac.at/xt_new_products" target="_new" title=" Neue Publikationen des Verlags ">Neue Publikationen </a> <br />
	. : &#160; <a class="menu" href="http://verlag.oeaw.ac.at/?page=categorie&amp;cat=230" target="_new" title="E-Publikationen des Verlags ">E-Publikationen </a><br/>
	. : &#160; <a class="menu" href="/ministerrat/benutzung.htm" target="_new" title="Benutzung">Benutzung </a> <br/> 
	<br /><br />
	<a href="http://www.oeaw.ac.at/inz/" target="_new" title="Institut für Neuzeit - und Zeitgeschichteforschung">
		<img alt="Logo" border="0">
			<!-- xsl:attribute name="src"><xsl:value-of select="mrp/@base-uri"/>_img/INZ_Logo2.jpg</xsl:attribute -->
			<xsl:attribute name="src">_styles/INZ_Logo1.jpg</xsl:attribute>
		</img>
	</a>
</xsl:template>


<!-- Make CONTENT -->
<xsl:template name="makeContent">
	<!-- iframe id="pdfReader" style="width:750px; height:720px;" frameborder="0" scrolling="no" -->
	<iframe id="pdfReader" width="99.5%" height="750" frameborder="0" scrolling="no">
		<xsl:attribute name="src">
			<xsl:value-of select="mrp/@base-uri"/><xsl:value-of select="mrp/startseite/@href"/>
		</xsl:attribute>
		<p>Ihr Browser unterstützt diese Anwendung nicht!</p>
	</iframe>
	
	<!-- Make Trailer below -->
	<hr class="ruler" />
	<!-- Zitierregel -->
	<div class="comment">
		<span style="background-color:white">&#160;Zitierregel:&#160;</span> 
		www.austriaca.at/ministerrat/serie-1/<span id="dok-url"><xsl:value-of select="mrp/@base-uri"/></span>
	</div>
	<p>
		<img alt="OEAW-Logo" border="0" align="left">
			<xsl:attribute name="src">_styles/oeaw-logo.gif</xsl:attribute>
		</img>
		<br/>Verlag der Österreichischen Akademie der Wissenschaften <br />Austrian Academy of Sciences Press 
	</p>
</xsl:template>


<!-- Formatierungen -->
<xsl:template match="b"> <b><xsl:apply-templates /></b> </xsl:template>
<xsl:template match="i"> <i><xsl:apply-templates /></i> </xsl:template>
<xsl:template match="u"> <u><xsl:apply-templates /></u> </xsl:template>
<xsl:template match="em"> <em><xsl:apply-templates /></em> </xsl:template>
<xsl:template match="sup"> <sup><xsl:apply-templates /></sup> </xsl:template>
<xsl:template match="sub"> <sub><xsl:apply-templates /></sub> </xsl:template>
<xsl:template match="br"> <br /> </xsl:template>
<xsl:template match="hr"> <hr/> </xsl:template>
<xsl:template match="space"> &#160;&#160; </xsl:template>
<xsl:template match="a">
	<a target="_blank">
		<xsl:attribute name="href"><xsl:value-of select="@href"/></xsl:attribute>
		<xsl:apply-templates/>
	</a>
</xsl:template>


<!-- Image Templates -->
<xsl:template match="img">
	<img alt="" border="0" vspace="9">
		<xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
	</img>
</xsl:template>

<!-- Paragraph Templates -->
<xsl:template match="p">
	<p style="margin-top:3px; margin-bottom:3px; text-indent:24px; ">
		<xsl:apply-templates />
	</p>
</xsl:template>
<xsl:template match="p[1]">
	<p style="margin-top:3px; margin-bottom:3px; ">
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


<!--   HTML Preparation   -->

<!--  HTML Metadata  -->
<xsl:template name="makeMetadata">
	<title>MRP <xsl:value-of select="//Name"/></title>
	<!-- meta content="text/html; charset=utf-8" http-equiv="Content-Type"></meta -->
	<meta name="description" content="Die Protokolle des österreichischen Ministerrates"></meta>
	<!-- Dublin-Core Metatags -->
    <meta name="DC.Type" content="text"/> 
	<meta name="DC.Title" content="Die Protokolle des österreichischen Ministerrates 1848-1867"/>
	<meta name="DC.Description" content="Ministerratsprotokolle 1848-1867"/>
	<meta name="DC.Format" content="text/html"/> 
	<meta name="DC.Identifier" content="http://www.oeaw.ac.at/mr"/> 
	<meta name="DC.Language" content="de"/> 
	<meta name="DC.Creator" content="Verlag der Österreichischen Akademie der Wissenschaften"/> 
	<meta name="DC.Publisher" content="Verlag der Österreichischen Akademie der Wissenschaften"/> 
	<meta name="DC.Rights" content="Österreichische Akademie der Wissenschaften"/>
	<meta name="DC.Relation" content="Elektronische Publikation"/> 
</xsl:template>

<!--  CSS  -->
<xsl:template name="makeCSS">
	<style type="text/css">
body { font-family:Arial Unicode MS, Arial; font-size:13px; color:<xsl:value-of select="$Text"/> }
td 	{ font-family:Arial Unicode MS, Arial; font-size:13px; color:<xsl:value-of select="$Text"/> }
sup, sub {  font-size:11px; }
h1 { font-size:24px; text-align:center; margin-bottom:3px; color:<xsl:value-of select="$title"/>; }
h2 { font-size:18px; text-align:center; margin-top:0px; color:<xsl:value-of select="$title"/>; }
.ruler { line-height:9px; color:<xsl:value-of select="$iText"/> }
.menu  { font-size:12px; color:<xsl:value-of select="$menu"/>; }
.content { font-size:15px; }
.comment { font-size:13px; text-align:left; }
.info  { font-size:11px; }
.list  { display:inline-block; width:30px; text-align:right; }
.headline { padding:3px; color:<xsl:value-of select="$iText"/> background:<xsl:value-of select="$media"/> margin-top:8px; }
.button { border: solid 1px #c8c8c8; color:<xsl:value-of select="$navi"/> text-align:center; font-weight:bold; }
a { text-decoration: none }
a:link { color:<xsl:value-of select="$menu"/> }
a:visited { color:<xsl:value-of select="$menu"/> }
a:hover { color:darkRed; text-decoration:none; }
a.menu:link { color:<xsl:value-of select="$menu"/> }
a.menu:visited { color:<xsl:value-of select="$menu"/> }
a.menu:hover { color:darkRed; text-decoration:none; } 
a.action:link { color:<xsl:value-of select="$navi"/> }
a.action:visited { color:<xsl:value-of select="$navi"/> }
a.action:hover { color:darkRed; text-decoration:none; } 
.action{padding-left: 10px;    padding-right: 10px;    border: 1px solid #c8c8c8;    padding-top: 2px;    padding-bottom: 2px;}
.noprint { display:block; }
@media print { .noprint { display:none } }	
	</style>
</xsl:template>

</xsl:stylesheet>
