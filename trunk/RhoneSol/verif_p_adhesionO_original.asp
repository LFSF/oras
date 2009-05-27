<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>


<!-- #include file="grand_meta.txt"-->

<!-- #include file="connexion.asp"-->
<title>Rh�ne-solidarit�</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->



<% 
		' On extrait les variables dans la barre d'adresse
		zemail = Request.form("MailMembre")
		
		  Dim rsED1
		  
		
	compteur=0
		Set rsED1 = Conn.Execute("SELECT * FROM Membre  where MailMembre='"  & zemail  & "'")
		
		  While Not rsED1.EOF
		compteur = compteur + 1
				
			rsED1.MoveNext
				
			Wend
			rsED1.Close 
			
			Set rsED1 = Nothing
		
		%>

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Vérification Adhesion avant enregistrement</div>

<table border="0px" width="100%" cellpadding="10px">
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Vérification avant validation _____________________________________________________</font></td>
    </tr>


</table>



<%


 if (request.form("PartenaireMembre")="on")then
session("PartenaireMembre")="oui"
else
session("PartenaireMembre")="non"
end if

if (request.form("CooperationMembre")="on") then
session("CooperationMembre")="oui"
else
session("CooperationMembre")="non"
end if

if (request.form("SolidaireMembre")="on") then
session("SolidaireMembre")="oui"
else
session("SolidaireMembre")="non"
end if

if (request.form("FormationMembre")="on") then
session("FormationMembre")="oui"
else
session("FormationMembre")="non"
end if
				  
if (request.form("AutreMembre")="on") then
session("AutreMembre")="oui"
else
session("AutreMembre")="non"
end if	
				
if (request.form("RedacteurMembre")="on") then
session("RedacteurMembre")="oui"
else
session("RedacteurMembre")="non"
end if	
				
if (request.form("InterviewMembre")="on") then
session("InterviewMembre")="oui"
else
session("InterviewMembre")="non"
end if			

if (request.form("CreationsiteMembre")="on") then
session("CreationsiteMembre")="oui"
else
session("CreationsiteMembre")="non"
end if		

if (request.form("News")="on") then
session("News")="oui"
else
session("News")="non"
end if	

if (request.form("AutresMembre")="on") then
session("AutresMembre")="oui"
else
session("AutresMembre")="non"
end if	
				  
%>

<table style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">

	<tr >
		<td colspan="2" class="style"> <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>

	<tr>
		<td><br />
           
	<table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  				  				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><% =request.form("NomMembre")%><%session("NomMembre")=request.form("NomMembre")%></td>
                  </tr>
    			  
                  <tr> 
                    <td class="txt1"><font color="#969696">Téléphone :</font></td>
                    <td><% =request.form("TelMembre")%><%session("TelMembre")=request.form("TelMembre")%></td>
                  </tr>
                  
				  <tr> 
				  
				  <% if compteur>0 then%>
				  <font color="#FF0000">
                    <td><font color="#FF0000">ATTENTION Email DEJA EXISTANT :</font> </td>
                    <td><font color="#FF0000"><% =request.form("MailMembre")%></font><%session("MailMembre")=request.form("MailMembre")%></td>
				</font>
					
					<% end if %>    

					 <% if compteur=0 then%>		
				  
				  <td class="txt1"><font color="#969696">Email :</font></td>
                    <td><% =request.form("MailMembre")%><%session("MailMembre")=request.form("MailMembre")%></td>
				  
				  <% end if %>
				  </tr>

				  <tr> 
                    <td class="txt1"><font color="#969696">Adresse :</font></td>
                    <td><% =request.form("AdrMembre")%><%session("AdrMembre")=request.form("AdrMembre")%></td>
                  </tr>
				  
				  <tr>
					<td class="txt1"><font color="#969696">Mot de passe : </font></td>
					<td><% =request.form("MdpMembre")%><%session("MdpMembre")=request.form("MdpMembre")%></td>
				  </tr>
				
				  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite recevoir la Newsletter :</font></td>
                    <td><%=session("News")%></td>
				  </tr>				  

				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Ville :</font></td>
                    <td><% =request.form("VilleMembre")%><%session("VilleMembre")=request.form("VilleMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Code Postal / Boîte Postal:</font></td>
					<td><% =request.form("CPMembre")%><%session("CPMembre")=request.form("CPMembre")%></td>
				  </tr>
				    
				  <tr> 
                    <td class="txt1"><font color="#969696">Organisme :</font></td>
                    <td><% =request.form("OrganismeMembre")%><%session("OrganismeMembre")=request.form("OrganismeMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Pays :</font></td>
                    <td><% =request.form("PaysMembre")%><%session("PaysMembre")=request.form("PaysMembre")%></td>
                  </tr>

				  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite devenir partenaire :</font></td>
                    <td><%=session("PartenaireMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine de la Coopération Décentralisée :</font></td>
                    <td><%=session("CooperationMembre")%></td>
                  </tr>
				  
				  <!--solidaire, formation, autre -->
				  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine du commece solidaire :</font></td>
                    <td><% =session("SolidaireMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Dans le domaine de la formation :</font></td>
                    <td><% =session("FormationMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Autre domaine :</font></td>
                    <td><% =session("AutreMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite écrire des articles dans la rubriques actualités :</font></td>
                    <td><% =session("RedacteurMembre")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Je souhaite faire connaître mes actions :</font></td>
                    <td><% =session("InterviewMembre")%></td>
                  </tr>
				  

    
				  <tr>
                    <td class="txt1"><font color="#969696">Je souhaite créer un site Internet :</font></td>
                    <td><% =session("AutresMembre")%></td>
                  </tr>

                  				  
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
	
				  
				  
				  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Message : </font><br><br><br>&nbsp;
                  </td>
				  </tr>
				  
				  <tr>
                    <td colspan="2"><% =request.form("MessageMembre")%><%session("MessageMembre")=request.form("MessageMembre")%></td>
                  </tr>
				  
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
    
			  
				  <tr>
				  <td>
				  
				  <br>
					<br> 	
					  <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" >
					
				<% if compteur=0 then	%>
				<input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_p_adhesionO.asp'" value="Valider">	
			
			  
					 <!-- <input name="valider" style="width:75" type=submit value="Valider" > -->
				  <% end if %>
				  
				  
				  
				
				  </td></tr>
				  
                </table>
	</td></tr><tr><td colspan="2"></td></tr></table>
  <!-- #include file="grand_footer.txt"-->  
  
<!-- #include file="deconnexion.asp"-->
</div>

</body>
</html>