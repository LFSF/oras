<% ENVOYEUR=request.form("Fsendername") %>
<% MailEnvoyeur=request.form("Fsender") %>
<% MailAmi=request.form("Ffriend") %>	
<%

' -----------------envoi information au destinataire ------------------------           
	Dim ObjSendMail
	Set ObjSendMail = CreateObject("CDO.Message") 

	

	'Configuration des information pour le serveur SMTP à distance
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
	ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
	ObjSendMail.Configuration.Fields.Update
	
	'End remote SMTP server configuration section==
		 
	ObjSendMail.To = MailAmi '"gaetanandria@gmail.com" ' 
	ObjSendMail.Subject = "Decouvrez les interviews de Rhone-Solidarite.com !"
	ObjSendMail.From = MailEnvoyeur
	     
	' Ecriture du mail
	
	'Lien vers la page que vous souhaitez envoyer
	ObjSendMail.HTMLBody = "  Votre ami(e) : " & ENVOYEUR &" vous recommande la visite de la page suivante : <a href=http://www.rhone-solidarite.com/p_interview.asp>http://www.rhone-solidarite.com/p_interview.asp</a>  "

	ObjSendMail.Send
'erreur sur l'objsendmail lorsque le script ne voit pas a qui envoyer le mail pour  ObjSendMail.To = Request.Form("email")
	Set ObjSendMail = Nothing  


%>
<html>
<head>
<title>Message Envoyé</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body background="img/fond.jpg" >
<table >
  <tr>
    
    <td height="62" width="423" > 
      <div align="center"><font size="3" face="Verdana, Arial, Helvetica, sans-serif">Envoyer 
        cette page &agrave; un ami</font></div>
   
      <div align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000">Message 
        envoy&eacute; </font><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#FFFFFF"><br>
        <br><br>
        <a href="#" onClick=javascript:window.close()><font color="#999999">Fermer 
        cette fenêtre</font></a></font></div>
    </td>
  </tr>
</table>
</body>
</html>
