
<html>
<head>
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
<link rel="stylesheet" href="style.css" type="text/css">

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


<!-- #include file="FCKeditor/fckeditor.asp" -->

<%
  	espace="&#034;"
	simplecot="&#039;"

 

SQL="SELECT * FROM INTERVIEW"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********

 
 '--code de la structure----------------------
 
 
 RS("DateItw")=replace(REPLACE(session("date_interview"),"""",espace),"'",simplecot)
 RS("StatutEnt")=replace(REPLACE(session("statut"),"""",espace),"'",simplecot)
 RS("RaiSocEnt")=replace(REPLACE(session("rs"),"""",espace),"'",simplecot)
 RS("AdrEnt")=replace(REPLACE(session("adresse"),"""",espace),"'",simplecot)
 RS("CPEnt")=replace(REPLACE(session("cp"),"""",espace),"'",simplecot)
 RS("VilleEnt")=replace(REPLACE(session("ville"),"""",espace),"'",simplecot)
 RS("PaysEnt")=replace(REPLACE(session("pays"),"""",espace),"'",simplecot)
 RS("CiviliteRespEnt")=replace(REPLACE(session("civilite"),"""",espace),"'",simplecot)
 RS("NomRespEnt")=replace(REPLACE(session("nom_responsable"),"""",espace),"'",simplecot)
 RS("PrenomRespEnt")=replace(REPLACE(session("prenom_responsable"),"""",espace),"'",simplecot)
 RS("MailRespEnt")=replace(REPLACE(session("email"),"""",espace),"'",simplecot)
 RS("TelRespEnt")=replace(REPLACE(session("tel"),"""",espace),"'",simplecot)
 RS("IntroItw")=replace(REPLACE(session("intro_interview"),"""",espace),"'",simplecot)
 RS("DescriptionItw")=replace(REPLACE(session("titre_interview"),"""",espace),"'",simplecot) 
 RS("CodeValidItw")= 0
 RS("NumMembre")=session("admin_id")

RS.update
RS.Close

SQL2 ="SELECT MAX(NumItw) AS NumInt FROM INTERVIEW"
Set RSnum = server.createobject("ADODB.Recordset")
RSnum.Open SQL2,Conn , 3, 3
numint = RSnum("NumInt")
numint = numint 
RSnum.close

SQL2="SELECT * FROM QUESTION"
Set RS2 = server.createobject("ADODB.Recordset")
RS2.Open SQL2,Conn , 2, 3
 
 i = 1
 
while i < 21 
if session("question" & i & "")<> "" then
RS2.addnew
RS2("Question")=session("question" & i & "")
RS2("Reponse")=replace(REPLACE(session("reponse" & i & ""),"""",espace),"'",simplecot)
RS2("NumItw")= numint
end if
i = i + 1
wend



RS2.update 

 RS2.close
set RS = Nothing
set RS2 = Nothing
set RSnum = Nothing
 
 ' -----------------envoi information au destinataire ------------------------           
'Dim ObjSendMail
'Set ObjSendMail = CreateObject("CDO.Message") 
'..................................................................................................................     
'This section provides the configuration information for the remote SMTP server.
'.....................................................................................................................................     
'ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
'ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
'ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
'ObjSendMail.Configuration.Fields.Update
 


'End remote SMTP server configuration section==
     
'............................................................................................................................
'ObjSendMail.To = session("email")

'ObjSendMail.Subject = "Validation de votre E-CV"
'ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
'ObjSendMail.HTMLBody = "Bonjour " &  session("civilite") & " " &  session("prenom") & " " & session("nom") &   "<br><br>Votre CV  a bien été enregistré sur le site www.rhone-solidarite.com .<br>Merci pour la confiance que vous nous accordez. <br><br> Le service des annonces de  Rhone-solidarite.com"

'ObjSendMail.Send
     
'Set ObjSendMail = Nothing  

response.redirect("p_admin_interview.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>