
<?xml version="1.0" encoding="iso-8859-1"?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />

 <script language="JavaScript">

function fonc2()
{
if((event.keyCode<48)||(event.keyCode>57))

	{
	// alert(window.event.keyCode);
	alert("Attention uniquement des chiffres !");
	event.returnValue=false;
	}
}

</script>
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

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if 
(win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} 
else 
{ document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

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
<td colspan="2"><font color="#6FAA06">Vérification avant validation____________________________________________________________________</font></td>
</tr>
</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />
                <table width="400" border="2" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                  <!--
                  <tr> 
                    <td>Vous recherchez un </td>
                    <td> <table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="profil" type="radio" value="emploi" checked></td>
                          <td>Emploi&nbsp; </td>
                          <td><input type="radio" name="profil" value="stage"></td>
                          <td>Stage&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr> 
                    <td>Intitulé du poste *&nbsp;&nbsp;</td>
                    <td><input style="width:100%" name="intitule" type="text"></td>
                  </tr>
                  -->
                  <tr> 
                    <td>Durée de l'offre :</td>
                    <td>voir<% =request.form("duree_offre")%><%session("duree_offre")=request.form("duree_offre")%></td>
                        </tr>
                  </tr>
                  <tr> 
                    <td class="txt1">statut :</td>
                    <td><% =request.form("statut")%><%session("statut")=request.form("statut")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Raison social :</td>
                    <td><% =request.form("rs")%><%session("rs")=request.form("rs")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Adresse :</td>
                    <td><% =request.form("adresse")%><%session("adresse")=request.form("adresse")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Code Postal :</td>
					<td><% =request.form("cp")%><%session("cp")=request.form("cp")%></td>
				  <tr> 
                    <td class="txt1">Ville :</td>
                    <td><% =request.form("ville")%><%session("ville")=request.form("ville")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Nom du responsable :</td>
                    <td><% =request.form("responsable")%><%session("responsable")=request.form("responsable")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Email :</td>
                    <td><% =request.form("email")%><%session("email")=request.form("email")%></td>
                  </tr>
                  <tr> 
                    <td>Niveau de formation :</td>
                    <td><% =request.form("niveau_formation")%><%session("niveau_formation")=request.form("niveau_formation")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Téléphone :</td>
                    <td><% =request.form("tel")%><%session("tel")=request.form("tel")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Profil Recherché :</td>
                    <td><% =request.form("profil")%><%session("profil")=request.form("profil")%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1">Intitulé du poste :</td>
                    <td><% =request.form("intitule")%><%session("intitule")=request.form("intitule")%></td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
                   <tr> 
                    <td>Lieu du poste :</td>
                    <td><% =request.form("lieu")%><%session("lieu")=request.form("lieu")%></td>
                  </tr>
                  <tr> 
                    <td>Description du poste :</td>
					</tr>
					<tr>
                    <td colspan="2"><% =request.form("description")%><%session("description")=request.form("description")%></td>
                  </tr>      
                  <tr> 
                    <td valign="top">Durée du contrat : <br>
					</td>
                    <td><% =request.form("duree_contrat")%><%session("duree_contrat")=request.form("duree_contrat")%></td>
                  </tr>
                  <tr> 
                    <td valign="top">Indemnité : <br>
                  </td>
                    <td><% =request.form("indemnite")%><%session("indemnite")=request.form("indemnite")%></td>
                  </tr>
				  <tr> 
                    <td valign="top">Montant indemnité : <br>
                  </td>
                    <td><% =request.form("montant_indemnite")%><%session("montant_indemnite")=request.form("montant_indemnite")%></td>
                  </tr>
				
				  <tr>
                    <td colspan="2">
					<table width=100%>
					<tr>
					<td align="center">
					  <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier"
               onClick="history.back()">
					  <input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_petite_annonce.asp'" value="Valider">
					  </td>
					  </td></tr></table>
					</td>
                  </tr>
				  
                </table></center>
	</td></tr><tr><td colspan="2">* (mention obligatoire)</td></tr></table>
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
</body>
</html>