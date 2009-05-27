
<!-- #include file="admin_securite.asp"-->
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
'Mise à jour dans la BDD
    espace="&#034;"
    simplecot="&#039;"
rsPost = "UPDATE CREATION SET Validation=1, ReponseCrea='"&request.form("FCKeditor1")&"' WHERE NumCrea = " & Request.Querystring("NumCrea") & ""

Conn.Execute(rsPost)
majDate()

'Envoi Mail


Set rsCrea = Conn.Execute("SELECT * FROM Creation WHERE NumCrea = " & Request.Querystring("NumCrea") & "")
Dim ObjSendMail
    Set ObjSendMail = CreateObject("CDO.Message") 

    

    'Configuration des information pour le serveur SMTP à distance
    ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
    ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
    ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
    ObjSendMail.Configuration.Fields.Update
    
    'End remote SMTP server configuration section==
         
    ObjSendMail.To = rsCrea("MailCrea")
    ObjSendMail.Subject = "Réponse de votre demande de création de site."
    ObjSendMail.From = "contact@rhone-solidarite.com"
         
    ' Ecriture du mail
    
    'Lien vers la page que vous souhaitez envoyer
    ObjSendMail.HTMLBody = "  Bonjour "&rsCrea("CivCrea")&" "&rsCrea("NomCrea")&" "&rsCrea("PrenomCrea")&",</br>Message :"&request.form("FCKeditor1")&"</br> Le service de Rh&ocirc;ne solidarit&eacute;.  "

    ObjSendMail.Send
'erreur sur l'objsendmail lorsque le script ne voit pas a qui envoyer le mail pour  ObjSendMail.To = Request.Form("email")
    Set ObjSendMail = Nothing  

%>

<%

response.redirect("p_admin_demande_site_validation.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>