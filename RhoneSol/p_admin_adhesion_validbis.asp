
<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
		<!-- #include file="grand_meta.txt"-->
		<!-- #include file="connexion.asp"-->
		<title>Rh�ne-solidarit�</title>

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


<!-- #include file="FCKeditor/fckeditor.asp" -->


<%

 	espace="&#034;"
	simplecot="&#039;"

set rsMail = Conn.Execute("SELECT * FROM MEMBRE WHERE NumMembre = " & session("num") & "")
'Conn.Execute(rsMail)


rsPost = "UPDATE MEMBRE SET AdhesionMembre = '" & "oui" & "' WHERE NumMembre = " & session("num") & ""
Conn.Execute(rsPost)




'Envoi de mail
Dim ObjSendMail
	Set ObjSendMail = CreateObject("CDO.Message") 

	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	ObjSendMail.Configuration.Fields.Update

	
	
	'End remote SMTP server configuration section==
	     
		envoi_lien ="<a href=http://www.rhone-solidarite.com/>Aller sur Rh�ne Solidarit�</a>." 

		 
	ObjSendMail.To = rsMail("MailMembre") 'session("MailMembre")
	ObjSendMail.Subject = "Validation de votre inscription"
	ObjSendMail.From = "contact@rhone-solidarite.com"
	     
	
	ObjSendMail.HTMLBody = "Bonjour,  <br/> Votre adh�sion a bien �t� valid�e.<br/><br/>Voici vos identifiants :<br/> -login : " & rsMail("MailMembre") & "<br/>-Mot de passe : " & rsMail("MdpMembre") & "<br/><br/>	Cliquez sur le lien suivant pour visiter le site  : <br/><br/>" &	envoi_lien &" <br/><br/>Cordialement.<br/><br/> L'�quipe de Rhone-solidarite."
	
	
	ObjSendMail.Send

	Set ObjSendMail = Nothing  







		

'Response.Redirect("newposteditDelete.asp")
%>



<!-- #include file="deconnexion.asp"-->
<%

response.redirect("p_admin_adhesion_validation.asp")
%>
</body>
</html>