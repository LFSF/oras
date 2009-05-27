					<%@ Language=VBScript %>

<?xml version="1.0" encoding="iso-8859-1"?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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

<SCRIPT language="JavaScript"> 
function fonctest()
{
window.location.href="espaceadh.asp";
}
function fonc100()
{
window.location.href='testd.asp';
}
function fonc1()
{
window.location.href='ndambog.asp';
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
<td colspan="2"><font color="#6FAA06">Vérification avant validation____________________________________________________________________</font></td>
</tr>
</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">
<tr>
	<td width="439" valign="top" class="txt">
	<div align="justify">
                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>

				  <%
				  
				  if request.form("duree_offre")="15" then
				  session("duree_offre")="15 jours"
				  end if
				  
				    if request.form("duree_offre")="30" then
				  session("duree_offre")="1 mois"
				  end if
				  
				    if request.form("duree_offre")="60" then
				  session("duree_offre")="2 mois"
				  end if
				  
				    if request.form("duree_offre")="90" then
				  session("duree_offre")="3 mois"
				  end if
				  
				    if request.form("duree_offre")="120" then
				  session("duree_offre")="4 mois"
				  end if
				  
				    if request.form("duree_offre")="180" then
				  session("duree_offre")="6 mois"
				  end if
				  
				   if request.form("duree_contrat")="15" then
				  session("duree_contrat")="15 jours"
				  end if
				  
				     if request.form("duree_contrat")="30" then
				  session("duree_contrat")="1 mois"
				  end if
				  
				     if request.form("duree_contrat")="60" then
				  session("duree_contrat")="2 mois"
				  end if
				  
				     if request.form("duree_contrat")="90" then
				  session("duree_contrat")="3 mois"
				  end if
				  
				     if request.form("duree_contrat")="120" then
				  session("duree_contrat")="4 mois"
				  end if
				  
				     if request.form("duree_contrat")="150" then
				  session("duree_contrat")="5 mois"
				  end if
				  
				     if request.form("duree_contrat")="180" then
				  session("duree_contrat")="6 mois"
				  end if
				  
				     if request.form("duree_contrat")="360" then
				  session("duree_contrat")="1 an minimum"
				  end if
				  
				   if request.form("duree_contrat")="1000" then
				  session("duree_contrat")="C.D.I"
				  end if
				  
				  %>

                  <tr> 
                    <td>Validité de l'offre :</td>
                    <td><%=session("duree_offre") %></td>
                        </tr>
                  </tr>
                  <tr> 
                    <td class="txt1">statut :</td>
                    <td><%=request.form("statut")%><%session("statut")=request.form("statut")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Raison social :</td>
                    <td><%=request.form("rs")%><%session("rs")=request.form("rs")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Adresse :</td>
                    <td><%=request.form("adresse")%><%session("adresse")=request.form("adresse")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Code Postal :</td>
					<td><%=request.form("cp")%><%session("cp")=request.form("cp")%></td>
				  <tr> 
                    <td class="txt1">Ville :</td>
                    <td><%=request.form("ville")%><%session("ville")=request.form("ville")%></td>
                  </tr>
				   <tr> 
                    <td class="txt1">Civilite :</td>
                    <td><%=request.form("civilite")%><%session("civilite")=request.form("civilite")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Nom du responsable :</td>
                    <td><%=request.form("responsable")%><%session("nom_responsable")=request.form("responsable")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Prenom du responsable :</td>
                    <td><%=request.form("prenom_responsable")%><%session("prenom_responsable")=request.form("prenom_responsable")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Email :</td>
                    <td><%=request.form("email")%><%session("email")=request.form("email")%></td>
                  </tr>
                  <tr> 
                    <td>Niveau de formation :</td>
                    <td><%=request.form("niveau_formation")%><%session("niveau_formation")=request.form("niveau_formation")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Téléphone :</td>
                    <td><%=request.form("tel")%><%session("tel")=request.form("tel")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Profil Recherché :</td>
                    <td><%=request.form("profil")%><%session("profil")=request.form("profil")%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1">Intitulé du poste :</td>
                    <td><%=request.form("intitule")%><%session("intitule")=request.form("intitule")%></td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
                   <tr> 
                    <td>Lieu du poste :</td>
                    <td><%=request.form("lieu")%><%session("lieu")=request.form("lieu")%></td>
                  </tr>
				   <tr> 
                    <td>Précision du lieu :</td>
                    <td><%=request.form("precision_lieu")%><%session("precision_lieu")=request.form("precision_lieu")%></td>
                  </tr>
                  <tr> 
                    <td>Description du poste :</td>
					</tr>
					<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
					<tr>
                    <td colspan="2"><i><%=request.form("description")%><%session("description")=request.form("description")%></i></td>
                  </tr>  

				  <tr><td>&nbsp;</td><td>&nbsp;</td>
				  </tr>
				  <tr> 
                    <td valign="top">Documents à fournir :</td>
                    <td><%=request.form("doc_a_fournir")%><%session("doc_a_fournir")=request.form("doc_a_fournir")%></td>
                  </tr>
				  <tr>
				  	<td>&nbsp;</td><td>&nbsp;</td>
				  </tr>
                  <tr> 
                    <td valign="top">Durée du contrat :</td>
                    <td><%=session("duree_contrat")%></td>
                  </tr>
                  <tr> 
                    <td valign="top">Indemnité :</td>
                    <td><%=request.form("indemnite")%><%session("indemnite")=request.form("indemnite")%></td>
                  </tr>
				  <tr> 
                    <td valign="top">Montant indemnité :</td>
                    <td><%=request.form("montant_indemnite")%><%session("montant_indemnite")=request.form("montant_indemnite")%>&nbsp; euros / mois</td>
                  </tr>
				
				 <tr> 
                    <td valign="top">Autres indemnités :</td>
                    <td><%=request.form("autres_indemnites")%><%session("autres_indemnites")=request.form("autres_indemnites")%></td>
                  </tr>
				  
				  <tr> 
                    <td valign="top">&nbsp;</td>
                    <td></td>
                  </tr>
				  
				  <tr>
                    <td align="center"><INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()"></td>
					<td align="center"><input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_proposer.asp'" value="Valider"></td>
				  </tr>
			</table>
			</div>
		</td>
   </tr>
				  
</table>
	* (mention obligatoire)

 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>
</body>
</html>