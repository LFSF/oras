
					<%@ Language=VBScript %>


<?xml version="1.0" encoding="iso-8859-1"?>
<!-- #include file="admin_securite.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
<link href="styles.css" rel="stylesheet" type="text/css" />


<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>

<body>

<SCRIPT LANGUAGE="Javascript1.1">
function fonc_print() { 
window.print(); 
} 

</SCRIPT>

<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<%
Dim rsDI


%>

<%session ("NumCrea")=Request.QueryString("NumCrea")%>	

<%
Set rsDI = Conn.Execute("SELECT * FROM CREATION where NumCrea = "& Request.QueryString("NumCrea") &"")
%>


<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Visualisation demande____________________________________________________________________</font></td>
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
                    <td><% =rsDI("CivCrea")%></td>
                        </tr>
                  </tr>
				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><% =rsDI("NomCrea")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Prenom :</font></td>
                    <td><% =rsDI("PrenomCrea")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Fonction :</font></td>
                    <td><% =rsDI("FonctionCrea")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Société :</font></td>
					<td><% =rsDI("SocieteCrea")%></td>
				  <tr> 
                    <td class="txt1"><font color="#969696">Adresse :</font></td>
                    <td><% =rsDI("AdrCrea")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Code postal :</font></td>
                    <td><% =rsDI("CpCrea")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Ville :</font></td>
                    <td><% =rsDI("VilleCrea")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1"><font color="#969696">Mail :</font></td>
                    <td><% =rsDI("MailCrea")%></td>
                  </tr>
                  
				  <tr> 
                    <td><font color="#969696">Tel.Fixe :</font></td>
                    <td><% =rsDI("FixeCrea")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1"><font color="#969696">Tel.Port :</font></td>
                    <td><% =rsDI("PortableCrea")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Projet :</font></td>
                    <td><% =rsDI("ProjetCrea")%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1"><font color="#969696">Demande :</font></td>
                    <td><% =rsDI("DemandeCrea")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Budget :</font></td>
                    <td><% =rsDI("BudgetCrea")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Délai :</font></td>
                    <td><% =rsDI("DelaiCrea")%></td>
                  </tr>

				  <tr> 
                    <td class="txt1"><font color="#969696">Commentaire :</font></td>
                    <td><% =rsDI("CommentCrea")%></td>
                  </tr>

				  <tr> 
                    <td class="txt1"><font color="#969696">Réponse :</font></td>
                    <td><% =rsDI("ReponseCrea")%></td>
                  </tr>						  
				    
					
				  
				 
<%
			rsDI.Close 
			Set rsDI = Nothing
			%>
    <br>
 <br> 	
					</td>
                  </tr>
				  
                </table></center>
	</td></tr><tr><td colspan="2" align=""><a href="javascript:;" onclick="return fonc_print()" ><img src="./img racine/imp_no_border.jpg" alt="Imprimer" title="Imprimer" border="0" height="25"  width="23"/> Imprimer</a>
 
 </td> <td colspan="2"> <br>
	
 
 <br><div align="right">
 <A HREF="p_admin_demande_site_validbis.asp" onmouseOver="lightUp();" onmouseOut="dimDown();"> 
<IMG SRC="img/valider_noclick.gif" name="homeButton" width=100 height=50 border=0> </A>
  <!--<INPUT TYPE="BUTTON" style="width:75" VALUE="Valider" OnClick="window.location.href='p_admin_demande_site_validbis.asp'" >-->
 <INPUT TYPE="BUTTON" style="width:75" VALUE="Retour" onClick="history.back()" >
 <!--<INPUT TYPE="BUTTON"  style="width:75" VALUE="Supprimer" OnClick="window.location.href='p_admin_cv_deletebis.asp'" >--></div></td></tr></table>

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>
</body>
<!-- #include file="deconnexion.asp"-->
</html>