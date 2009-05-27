<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rh&ocirc;ne-solidarit&eacute;</title>
<!-- #include file="connexion.asp"-->

<link href="styles.css" rel="stylesheet" type="text/css" />


	<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>
<%if  session("compatible_IE6")="OUI" then%>
<body  bgcolor="#bcbaa6" onload="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%else%>
<body  bgcolor="#bcbaa6"  leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
</SCRIPT>
<%
end if   

	espace="&#034;"
	simplecot="&#039;"
	
SQLcv="SELECT * FROM reponse_offre"

Set RS = server.createobject("ADODB.Recordset")
RS.Open SQLcv,Conn , 3, 3

RS.addnew
'***********
RS("civiliteRepOff")=session("civilite")
RS("ageRepOff")=session("age")
RS("nomRepOff")=session("nom")
RS("prenomRepOff")=session("prenom")
RS("adresseRepOff")=session("adresse")
RS("cpRepOff")=session("cp")
RS("villeRepOff")=session("ville")
RS("emailRepOff")=session("email")
RS("telephoneRepOff")=session("tel")
RS("commentaireRepOff")=session("commentaire")
RS("lien_httpRepOff")=session("lien_http")

RS("date_inscriptionRepOff")=date
RS("diplome_en_courRepOff")=replace(REPLACE(session("diplome_en_cour"),"""",espace),"'",simplecot)
RS("diplome_obtenuRepOff")=replace(REPLACE(session("diplome_obtenu"),"""",espace),"'",simplecot)
RS("autre_diplomeRepOff")=replace(REPLACE(session("autre_diplome"),"""",espace),"'",simplecot)
RS("experience_proRepOff")=replace(REPLACE(session("experience_pro"),"""",espace),"'",simplecot)
RS("niveau_formationRepOff")=replace(REPLACE(session("niveau_formation"),"""",espace),"'",simplecot)
RS("disponibilite_jourRepOff")=replace(REPLACE(session("disponibilite_jour"),"""",espace),"'",simplecot)
RS("disponibilite_moisRepOff")=replace(REPLACE(session("disponibilite_mois"),"""",espace),"'",simplecot)
RS("disponibilite_anneeRepOff")=replace(REPLACE(session("disponibilite_annee"),"""",espace),"'",simplecot)
RS("NumOff")=session("NumOff")

 if session("nameOfFile")<>"" then
 
 RS("filenameRepOff")= replace(REPLACE(session("filename"),"""",espace),"'",simplecot)
 
 end if

RS.update
RS.Close



 ' -----------------envoi information &agrave; la personne qui r&eacute;pond &agrave; l'offre ------------------------  
 
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
ObjSendMail.Subject = "Validation de votre E-CV"
ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " &  session("civilite") & " " &  session("prenom") & " " & session("nom") &   "<br/><br/>Votre r&eacute;ponse &agrave; l'offre &agrave; bien &eacute;t&eacute; pris en compte sur le site www.rhone-solidarite.com .<br/>Merci pour la confiance que vous nous accordez. <br/><br/> Le service des annonces de  Rhone-solidarite.com"

ObjSendMail.Send
     
Set ObjSendMail = Nothing  



' -----------------envoi information &agrave; la personne qui &agrave; proposer l'offre ------------------------       

set RsRepOff = conn.execute("Select * from OFFRES where NumOff= " & session("NumOff") & "")
set RsMax = conn.execute("Select NumRepOff from reponse_offre where NumRepOff=(select max(NumRepOff) from reponse_offre)")
set RsReponse= conn.execute("Select * from reponse_offre where NumRepOff="&RsMax("NumRepOff")&"")
  
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Update
 


'End remote SMTP server configuration section==
     

ObjSendMail.To = RsRepOff("MailRespOff")
'ObjSendMail.To = "trialrofr2@yahoo.fr"
ObjSendMail.Subject = "Validation de votre E-CV"
ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " & RsRepOff("CivilliteRespOff") & " " &  RsRepOff("NomRespOff") & " " & RsRepOff("PrenomRespOff") &"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody & "<br/><br/>"&RsReponse("civiliteRepOff")&" "&RsReponse("nomRepOff")&" "&RsReponse("prenomRepOff")&" a manifest&eacute; son inter&ecirc;t pour l'offre concernant le poste de "&RsRepOff("IntituleOff")&" d&eacute;pos&eacute; sur le site www.rhone-solidarite.com ."
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Voici ces informations :<br/>" 
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Adresse : "&RsReponse("AdresseRepOff")&"<br/>" 
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Code Postal : "&RsReponse("cpRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Ville : "&RsReponse("villeRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Mail : "&RsReponse("emailRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"T&eacute;l&eacute;phone : "&RsReponse("telephoneRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Son CV :<br/>" 
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Niveau formation : "&RsReponse("niveau_formationRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Dipl&ocirc;me en cours : "&RsReponse("diplome_en_courRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Dernier dipl&ocirc;me obtenu : "&RsReponse("diplome_obtenuRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Autres dipl&ocirc;mes : "&RsReponse("autre_diplomeRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Exp&eacute;rience professionelles : "&RsReponse("experience_proRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Autres informations :<br/>" 
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Disponible &agrave; partir du : "&RsReponse("disponibilite_jourRepOff")&"/"&RsReponse("disponibilite_moisRepOff")&"/"&RsReponse("disponibilite_anneeRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Commentaires : "&RsReponse("commentaireRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"Lien divers : "&RsReponse("lien_httpRepOff")&"<br/>"
ObjSendMail.HTMLBody = ObjSendMail.HTMLBody &"<br/>Merci pour la confiance que vous nous accordez. <br/><br/> Le service emploi de  Rhone-solidarite.com"
ObjSendMail.Send
     
Set ObjSendMail = Nothing  


response.redirect("valid_depotcv.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>