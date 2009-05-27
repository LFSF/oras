<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->

<link href="styles.css" rel="stylesheet" type="text/css" />



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

	<SCRIPT language="JavaScript"> 
	function fonctest()
	{
	window.location.href="espaceadh.asp";
	}
	function fonc100()
	{
	window.location.href='testd.asp';
	}
	function fonc1()
	{
	window.location.href='ndambog.asp';
	}
	<!--Hide JavaScript from Java-Impaired Browsers 
	//--> 


	</SCRIPT>
	<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>



<%if  session("compatible_IE6")="OUI" then%>
<body  bgcolor="#bcbaa6" onload="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%else%>
<body  bgcolor="#bcbaa6"  leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%
end if 
%>



<%  

	espace="&#034;"
	simplecot="&#039;"
	
'Ajout CV
SQLcv="SELECT * FROM CV"

Set RS = server.createobject("ADODB.Recordset")
RS.Open SQLcv,Conn , 3, 3

RS.addnew
'***********

RS("DateCV")=date()
RS("DiplomeActuCV")=replace(REPLACE(session("diplome_en_cour"),"""",espace),"'",simplecot)
RS("DiplomeObtenuCV")=replace(REPLACE(session("diplome_obtenu"),"""",espace),"'",simplecot)
RS("AutreDiplomeCV")=replace(REPLACE(session("autre_diplome"),"""",espace),"'",simplecot)
RS("ExperienceProCV")=replace(REPLACE(session("experience_pro"),"""",espace),"'",simplecot)
RS("FormationAnn")=replace(REPLACE(session("niveau_formation"),"""",espace),"'",simplecot)
'RS("NumMembre")=replace(REPLACE(session("numMembre"),"""",espace),"'",simplecot)
RS("FinCV")=replace(REPLACE(session("DateFinCV"),"""",espace),"'",simplecot)
RS("Visible")=0


'****Ajout tristan*********************
RS("civilite")=replace(REPLACE(session("civilite"),"""",espace),"'",simplecot)
RS("age")=replace(REPLACE(session("age"),"""",espace),"'",simplecot)
RS("nom")=replace(REPLACE(session("nom"),"""",espace),"'",simplecot)
RS("prenom")=replace(REPLACE(session("prenom"),"""",espace),"'",simplecot)
RS("adresse")=replace(REPLACE(session("adresse"),"""",espace),"'",simplecot)
RS("cp")=replace(REPLACE(session("cp"),"""",espace),"'",simplecot)
RS("ville")=replace(REPLACE(session("ville"),"""",espace),"'",simplecot)
RS("email")=replace(REPLACE(session("email"),"""",espace),"'",simplecot)
RS("tel")=replace(REPLACE(session("tel"),"""",espace),"'",simplecot)

'***** fin ajout tristan***************




 if session("nameOfFile")<>"" then
 
 RS("PieceJointeCV")= replace(REPLACE(session("filename"),"""",espace),"'",simplecot)
 
 end if

RS.update
RS.Close

'Ajout Annonce
SQLannonce="SELECT * FROM ANNONCES"

Set RS2 = server.createobject("ADODB.Recordset")
RS2.Open SQLannonce,Conn , 3, 3
Set RS3 = conn.Execute("Select Max(NumCV) AS max FROM CV")

RS2.addnew


'RS2("ProfilAnn")=replace(REPLACE(session("profil"),"""",espace),"'",simplecot)
If (session("profil")="emploi") then
	RS2("ProfilAnn")=1
end if
if (session("profil")="stage") then
	RS2("ProfilAnn")=2
end if
if (session("profil")="autre") then
	RS2("ProfilAnn")=3
End if

RS2("DateAnn")=date()
RS2("NumCV")= RS3("max")





'RS2("NumMembre")=replace(REPLACE(session("numMembre"),"""",espace),"'",simplecot)
RS2("IntituleAnn")=replace(REPLACE(session("intitule_poste"),"""",espace),"'",simplecot)
RS2("DispoJourAnn")=replace(REPLACE(session("disponibilite_jour"),"""",espace),"'",simplecot)
RS2("DispoMoisAnn")=replace(REPLACE(session("disponibilite_mois"),"""",espace),"'",simplecot)
RS2("DispoAnneeAnn")=replace(REPLACE(session("disponibilite_annee"),"""",espace),"'",simplecot)
RS2("DureeEspereeAnn")=replace(REPLACE(session("duree_esperee"),"""",espace),"'",simplecot)
RS2("DepartementAnn")=replace(REPLACE(session("lieu_du_poste"),"""",espace),"'",simplecot)
RS2("CommAnn")=replace(REPLACE(session("commentaire"),"""",espace),"'",simplecot)
RS2("LienAnn")=replace(REPLACE(session("lien_http"),"""",espace),"'",simplecot)
RS2("PeriodeAnn")=replace(REPLACE(session("lien_http"),"""",espace),"'",simplecot)
RS2("LieuAnn")=replace(REPLACE(session("lieu_du_poste"),"""",espace),"'",simplecot)
RS2("Visible")=0

RS2.update
RS2.Close


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
ObjSendMail.Subject = "Validation de votre E-CV"
ObjSendMail.From = "contact@rhone-solidarite.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " &  session("civilite") & " " &  session("prenom") & " " & session("nom") &   "<br/><br/>Votre CV  a bien &eacute;t&eacute; enregistr&eacute; sur le site www.rhone-solidarite.com .<br/><br/>Il sera visible apr&egrave;s validation par nos services!<br/><br/>Merci pour la confiance que vous nous accordez. <br/><br/>Le service des annonces de  Rhone-solidarite.com"

ObjSendMail.Send
     
Set ObjSendMail = Nothing  

session.Abandon
response.redirect("valid_depotcv.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>