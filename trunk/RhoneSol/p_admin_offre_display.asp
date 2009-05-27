
					<%@ Language=VBScript %>


<?xml version="1.0" encoding="iso-8859-1"?>
<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_off")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<!-- #include file="connexion.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>
 <body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

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
                  
		<%session ("num")=Request.QueryString("num")%>			  
				  <%
				  
		  Set rsDI = Conn.Execute("SELECT * FROM OFFRES where NumOff = "& Request.QueryString("num") &"")		  	  
				   if rsDI("DureeOff")="def" then
				  session("duree_contrat")="CDI"
				  else
				  session("duree_contrat")= rsDI("DureeOff")
				  end if
				  
				  %>
				  
				  
				  
				  
                  <tr> 
                    <td>Validité de l'offre :</td>
                    <td><%=rsDI("DureeOff") %></td>
                        </tr>
                  </tr>
                  <tr> 
                    <td class="txt1">statut :</td>
                    <td><% =rsDI("ProfilOff")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Raison social :</td>
                    <td><% =rsDI("RaisonSocEntOff")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Adresse :</td>
                    <td><%=rsDI("AdrEntOff")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Code Postal :</td>
					<td><%=rsDI("CPEntOff")%></td>
				  <tr> 
                    <td class="txt1">Ville :</td>
                    <td><%=rsDI("VilleEntOff")%></td>
                  </tr>
				   <tr> 
                    <td class="txt1">Civilite :</td>
                    <td><%=rsDI("CivilliteRespOff")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Email :</td>
                    <td><%=rsDI("MailRespOff")%></td>
                  </tr>
				  <tr> 
                    <td class="txt1">Téléphone :</td>
                    <td><%=rsDI("TelRespOff")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Profil Recherché :</td>
                    <td><%=rsDI("ProfilOff")%></td>
                  </tr>
                  
                   <tr> 
                    <td class="txt1">Intitulé du poste :</td>
                    <td><% =rsDI("IntituleOff")%></td>
                  </tr>
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
                   <tr> 
                    <td>Lieu du poste :</td>
                    <td><% =rsDI("LieuOff")%></td>
                  </tr>
				   <tr> 
                    <td>Précision du lieu :</td>
                    <td><% =rsDI("VilleOff")%></td>
                  </tr>
                  <tr> 
                    <td>Description du poste :</td>
					</tr>
					<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
					<tr>
                    <td colspan="2"><i><% =rsDI("DescOff")%></i></td>
                  </tr>  

					<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
						 <tr> 
                    <td valign="top">Documents à fournir : <br>
                  </td>
                    <td><% =rsDI("DocOff")%></td>
                  </tr>
				  <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                  <tr> 
                    <td valign="top">Durée du contrat : <br>
					</td>
                    <td><% =rsDI("DureeOff")%></td>
                  </tr>
                  <tr> 
                    <td valign="top">Indemnité : <br>
                  </td>
                    <td><% =rsDI("IndemniteOff")%></td>
                  </tr>
				  <tr> 
                    <td valign="top">Montant indemnité : <br>
                  </td>
                    <td><% =rsDI("MontantOff")%>&nbsp; euros / mois</td>
                  </tr>
				
				 <tr> 
                    <td valign="top">Autres indemnités : <br>
                  </td>
                    <td><% =rsDI("AutIndOff")%></td>
                  </tr>
			  
				  <tr> 
                    <td valign="top">&nbsp; <br>
                  </td>
                    <td></td>
                  </tr>
				  
				  
				  
                </table></center>
	</td></tr><tr><td colspan="2"> <br>
 <br><div align="right">
 <INPUT TYPE="BUTTON" style="width:75" VALUE="Valider" OnClick="window.location.href='p_admin_offre_validbis.asp?num=<%=rsDI("NumOff")%>'" >
 <INPUT TYPE="BUTTON" style="width:75" VALUE="Retour" onClick="history.back()" >
 <INPUT TYPE="BUTTON"  style="width:75" VALUE="Supprimer" OnClick="window.location.href='p_admin_offre_deletebis.asp?num=<%=rsDI("NumOff")%>'" ></div></td></tr></table>
<%
			rsDI.Close 
			Set rsDI = Nothing
			%>	
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
<!-- #include file="deconnexion.asp"-->
<% end if %>
</html>