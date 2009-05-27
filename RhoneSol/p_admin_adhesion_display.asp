<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>


<!-- #include file="connexion.asp"-->

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Vérification avant validation des demandes_______________________________________________</font></td>
    </tr>
   


</table>
<%session("num")=Request.QueryString("num")

Set rsDI = Conn.Execute("SELECT * FROM MEMBRE where NumMembre = "& session ("num") &"")


if(rsDI("AdhesionMembre")="non") then
var_adh="non"
end if
if(rsDI("AdhesionMembre")="oui") then
var_adh="oui"
end if
%>

<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">

<tr >
<td colspan="2" class="style"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;




</td>
</tr>
<tr>
<td><br>
<form action="valider_p_admin_adhesion_display.asp" method="post" id="droitsmembre" name="droitsmembre">
                <table width="600" border="0" cellpadding="0" cellspacing="4" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td> <td>&nbsp;</td><td>&nbsp;</td>
                  </tr>
                  
                 
                  <tr> 
                    <td><font color="#969696">Civilité :</font></td>
                    <td><%=rsDI("CivMembre")%></td>
					<td>&nbsp;</td>
                        </tr>
                  </tr>
				  
				  				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><%=rsDI("NomMembre")%><%session("NomMembre1")=rsDI("NomMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
                  
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Prenom :</font></td>
                    <td><%=rsDI("PrenomMembre")%><%session("PrenomMembre1")=rsDI("PrenomMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
                  
				   <tr> 
                    <td class="txt1"><font color="#969696">Fonction :</font></td>
                    <td><%=rsDI("FonctionMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Organisme :</font></td>
                    <td><%=rsDI("OrganismeMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Adresse :</font></td>
                    <td><%=rsDI("AdrMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Code Postal :</font></td>
					<td><%=rsDI("CPMembre")%></td>
					<td>&nbsp;</td>
				  <tr> 
                    <td class="txt1"><font color="#969696">Ville :</font></td>
                    <td><%=rsDI("VilleMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Pays :</font></td>
                    <td><%=rsDI("PaysMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
				  
				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Email :</font></td>
                    <td><%=rsDI("MailMembre")%><%session("MailMembre1")=rsDI("MailMembre")%></td>
					<td>&nbsp;</td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Téléphone :</font></td>
                    <td><%=rsDI("TelMembre")%></td>
					<td>&nbsp;</td>
                  </tr>

				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite devenir partenaire :</font></td>
                    <td><%=rsDI("PartenaireMembre")%><%session("PartenaireMembre1")=rsDI("PartenaireMembre")%></td>
                  </tr>
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine de la Coopération Décentralisée :</font></td>
                    <td><%=rsDI("CooperationMembre")%><%session("CooperationMembre1")=rsDI("CooperationMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine du commerce solidaire :</font></td>
                    <td><% =rsDI("SolidaireMembre")%><%session("SolidaireMembre1") =rsDI("SolidaireMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine de la formation :</font></td>
                    <td><% =rsDI("FormationMembre")%><%session("FormationMembre1")=rsDI("FormationMembre")%></td>
                  </tr>
				  
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Autre domaine :</font></td>
                    <td><% =rsDI("AutreMembre")%><%session("AutreMembre1")=rsDI("AutreMembre")%></td>
                  </tr>
				  
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite écrire des articles dans la rubriques actualités :</font></td>
                    <td><% =rsDI("RedacteurMembre")%><%session("RedacteurMembre1")=rsDI("RedacteurMembre")%></td>
					
					
				<% if(rsDI("RedacteurMembre")="oui")then%>
				<td> 
				<INPUT type="checkbox" id="cb_actu" name="cb_actu" checked="checked"/>
				</td>
				<% end if %>
					
				<% if(rsDI("RedacteurMembre")="non")then%>
				<td> 
				<INPUT type="checkbox" id="cb_actu" name="cb_actu" />
				</td>
				<% end if %>	
					
					
                  </tr>
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite faire connaître mes actions :</font></td>
                    <td><% =rsDI("InterviewMembre")%><%session("InterviewMembre1")=rsDI("InterviewMembre")%></td>
					
					
					
					<% if(rsDI("InterviewMembre")="oui")then%>
				<td> 
				<INPUT type="checkbox" id="cb_demandeitw" name="cb_demandeitw" checked="checked"/>
				</td>
				<% end if %>
					
				<% if(rsDI("InterviewMembre")="non")then%>
				<td> 
				<INPUT type="checkbox" id="cb_demandeitw" name="cb_demandeitw" />
				</td>
				<% end if %>	
                  </tr>
				  
				  
                  </tr>
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite créer un site Internet :</font></td>
                    <td><% =rsDI("CreationSiteMembre")%><%session("CreationSiteMembre1")=rsDI("CreationSiteMembre")%></td>
					
				<% if(rsDI("CreationSiteMembre")="oui")then%>
				<td> 
				<INPUT type="checkbox" id="cb_creationsite" name="cb_creationsite" checked="checked"/>
				</td>
				<% end if %>
					
				<% if(rsDI("CreationSiteMembre")="non")then%>
				<td> 
				<INPUT type="checkbox" id="cb_creationsite" name="cb_creationsite" />
				</td>
				<% end if %>	
                  </tr>
				  
				  
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite recevoir la Newsletter :</font></td>
                   		<td><%=rsDI("News")%><%session("News1")=rsDI("News")%></td>	


				<%if(rsDI("News")="oui")then%>
				<td> 
				<INPUT type="checkbox" id="cb_news" name="cb_news" checked="checked"/>
				</td>
				<% end if %>
					
				<% if(rsDI("News")="non")then%>
				<td> 
				<INPUT type="checkbox" id="cb_news" name="cb_news" />
				</td>
				<% end if %>	
					
                  </tr>
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Autre demande :</font></td>
                    <td><% =rsDI("AutresMembre")%><%session("AutresMembre1")=rsDI("AutresMembre")%></td>
					
				
				<% if(rsDI("AutresMembre")="oui")then%>
				<td> 
				<INPUT type="checkbox" id="cb_autredemande" name="cb_autredemande" checked="checked"/>
				</td>
				<% end if %>
					
				<% if(rsDI("AutresMembre")="non")then%>
				<td> 
				<INPUT type="checkbox" id="cb_autredemande" name="cb_autredemande" />
				</td>
				<% end if %>
                  </tr>
				  
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Ecriture d'interview :</font></td>
                    <td><%=rsDI("EcrireItwMembre")%></td>
				<% if(rsDI("EcrireItwMembre")="oui")then%>
				<td> 
				<INPUT type="checkbox" id="cb_ecriture" name="cb_ecriture" checked="checked"/>
				</td>
				<% end if %>

				<% if(rsDI("EcrireItwMembre")="non")then%>
				<td> 
				<INPUT type="checkbox" id="cb_ecriture" name="cb_ecriture" />
				</td>
				<% end if %>
                  </tr>
				  
					<tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				                
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Message : </font><br><br><br>&nbsp;
                  </td>
				  </tr>
				  
				  <tr>
                    <td colspan="2"><% =rsDI("MessageMembre")%><%session("MessageMembre1")=rsDI("MessageMembre")%></td>
                  </tr>
				  
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Réponse: </font><br><br><br>&nbsp;
                  </td>
				  </tr>
				  
				  <tr>
                    <td colspan="2"><%=rsDI("ReponseAdhMembre")%></td>
                  </tr>
	<%
	rsDI.Close 
	%>
				
<%
if(var_adh="non") then
%>
<tr>
<td colspan="2">
<%
response.write("<font color='red' size='4px'>ATTENTION ADHESION NON VALIDEE RISQUE DE SPAMMING !!!</font>")
%>
</td>
<td></td>
</tr>
<%
end if
%>

				<tr>
				  <td>
				  
				  
<br><div align="right">
	<input name="submit1" type="submit" value="Valider les demandes" id="submit1" width="109" height="16" border="0">
 </form>
 </div></td></tr>
 
 
  <tr>
				  <td>
				  
				  
<br><div align="right">
  </br>
 <INPUT TYPE="BUTTON" style="width:75" VALUE="Retour" onClick="history.back()" >
 <INPUT TYPE="BUTTON"  style="width:75" VALUE="Supprimer" OnClick="window.location.href='p_admin_adhesion_deletebis.asp'" >
 </div></td></tr>
 
 </table>



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>