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

</head>

<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">DEPOSER UN CV!</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Validation CV____________________________________________________________________</font></td>
</tr>

 <tr>
				<td width=82%>
	  
	  <div align="justify">
        
		<A href="p_annonces.asp"><font size=1><b>
                         << Retour à la rubrique "Annonces" &nbsp;</b></font>
                          </a></td></tr>

</table>

<table width="400" border="0" valign="center" align="center">
<tr> 
                    <td>&nbsp;</td>
                  </tr>
				  
				 
				  
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>
<tr>
<td>

Votre CV a bien été enregistré.
<br>Merci pour la confiance que vous nous accordez.
<br>Vous recevrez un mail de confirmation 

<br>


</td>
</tr>
				  <tr> 
                    <td><%response.write("<font color='blue'>" & session("email") & "</font>")
%></td>
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


  
  <%
Session.Contents.Remove("email")
Session.Contents.Remove("civilite")
Session.Contents.Remove("age")
Session.Contents.Remove("nom")
Session.Contents.Remove("prenom")
Session.Contents.Remove("adresse")
Session.Contents.Remove("cp")
Session.Contents.Remove("ville")
Session.Contents.Remove("email")
Session.Contents.Remove("tel")
Session.Contents.Remove("niveau_formation")
Session.Contents.Remove("diplome_en_cour")
Session.Contents.Remove("diplome_obtenu")
Session.Contents.Remove("autre_diplome")
Session.Contents.Remove("profil")
Session.Contents.Remove("intitule_poste")
Session.Contents.Remove("experience_pro")
Session.Contents.Remove("commentaire")
Session.Contents.Remove("joindre_fichier")
Session.Contents.Remove("lien_http")
Session.Contents.Remove("filename")
session.Abandon
%>

  <!------------------------------------------fin remise a zero----------------------------------------------------------->
  
  
 </body>
</html>