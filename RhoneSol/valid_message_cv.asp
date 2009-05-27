<?xml version="1.0" encoding="iso-8859-1"?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rh&ocirc;ne-solidarit&eacute;</title>

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


<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>





<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">CONSULTATION CV</div>


<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Confirmation Message____________________________________________________________________</font></td>
    </tr>
	
<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A href="p_annonces.asp"><font size=1><b>
                         << Retour &agrave; la rubrique "Annonces" &nbsp;</b></font>
                          </a></td></tr>



<table width="400" border="0" valign="center" align="center">
<tr>
<td>Votre message a &eacute;t&eacute; envoy&eacute; au correspondant.
<br>Merci pour la confiance que vous nous accordez.
<br>Vous recevrez un mail de confirmation &agrave; l'adresse suivante : 
<br><font color="blue"><% =session("mailrepCV")%></font>
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

<!--           fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>


  <!--remise a zero des sessions du formulaire-->
  
<%
session("email")=""
session("civilite")=""
session("age")=""
session("nom")=""
session("prenom")=""
session("adresse")=""
request.form("adresse")
session("cp")=""
session("ville")=""
session("email")=""
session("tel")=""
session("niveau_formation")=""
session("diplome_en_cour")=""
session("diplome_obtenu")=""
session("autre_diplome")=""
session("profil")=""
session("intitule_poste")=""
session("experience_pro")=""
session("commentaire")=""
session("joindre_fichier")=""
session("lien_http")=""
%>

  <!--fin remise a zero-->
  
  
 </body>
</html>