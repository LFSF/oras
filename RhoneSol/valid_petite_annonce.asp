
<?xml version="1.0" encoding="iso-8859-1"?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>RhÃ´ne-solidaritÃ©</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}
<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>





<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">DEPOSER UNE PETITE ANNONCE!</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Formulaire Annonce____________________________________________________________________</font></td>
</tr>

<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A href="p_annonces.asp"><font size=1><b>
                         << Retour à la rubrique "Annonces" &nbsp;</b></font>
                          </a></td></tr>

</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />
<table width="400" border="0" valign="center" align="center">
<tr>
<td>Votre CV a bien été enregistré.
<br>Merci pour la confiance que vous nous accordez.
<br>Vous recevrez un mail à l'adresse suivante : 
<br><font color="blue"><% =session("email")%></font>
</td>
</tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>				  
				
</table>
</td>
</tr>
</table>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<!-- <table width="670" border="0" align="center" valign="center" class="txt">
	<tr>
		<td width="670" valign="bottom">_______________________________________________________________________________________________________________</td>
	</tr>
	<tr>
		<td valign="center">
		<MARQUEE behavior="scroll" valign="center" align="center" scrollamount="5" scrolldelay="10" onmouseover='this.stop()' onmouseout='this.start()'>
			<a href="#"
onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'img/1_120-200.jpg\' width=\'500\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="img/1_120-200.jpg" width="167" height="100" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"
onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'img/2_120-200.jpg\' width=\'500\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="img/2_120-200.jpg" width="167" height="100" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"
onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'img/3_120-200.jpg\' width=\'500\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="img/3_120-200.jpg" width="167" height="100" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</MARQUEE>
		</td>
	</tr>
</table> -->

 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>

  <div id="bulle"></div> 
  <%session("email")=""%>
 </body>
</html>