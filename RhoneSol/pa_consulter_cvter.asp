<html>
<head>
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarit&eacute;</title>

<link rel="stylesheet" href="style.css" type="text/css">

</head>
<%if  session("compatible_IE6")="OUI" then
%>
<body  bgcolor="#bcbaa6" onload="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%else%>
<body  bgcolor="#bcbaa6"  leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<!--<div style="z-index:5;">
<SCRIPT LANGUAGE="JavaScript" SRC="ejs_menu_dyn.js">
</SCRIPT>-->
<%end if%>


<%
  	espace="&#034;"
	simplecot="&#039;"
               
 


SQL="SELECT * FROM reponse_cv"

Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********

 
 '--code de la structure----------------------
  
  
  RS("Exp_MailRcv")=replace(REPLACE(request.form("email"),"""",espace),"'",simplecot) 
  RS("Exp_CiviliteRcv")=replace(REPLACE(request.form("civilite"),"""",espace),"'",simplecot) 
  RS("Exp_NomRcv")=replace(REPLACE(request.form("nom_responsable"),"""",espace),"'",simplecot) 
  RS("Exp_PrenomRcv")=replace(REPLACE(request.form("prenom_responsable"),"""",espace),"'",simplecot) 
  RS("Exp_StructureRcv")=replace(REPLACE(request.form("statut"),"""",espace),"'",simplecot) 
  RS("Exp_RaisonRcv")=replace(REPLACE(request.form("rs"),"""",espace),"'",simplecot) 
 
 RS("Exp_AdresseRcv")=replace(REPLACE(request.form("adresse"),"""",espace),"'",simplecot) 
 RS("Exp_CpRcv")=replace(REPLACE(request.form("cp"),"""",espace),"'",simplecot) 
 RS("Exp_VilleRcv")=replace(REPLACE(request.form("ville"),"""",espace),"'",simplecot) 
 RS("Exp_TelRcv")=replace(REPLACE(request.form("tel"),"""",espace),"'",simplecot) 
 RS("Exp_Message")=replace(REPLACE(request.form("message"),"""",espace),"'",simplecot) 
  RS("Date_Reponse")=Date
 RS("NumCV")=session("NumCV")

 session("mailrepCV")=request.form("email")
 RS.update
rs.Close
set rs = Nothing




%>
<%
 
 coordonne_exp =("<table border=1><tr><td><table><tr><td>Raison sociale</td><td>:</td><td>&nbsp;" & request.form("rs") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Type</td><td>:</td><td>&nbsp;" & request.form("statut") & "&nbsp;</td></tr>")
 'coordonne_exp = coordonne_exp + ("<tr><td>Raison Sociale</td><td>:</td><td>&nbsp;" & request.form("rs") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Adresse</td><td>:</td><td>&nbsp;" & request.form("adresse") & " "& request.form("cp") &" "& request.form("ville") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Nom - Prenom</td><td>:</td><td>&nbsp;" & " "  & " " & request.form("prenom_responsable") & " " & request.form("nom_responsable") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>T&eacute;l&eacute;phone</td><td>:</td><td>&nbsp;" & request.form("tel") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Mail</td><td>:</td><td>&nbsp;" & request.form("email") & "&nbsp;</td></tr></table></tr></td></table>")
 
 
 
 
 ' -----------------envoi information au destinataire ------------------------       

set rsCV=conn.execute("select NumMembre from cv where NumCV="&session("NumCV")&"") 
set rsCoMembre=conn.execute("select * from Membre where NumMembre="&rsCV("NumMembre")&"") 
 
Dim ObjSendMail
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Update
 


'End remote SMTP server configuration section==
     

ObjSendMail.To = rsCoMembre("MailMembre")
'ObjSendMail.To = "trialrofr2@yahoo.fr"
ObjSendMail.Subject = "Réponse à votre E-CV"
ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " &  rsCoMembre("CivMembre") & " " &  rsCoMembre("NomMembre") & " " & rsCoMembre("PrenomMembre")  &   "<br><br>En r&eacute;ponse &agrave; votre E-CV; voici le message de " & request.form("civilite") & " "  & request.form("prenom_responsable") & " " & request.form("nom_responsable") & ".  <br><br><br><table border=1><tr><td>&nbsp;Message&nbsp;</td></tr><tr><td>&nbsp;" & request.form("message") & "&nbsp;</td></tr></table><br><br>" &  coordonne_exp  & ".<br><br>Cordialement  <br><br> Le service des annonces de  Rhone-solidarite.com"

ObjSendMail.Send
     
Set ObjSendMail = Nothing  






%>


<%

		         
 ' -----------------envoi information a l expediteur ------------------------      
 ObjSendMail=""
'Dim ObjSendMail
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.


 
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Update
 

  
'End remote SMTP server configuration section==
     
ObjSendMail.To = request.form("email")

'ObjSendMail.To = "abculture@free.fr"
ObjSendMail.Subject = "Envoi de votre message à " & rsCoMembre("CivMembre")  & " " & rsCoMembre("NomMembre") & " " & mid(rsCoMembre("PrenomMembre"),1,1) & "."
ObjSendMail.From = "contact@rhone-solidarite.com"
     




ObjSendMail.HTMLBody = "Bonjour "  &  request.form("civilite") & " " &  request.form("prenom_responsable") & " " & request.form("nom_responsable") &   "<br><br>Votre message a &eacute;t&eacute; transmis &agrave; " & rsCoMembre("CivMembre")  & " " & rsCoMembre("PrenomMembre")  & " " & mid(rsCoMembre("NomMembre") ,1,1) & ".<br><br>Cordialement  <br><br> Le service des annonces de  Rhone-solidarite.com"


	
'ObjSendMail.TextBody = "je fais un test d'envoi de mail BIS "
     
ObjSendMail.Send
     
Set ObjSendMail = Nothing         
       
 
  
  %>   





<%

response.redirect("valid_message_cv.asp")
%>
</body>
</html>