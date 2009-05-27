<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

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
<div id="bandeau_orange">DEPOSER UNE OFFRE!</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Validation Offre____________________________________________________________________</font></td>
</tr>

<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A href="p_annonces.asp"><font size=1><b>
                         << Retour à la rubrique "Annonces" &nbsp;</b></font>
                          </a></td></tr><br><br><br><br><br><br>


</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->

<table width="400" border="0" valign="center" align="center">
<tr>
<td>Votre offre a bien été enregistrée.
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
<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>
  
  <div id="bulle"></div> 
  <%session("email")=""%>
 <!------------------------------------------fin remise a zero----------------------------------------------------------->
  
  
 </body>
</html>