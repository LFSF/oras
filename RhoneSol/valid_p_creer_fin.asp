<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!-- #include file="connexion.asp"-->
<!-- #include file="grand_meta.txt"-->
	<title>Rhône-solidarité</title>
	<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

	<!-- #include file="grand_header.txt"-->
<div id="contenu">
	<!-- #include file="fichier_menu.txt"-->	<div id="bandeau_orange">Vérification demande de création de site</div>

<table border="0px" width="100%" cellpadding="10px">
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation création de site _____________________________________________________</font> 
		</td>
    </tr>
</table>

<table background="img/haut_epingle.gif" style="background-repeat:no-repeat;" width="650" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">

<tr>
	<td>

<%
	espace="&#034;"
	simplecot="&#039;"

Set RS = server.createobject("ADODB.Recordset")

SQL="SELECT * FROM [CREATION]"
RS.Open SQL,Conn , 3, 3

RS.addnew

 RS("CivCrea")=replace(REPLACE(session("CivCrea"),"""",espace),"'",simplecot)
 RS("NomCrea")=replace(REPLACE(session("NomCrea"),"""",espace),"'",simplecot)
 RS("PrenomCrea")=replace(REPLACE(session("PrenomCrea"),"""",espace),"'",simplecot)
 RS("FonctionCrea")=session("FonctionCrea")
 RS("SocieteCrea")=replace(REPLACE(session("SocieteCrea"),"""",espace),"'",simplecot)
 RS("AdrCrea")=replace(REPLACE(session("AdrCrea"),"""",espace),"'",simplecot)
 RS("CpCrea")=replace(REPLACE(session("CpCrea"),"""",espace),"'",simplecot)
 RS("VilleCrea")=replace(REPLACE(session("VilleCrea"),"""",espace),"'",simplecot)
 RS("MailCrea")=replace(REPLACE(session("MailCrea"),"""",espace),"'",simplecot)
 RS("FixeCrea")=replace(REPLACE(session("FixeCrea"),"""",espace),"'",simplecot)
 RS("PortableCrea")=session("PortableCrea")
 RS("ProjetCrea")=replace(REPLACE(session("ProjetCrea"),"""",espace),"'",simplecot)
 RS("DemandeCrea")=replace(REPLACE(session("DemandeCrea"),"""",espace),"'",simplecot)
 RS("BudgetCrea")=replace(REPLACE(session("BudgetCrea"),"""",espace),"'",simplecot)
 RS("DelaiCrea")=replace(REPLACE(session("DelaiCrea"),"""",espace),"'",simplecot)
 RS("CommentCrea")=replace(REPLACE(session("CommentCrea"),"""",espace),"'",simplecot)
 RS("Validation")="0"

 RS.update
 rs.Close
set rs = Nothing


'Envoi de mail de confirmation
	Dim ObjSendMail
	Set ObjSendMail = CreateObject("CDO.Message") 

	

	'Configuration des information pour le serveur SMTP à distance
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	ObjSendMail.Configuration.Fields.Update
	
	'End remote SMTP server configuration section==
		 
	ObjSendMail.To = session("MailCrea")
	ObjSendMail.Subject = "Confirmation de votre demande de création de site."
	ObjSendMail.From = "contact@rhone-solidarite.com"
	     
	' Ecriture du mail
	
	'Lien vers la page que vous souhaitez envoyer
	ObjSendMail.HTMLBody = "  Bonjour "&session("CivCrea")&" "&session("NomCrea")&" "&session("PrenomCrea")&",</br>votre demande &agrave; bien &eacute;t&eacute; prise en compte par nos services, vous aurez une r&eacute;ponse dans les prochains jours.  "

	ObjSendMail.Send
'erreur sur l'objsendmail lorsque le script ne voit pas a qui envoyer le mail pour  ObjSendMail.To = Request.Form("email")
	Set ObjSendMail = Nothing  









response.redirect("valider_p_creer_fin.asp")
%>
				  
	</td>
</tr>
			  
                </table>  <!-- #include file="grand_footer.txt"-->  
		
</div>


		
<!-- #include file="deconnexion.asp"-->
</body>
</html>