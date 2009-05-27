<html>
<head>
	<!-- #include file="connexion.asp"-->
	<title>Rhône-solidarité</title>

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





SQL="SELECT * FROM OFFRES"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********

 
 '--code de la structure----------------------
 
 RS("DateOff")=date
 RS("dureeOff")=replace(REPLACE(session("duree_offre"),"""",espace),"'",simplecot) 
 RS("StatutOff")=replace(REPLACE(session("statut"),"""",espace),"'",simplecot)
 RS("RaisonSocEntOff")=replace(REPLACE(session("rs"),"""",espace),"'",simplecot)
 RS("AdrEntOff")=replace(REPLACE(session("adresse"),"""",espace),"'",simplecot)
 RS("CPEntOff")=replace(REPLACE(session("cp"),"""",espace),"'",simplecot)
 RS("VilleEntOff")=replace(REPLACE(session("ville"),"""",espace),"'",simplecot)
 RS("CivilliteRespOff")=replace(REPLACE(session("civilite"),"""",espace),"'",simplecot)
 RS("NomRespOff")=replace(REPLACE(session("nom_responsable"),"""",espace),"'",simplecot)
 RS("PrenomRespOff")=replace(REPLACE(session("prenom_responsable"),"""",espace),"'",simplecot)
 RS("MailRespOff")=replace(REPLACE(session("email"),"""",espace),"'",simplecot)
 RS("TelRespOff")=replace(REPLACE(session("tel"),"""",espace),"'",simplecot)
 
If (session("profil")="Emploi") then
	RS("ProfilOff")=1
end if
if (session("profil")="Stage") then
	RS("ProfilOff")=2
end if
if (session("profil")="Benevolat") then
	RS("ProfilOff")=3
	end if
if (session("profil")="Autre") then
	RS("ProfilOff")=4
End if
 
 
 RS("IntituleOff")=replace(REPLACE(session("intitule"),"""",espace),"'",simplecot)
 RS("LieuOff")=replace(REPLACE(session("lieu"),"""",espace),"'",simplecot)
 RS("VilleOff")=replace(REPLACE(session("precision_lieu"),"""",espace),"'",simplecot)
 RS("DescOff")=replace(REPLACE(session("description"),"""",espace),"'",simplecot)
 RS("DureeOff")=replace(REPLACE(session("duree_contrat"),"""",espace),"'",simplecot)
 
 
 
If (session("indemnite")="oui") then
	RS("IndemniteOff")=1
else
	RS("IndemniteOff")=0
End if
	
 
 
  RS("DocOff")=replace(REPLACE(session("doc_a_fournir"),"""",espace),"'",simplecot)
 RS("MontantOff")=replace(REPLACE(session("montant_indemnite"),"""",espace),"'",simplecot)
  RS("AutIndOff")=replace(REPLACE(session("autres_indemnites"),"""",espace),"'",simplecot)
 RS("visible")=0

 
RS.update
RS.Close
set RS = Nothing





%>



<%


 ' -----------------envoi information au destinataire ------------------------           
Dim ObjSendMail
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Update
 


'End remote SMTP server configuration section==
     

ObjSendMail.To = session("email")
'ObjSendMail.To = "trialrofr2@yahoo.fr"
ObjSendMail.Subject = "Validation de votre offre"
ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " &  session("civilite") & " " &  session("prenom_responsable") & " " & session("nom_responsable") &   "<br><br>Votre offre &agrave; bien &eacute;t&eacute; enregistr&eacute;e sur le site www.rhone-solidarite.com.<br><br>Elle sera publi&eacute;e apr&egrave;s validation par nos services.<br><br>Merci pour la confiance que vous nous accordez. <br><br> <i>Le service des annonces de  Rhone-solidarite.com</i>"

ObjSendMail.Send
     
Set ObjSendMail = Nothing  



%>


<%
session("duree_offre")=""
session("statut")=""

session("rs")=""
session("adresse")=""
session("cp")=""
session("ville")=""
session("responsable")=""
session("tel")=""
session("profil")=""
session("intitule")=""
session("lieu")=""
session("description")=""
session("duree_contrat")=""
session("indemnite")=""
session("montant_indemnite")=""
response.redirect("valid_offre.asp")
%>
<!-- #include file="deconnexion.asp"-->
</body>
</html>