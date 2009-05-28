<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Vérification Idées Suggestion avant enregistrement</div>


<table border="0px" width="100%" cellpadding="10px">
	<tr>
		<td colspan="2"><font color="#6faa06">Vérification avant validation _____________________________________________________</font></td>
	</tr>
</table>

<%
message = trim(request.form("message"))

if message = "<br>" or message ="" then

	session("idee_civ") = request.form("civilite")
	session("idee_nom") = request.form("nom")
	session("idee_prenom") = request.form("prenom")
	session("idee_fonction") = request.form("fonction")
	session("idee_organisme") = request.form("organisme")
	session("idee_mail") = request.form("email")
	session("idee_telephone") = request.form("telephone")
	
	response.redirect("p_idees.asp")
	
end if

 if (request.form("checkbox")="on")then
 
session("a_checkbox")="oui"
else
session("a_checkbox")="non"
end if

 if (request.form("checkbox11")="on") then
 
session("a_checkbox11")="oui"
else
session("a_checkbox11")="non"
end if


 if (request.form("checkbox12")="on") then
 
session("a_checkbox12")="oui"
else
session("a_checkbox12")="non"
end if

 if (request.form("checkbox13")="on") then
 
session("a_checkbox13")="oui"
else
session("a_checkbox13")="non"
end if
				  
	
if (request.form("checkbox14")="on") then
session("a_checkbox14")="oui"
else
session("a_checkbox14")="non"
end if	
				

if (request.form("checkbox20")="on") then
session("a_checkbox20")="oui"
else
session("a_checkbox20")="non"
end if	
				
if (request.form("checkbox30")="on") then
session("a_checkbox30")="oui"
else
session("a_checkbox30")="non"
end if			

if (request.form("checkbox40")="on") then
session("a_checkbox40")="oui"
else
session("a_checkbox40")="non"
end if		

if (request.form("checkbox50")="on") then
session("a_checkbox50")="oui"
else
session("a_checkbox50")="non"
end if	

if (request.form("checkbox60")="on") then
session("a_checkbox60")="oui"
else
session("a_checkbox60")="non"
end if
%>

 <table style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">

<tr >
<td colspan="2" class="style"><br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
</tr>
<tr>
<td><br>
                <table width="400" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  
                 
                  <tr> 
                    <td><font color="#969696">Civilité :</font></td>
                    <td><% =request.form("civilite")%> <%session("a_civilite")=request.form("civilite")%></td>
                        </tr>
                  </tr>
				  
				  				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Nom :</font></td>
                    <td><% =request.form("nom")%><%session("a_nom")=request.form("nom")%></td>
                  </tr>
                  
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Prenom :</font></td>
                    <td><% =request.form("prenom")%><%session("a_prenom")=request.form("prenom")%></td>
                  </tr>
                  
				  
				  
				   <tr> 
                    <td class="txt1"><font color="#969696">Fonction :</font></td>
                    <td><% =request.form("fonction")%><%session("a_fonction")=request.form("fonction")%></td>
                  </tr>
				  
				  <tr> 
                    <td class="txt1"><font color="#969696">Organisme :</font></td>
                    <td><% =request.form("organisme")%><%session("a_organisme")=request.form("organisme")%></td>
                  </tr>
				  
				  
				  
				  
                  <tr> 
                    <td class="txt1"><font color="#969696">Email :</font></td>
                    <td><% =request.form("email")%><%session("a_email")=request.form("email")%></td>
                  </tr>
                  <tr> 
                    <td class="txt1"><font color="#969696">Téléphone :</font></td>
                    <td><% =request.form("telephone")%><%session("a_telephone")=request.form("telephone")%></td>
                  </tr>
                  				  
				    
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
                  <tr> 
                    <td valign="top" colspan="2"><font color="#969696">Message : </font><br><br><br>&nbsp;
                  </td>
				  </tr>
				  
				  <tr>
                    <td colspan="2"><% =request.form("message")%><%session("a_message")=request.form("message")%></td>
                  </tr>
				  
				  <tr>
					<td colspan="2" width="670" valign="center">__________________________________________________</td>
				  </tr>
				  

				  <tr>
				  <td>
				  
				  <br>
					<br> 	
					  <INPUT TYPE="BUTTON" style="width:75" VALUE="Modifier" onClick="history.back()" >
					
				<input name="valider" style="width:75" type="button" OnClick="window.location.href='valider_p_idees.asp'" value="Valider">	
			  
					 <!-- <input name="valider" style="width:75" type=submit value="Valider" > -->
				  
				  </td></tr>
				  
                </table>
	</td></tr><tr><td colspan="2"></td></tr></table>


<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>