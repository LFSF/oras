					<%@ Language=VBScript %>


<?xml version="1.0" encoding="iso-8859-1"?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>



<link href="styles.css" rel="stylesheet" type="text/css" />

</head>

<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">DEPOSER UN CV!</div>


<% session("remps_fichier")=Date%>

<%
session("duree_esperee")= request.form("duree_esperee")

if request.form("duree_esperee")="1000" then
   session("d_esperee")="C.D.I"
end if

if request.form("duree_esperee")="15" then
   session("d_esperee")="15 jours"
end if
		
		if request.form("duree_esperee")="30" then
   session("d_esperee")="1 mois"
end if
		
		if request.form("duree_esperee")="60" then
   session("d_esperee")="2 mois"
end if
		
		if request.form("duree_esperee")="90" then
   session("d_esperee")="3 mois"
end if
		
		if request.form("duree_esperee")="120" then
   session("d_esperee")="4 mois"
end if
		
		if request.form("duree_esperee")="150" then
   session("d_esperee")="5 mois"
end if
		
		if request.form("duree_esperee")="180" then
   session("d_esperee")="6 mois"
end if
		
		if request.form("duree_esperee")="270" then
   session("d_esperee")="9 mois"
end if
		if request.form("duree_esperee")="360" then
   session("d_esperee")="1 an minimum"
end if
		
					 
					
					%>


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


                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                 
                  <tr> 
                    <td><font color="#969696">Civilité :</font></td>
                    <td><% =request.form("civilite")%> <%session("civilite")=request.form("civilite")%></td>
                        </tr>
                  </tr>
				  
				   <tr> 
                    <td><font color="#969696">Votre âge :</font></td>
                    <td><% =request.form("age")%> <%session("age")=request.form("age")%> &nbsp;ans</td>
                        </tr>
                  </tr>
				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><% =request.form("nom")%><%session("nom")=request.form("nom")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Prenom :</font></td>
                    <td><% =request.form("prenom")%><%session("prenom")=request.form("prenom")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Adresse :</font></td>
                    <td><% =request.form("adresse")%><%session("adresse")=request.form("adresse")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Code Postal :</font></td>
					<td><% =request.form("cp")%><%session("cp")=request.form("cp")%></td>
				  <tr> 
                    <td class="txt1"><font color="#969696">Ville :</font></td>
                    <td><% =request.form("ville")%><%session("ville")=request.form("ville")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Email :</font></td>
                    <td><% =request.form("email")%><%session("email")=request.form("email")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Téléphone :</font></td>
                    <td><% =request.form("tel")%><%session("tel")=request.form("tel")%></td>
                  </tr>
                  
				  
				  <tr> 
                    <td><font color="#969696">Niveau de formation :</font></td>
                    <td><% =request.form("niveau_formation")%><%session("niveau_formation")=request.form("niveau_formation")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1"><font color="#969696">Diplôme en cours :</font></td>
                    <td><% =request.form("diplome_en_cour")%><%session("diplome_en_cour")=request.form("diplome_en_cour")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Dernier diplôme  obtenu :</font></td>
                    <td><% =request.form("diplome_obtenu")%><%session("diplome_obtenu")=request.form("diplome_obtenu")%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1"><font color="#969696">Autre diplôme  :</font></td>
                    <td><% =request.form("autre_diplome")%><%session("autre_diplome")=request.form("autre_diplome")%></td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  
				 
				  
                  <tr> 
                    <td><font color="#969696">Intitulé du poste :</font></td>
                    <td><% =session("intitule_poste")%></td>
                  </tr> 

				 
				   
					
					
					
					
					
					
					</td>
                  </tr>  
				  
				  
				  
				   <tr> 
                    <td><font color="#969696">Vous êtes disponible à partir du :</font></td>
                    <td><% =request.form("disponibilite_jour")%> <% =request.form("disponibilite_mois")%>
					<% =request.form("disponibilite_annee")%>
					
					<%=request.form("dispo_jour")%> &nbsp;<%=request.form("dispo_mois")%>&nbsp;
                   <%=request.form("dispo_annee")%>


					
					
					<%session("disponibilite_jour")=request.form("dispo_jour")%>
					<%session("disponibilite_mois")=request.form("dispo_mois")%>
					<%session("disponibilite_annee")=request.form("dispo_annee")%>
					
					
					</td>
                  </tr>  
					<tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">&nbsp;</td>
				  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Expériences professionnelles : </font><br><br>&nbsp;
					</td>
					
				  
				  </tr>
				  <tr> 
                    <td colspan="2"><% =request.form("experience_pro")%><%session("experience_pro")=request.form("experience_pro")%></td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">&nbsp;</td>
				  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Commentaires : </font><br><br><br>&nbsp;
                  </td>
				  </tr>
				  
				  <tr>
                    <td colspan="2"><% =request.form("commentaire")%><%session("commentaire")=request.form("commentaire")%></td>
                  </tr>
				  
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  
<tr>
					<td colspan="2" width="670" valign="center">&nbsp;</td>
				  </tr>
				  
				  
				  <tr>
					<td colspan="2" width="670" valign="center">&nbsp;</td>
				  </tr>
				  <tr> 
                    <td colspan="2" style="margin-top:2px;"><font color="#969696">Liens HTTP (liens vers vos projets, E-CV, etc...) :</font><br><br>&nbsp;
                  </td>
				  <td >&nbsp;
                  </td>
				  </tr>
				  <tr>
				  
                    <td colspan="2"><% =request.form("lien_http")%><%session("lien_http")=request.form("lien_http")%></td>
					 <td></td>
                  </tr>
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
				  
                  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">&nbsp;</td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">&nbsp;</td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">
					<INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" >
					
					   <input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_deposer.asp'" value="Valider">
		
 <!--
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTester.asp">
	
	
	<form name="frmSend" method="POST" enctype="multipart/form-data" action="uploadTemploi_depot_cv.asp">
	
	<B>Joindre un fichier <font color=red>( < 2Mo)</font></B><br><br>
     <input name="attach1" type="file" size=35><br>

    <br>
 <br> 	
					  
					   <input name="valider" style="width:75" type=submit value="Valider">
					
 
	 <input style="margin-top:4" type=submit value="Upload">

	</form>-->
	

					
				  
				  
					</td>
                  </tr>
				  
                </table></center>
	</td></tr><tr><td colspan="2"></td></tr></table>



 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>
</body>
</html>