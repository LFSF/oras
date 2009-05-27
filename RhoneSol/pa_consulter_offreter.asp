<html>
<head>
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité</title>

<link rel="stylesheet" href="style.css" type="text/css">
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

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}
<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
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
	

SQL="SELECT * FROM [reponses_offre]"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********

 
 '--code de la structure----------------------
  
  
  RS("exp_mail")=replace(REPLACE(request.form("email"),"""",espace),"'",simplecot) 
  RS("exp_civilite")=replace(REPLACE(request.form("civilite"),"""",espace),"'",simplecot) 
  RS("exp_nom")=replace(REPLACE(request.form("nom_responsable"),"""",espace),"'",simplecot) 
  RS("exp_prenom")=replace(REPLACE(request.form("prenom_responsable"),"""",espace),"'",simplecot) 
  RS("exp_structure")=replace(REPLACE(request.form("statut"),"""",espace),"'",simplecot) 
  RS("exp_rs")=replace(REPLACE(request.form("rs"),"""",espace),"'",simplecot) 
 
 RS("exp_adresse")=replace(REPLACE(request.form("adresse"),"""",espace),"'",simplecot) 
 RS("exp_cp")=replace(REPLACE(request.form("cp"),"""",espace),"'",simplecot) 
 RS("exp_ville")=replace(REPLACE(request.form("ville"),"""",espace),"'",simplecot) 
 RS("exp_tel")=replace(REPLACE(request.form("tel"),"""",espace),"'",simplecot) 
 RS("exp_message")=replace(REPLACE(request.form("message"),"""",espace),"'",simplecot) 

 RS("dest_num")=replace(REPLACE(session("dest_numcv"),"""",espace),"'",simplecot) 
 RS("dest_civilite")=replace(REPLACE(session("dest_civilite"),"""",espace),"'",simplecot) 
 RS("dest_nom")=replace(REPLACE(session("dest_nom"),"""",espace),"'",simplecot)
 RS("dest_prenom")=replace(REPLACE(session("dest_prenom"),"""",espace),"'",simplecot)
 RS("dest_email")=replace(REPLACE(session("dest_email"),"""",espace),"'",simplecot)
 RS("dest_poste_recherche")=replace(REPLACE(session("dest_poste_recherche"),"""",espace),"'",simplecot)
 RS("date_reponse")=Date
 
 

session("exp_email") =request.form("email")
 
 RS.update
rs.Close
set rs = Nothing
conn.Close
set conn= Nothing



%>




<%
 
 coordonne_exp =("<table border=1><tr><td><table><tr><td>Raison sociale</td><td>:</td><td>&nbsp;" & request.form("rs") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Type</td><td>:</td><td>&nbsp;" & request.form("statut") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Raison Sociale</td><td>:</td><td>&nbsp;" & request.form("rs") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Adresse</td><td>:</td><td>&nbsp;" & request.form("adresse") & " "& request.form("cp") &" "& request.form("ville") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Nom - Prenom</td><td>:</td><td>&nbsp;" & " "  & " " & request.form("prenom_responsable") & " " & request.form("nom_responsable") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Téléphone</td><td>:</td><td>&nbsp;" & request.form("tel") & "&nbsp;</td></tr>")
 coordonne_exp = coordonne_exp + ("<tr><td>Mail</td><td>:</td><td>&nbsp;" & request.form("email") & "&nbsp;</td></tr></table></tr></td></table>")
 
 
 
 
 ' -----------------envoi information au destinataire ------------------------           
Dim ObjSendMail
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Update
 


'End remote SMTP server configuration section==
     

ObjSendMail.To = session("dest_email")
'ObjSendMail.To = "trialrofr2@yahoo.fr"
ObjSendMail.Subject = "Réponse à votre E-CV"
ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " &  session("dest_civilite") & " " &  session("dest_prenom") & " " & session("dest_nom") &   "<br><br>En réponse à votre E-CV; voici le message de " & request.form("civilite") & " "  & request.form("prenom_responsable") & " " & request.form("nom_responsable") & ".  <br><br><br><table border=1><tr><td>&nbsp;Message&nbsp;</td></tr><tr><td>&nbsp;" & request.form("message") & "&nbsp;</td></tr></table><br><br>" &  coordonne_exp  & ".<br><br>Cordialement  <br><br> Le service des annonces de  Rhone-solidarite.com"

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
     
'ObjSendMail.To = "axu@axius.ro"
ObjSendMail.To = request.form("email")

'ObjSendMail.To = "abculture@free.fr"
ObjSendMail.Subject = "Envoi de votre message à " & session("dest_civilite") & " " & session("dest_prenom") & " " & mid(session("dest_civilite"),1,1) & "."
ObjSendMail.From = "contact@rhone-solidarite.com"
     

'ObjSendMail.HTMLBody = "Bonjour " &  session("exp_civilite") & " " &  session("exp_prenom") & " " & session("exp_nom") &   "<br><br>Votre message a été transmis à " & session("dest_civilite") & " " & session("dest_prenom") & " " & mid(session("dest_civilite"),1,1) & ".<br><br>Cordialement  <br><br> Le service des annonces de  Rhone-solidarite.com"


ObjSendMail.HTMLBody = "Bonjour "  &  request.form("civilite") & " " &  request.form("prenom_responsable") & " " & request.form("nom_responsable") &   "<br><br>Votre message a été transmis à " & session("dest_civilite") & " " & session("dest_prenom") & " " & mid(session("dest_civilite"),1,1) & ".<br><br>Cordialement  <br><br> Le service des annonces de  Rhone-solidarite.com"


	
'ObjSendMail.TextBody = "je fais un test d'envoi de mail BIS "
     
ObjSendMail.Send
     
Set ObjSendMail = Nothing         
       
 
  
  %>    

<%

response.redirect("valid_message_cv.asp")
%>
</body>
</html>