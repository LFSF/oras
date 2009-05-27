<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!-- #include file="connexion.asp"-->
<!-- #include file="grand_meta.txt"-->
<title>Rh&ocirc;ne-solidarit&eacute;</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Espace Membres</div>

<div align="justify">
<table border="0px" width="100%" cellpadding="10px">
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation Adh&eacute;sion________________________________________________________</font></td>
    </tr>
   <tr>
		<td width=82%>
		<!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->		
		<a href="p_accueil.asp"><font size="1"><b> Retour à l'Accueil &nbsp;</b></font></a>
		</td>
	</tr>
</table>
</div>

<table width="400" border="0px" valign="center" align="center">
<tr>
	<td>	Votre adh&eacute;sion  a bien &eacute;t&eacute; enregistr&eacute;.
			<br>Merci pour la confiance que vous nous accordez.
			<br>Pour confirmer votre inscription veuillez l'activer via le mail envoy&eacute; a : <font color="blue"><%=session("MailMembre")%></font>
			<br>(Attention: votre mail pourrait &ecirc;tre envoy&eacute; dans le dossier de courrier ind&eacute;sirable)


<%

Dim ObjSendMail
	Set ObjSendMail = CreateObject("CDO.Message") 

	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	ObjSendMail.Configuration.Fields.Update

	
	
	'End remote SMTP server configuration section==
	     
		envoi_lien ="<a href=http://www.rhone-solidarite.com/p_confirmation.asp?confirmation=" & session("MailMembre") & "&mdp=" & session("MdpMembre") & " >Lien confirmation adhesion</a>." 

		 
	ObjSendMail.To = session("MailMembre")
	ObjSendMail.Subject = "Confirmation inscription du " & date
	ObjSendMail.From = "contact@rhone-solidarite.com"
	     
	
	ObjSendMail.HTMLBody = "Bonjour  <br/> Votre adh&eacute;sion a bien &eacute;t&eacute; enregistr&eacute;.<br/><br/>Voici vos identifiants :<br/> -login : " & session("MailMembre") & "<br/>-Mot de passe : " & session("MdpMembre") & "<br/><br/>	Cliquez sur le lien suivant pour la valider! <br/><br/>" &	envoi_lien &" <br/><br/>Cordialement.<br/><br/> L'&eacute;quipe de Rhone-solidarite."
		
	ObjSendMail.Send

	Set ObjSendMail = Nothing  



%>


	</td>
	</tr>
	

</table>

 

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />


<%

Session.Contents.Remove("NomMembre")
Session.Contents.Remove("PrenomMembre")
Session.Contents.Remove("TelMembre")
Session.Contents.Remove("MailMembre")
Session.Contents.Remove("AdrMembre")
Session.Contents.Remove("MdpMembre")
Session.Contents.Remove("News")
Session.Contents.Remove("AgeMembre")
Session.Contents.Remove("CivMembre")
Session.Contents.Remove("VilleMembre")
Session.Contents.Remove("CPMembre")
Session.Contents.Remove("FonctionMembre")
Session.Contents.Remove("OrganismeMembre")
Session.Contents.Remove("PaysMembre")
Session.Contents.Remove("PartenaireMembre")
Session.Contents.Remove("CooperationMembre")
Session.Contents.Remove("SolidaireMembre")
Session.Contents.Remove("FormationMembre")
Session.Contents.Remove("AutreMembre")
Session.Contents.Remove("RedacteurMembre")
Session.Contents.Remove("InterviewMembre")
Session.Contents.Remove("CreationsiteMembre")
Session.Contents.Remove("AutresMembre")
Session.Contents.Remove("MessageMembre")

%>





<!-- #include file="grand_footer.txt"-->  
 </div>
</body>

  
<!-- #include file="connexion.asp"-->

</html>