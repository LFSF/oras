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

Set rsv = Server.CreateObject("ADODB.RecordSet")

 SQL1 = "Select Max(NumCV) as num from CV"
 
  rsv.open SQL1,conn,1,3


'for i=0 to rsv.EOF
	cv = rsv.fields("num")
	'response.write(cv)
	'rsv.MoveNext
'next


cvn = cv+1

rsv.Close

jour = day(date())
if (jour<10) then
	jour = "0" & jour
end if
mois = Month(Date())
if (mois<10) then
	mois = "0" & mois
end if
if cvn <10 then

num = "CV" & year(date()) & mois & jour & "000" &cvn

end if

if cvn >9 and  cvn<100 then

num = "CV" & year(date()) & mois & jour & "00" &cvn

end if

if cvn >99 and  cvn<999 then

num = "CV" & year(date()) & mois & jour & "0" &cvn

end if




  	espace="&#034;"
	simplecot="&#039;"

	
'SQL="SELECT * FROM CV, MEMBRE, ANNONCES WHERE MEMBRE.NumMembre=CV.NumMembre AND CV.NumCV=ANNONCES.NumCV"
SQL="SELECT * FROM CV 
'SQL1="select * from Membre
'SQL2="select * from annonces

Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********

 RS("DateMembre")=replace(REPLACE(date,"""",espace),"'",simplecot) 
 
 
 RS("CivMembre")=replace(REPLACE(session("civilite"),"""",espace),"'",simplecot) 
 RS("AgeMembre")=replace(REPLACE(session("age"),"""",espace),"'",simplecot) 
 RS("NomMembre")=replace(REPLACE(session("nom"),"""",espace),"'",simplecot)
 RS("PrenomMembre")=replace(REPLACE(session("prenom"),"""",espace),"'",simplecot)
 RS("AdrMembre")=replace(REPLACE(session("adresse"),"""",espace),"'",simplecot)
 RS("CPMembre")=replace(REPLACE(session("cp"),"""",espace),"'",simplecot)
 RS("VilleMembre")=replace(REPLACE(session("ville"),"""",espace),"'",simplecot)
 RS("MailMembre")=replace(REPLACE(session("email"),"""",espace),"'",simplecot)
 RS("TelMembre")=session("tel")
  'RS("tel")=replace(REPLACE(session("tel"),"""",espace),"'",simplecot)
 RS("FormationAnn")=replace(REPLACE(session("niveau_formation"),"""",espace),"'",simplecot)
 RS("DiplomeActuCV")=replace(REPLACE(session("diplome_en_cour"),"""",espace),"'",simplecot)
 
 RS("DiplomeObtenuCV")=replace(REPLACE(session("diplome_obtenu"),"""",espace),"'",simplecot)
 RS("AutreDiplomeCV")=replace(REPLACE(session("autre_diplome"),"""",espace),"'",simplecot)
 RS("ProfilAnn")=replace(REPLACE(session("profil"),"""",espace),"'",simplecot)
 RS("IntituleAnn")=replace(REPLACE(session("intitule_poste"),"""",espace),"'",simplecot)
  RS("DispoJourAnn")=replace(REPLACE(session("disponibilite_jour"),"""",espace),"'",simplecot)
  RS("DispoMoisAnn")=replace(REPLACE(session("disponibilite_mois"),"""",espace),"'",simplecot)
  RS("DispoAnneeAnn")=replace(REPLACE(session("disponibilite_annee"),"""",espace),"'",simplecot)
  RS("DureeEspereeAnn")=replace(REPLACE(session("duree_esperee"),"""",espace),"'",simplecot)
 
   RS("DepartementAnn")=replace(REPLACE(session("lieu_du_poste"),"""",espace),"'",simplecot)
 RS("ExperienceProCV")=replace(REPLACE(session("experience_pro"),"""",espace),"'",simplecot)
 RS("CommAnn")=replace(REPLACE(session("commentaire"),"""",espace),"'",simplecot)
 RS("LienAnn")=replace(REPLACE(session("lien_http"),"""",espace),"'",simplecot) 

 if session("nameOfFile")<>"" then
 
 RS("filename")= replace(REPLACE(session("filename"),"""",espace),"'",simplecot)
 
 end if
 

 RS("Visible")=0 
 
RS.update
RS.Close

 
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
ObjSendMail.HTMLBody = "Bonjour " &  session("civilite") & " " &  session("prenom") & " " & session("nom") &   "<br><br>Votre CV  a bien été enregistré sur le site www.rhone-solidarite.com .<br/>Merci pour la confiance que vous nous accordez. <br/><br/> Le service des annonces de  Rhone-solidarite.com"

ObjSendMail.Send
     
Set ObjSendMail = Nothing  


response.redirect("valid_depotcv.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>