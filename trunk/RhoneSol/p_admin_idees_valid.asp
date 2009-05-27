
<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <!-- #include file="connexion.asp"-->
        <title>Rhône-solidarité</title>

        <link rel="stylesheet" href="style.css" type="text/css">

        <script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>
<%if  session("compatible_IE6")="OUI" then%>
<body  bgcolor="#bcbaa6" onload="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%else%>
<body  bgcolor="#bcbaa6"  leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
        <!--<div style="z-index:5;">
        <SCRIPT LANGUAGE="JavaScript" SRC="ejs_menu_dyn.js">
        </SCRIPT>-->
        <%end if%>

        <!-- #include file="FCKeditor/fckeditor.asp" -->

<%session("FCKeditor1")=request.form("FCKeditor1")

            espace="&#034;"
            simplecot="&#039;"

        rsPost = "UPDATE IDEES SET Visible =1 , Reponse='"&request.form("FCKeditor1")&"' WHERE NumIdee = " & Request.Querystring("num") & ""

        Conn.Execute(rsPost)
        majDate()
        Set rsED = Conn.Execute("SELECT * FROM IDEES WHERE NumIdee = " & Request.Querystring("num") & "")    

            ' -----------------envoi information au destinataire ------------------------           
            Dim ObjSendMail
            Set ObjSendMail = CreateObject("CDO.Message") 

            'Configuration des information pour le serveur SMTP à distance
            ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
            ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
            ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
            ObjSendMail.Configuration.Fields.Update

            'End remote SMTP server configuration section==

            ObjSendMail.To = rsED("MailReponse")
            ObjSendMail.Subject = "Validation de votre suggestion du  " & rsED("DateIdee")
            ObjSendMail.From = "contact@rhone-solidarite.com"
                 
            ' Ecriture du mail
            'ObjSendMail.HTMLBody = "Bonjour " &  rs("NomMembre") & " " &  rs("PrenomMembre") & " " &   "<br><br>
            
            ObjSendMail.HTMLBody = "Bonjour " & rsED("Civilite") &" "& rsED("Nom") & " " & rsED("Prenom") & "<br/><br/><br/>" & " Nous vous informons de la validation de votre suggestion : <br/><br/>" & rsED("MessageIdee") & "<br/>"  
            
            ObjSendMail.HTMLBody = ObjSendMail.HTMLBody + "<br>R&eacute;ponse &agrave; votre suggestion : <br/> "&session("FCKeditor1")& "<br/><a href=""http://www.rhone-solidarite.com/"">Aller sur Rh&ocirc;ne-Solidarit&eacute;</a>."

            'Si vous recevez ce mail donc la newsletter fonctionne correctement .<br>Merci pour la confiance que vous nous accordez. <br><br> Le service des annonces de  Rhone-solidarite.com"

            ObjSendMail.Send

            Set ObjSendMail = Nothing  

        'fermeture de la connexion
        rsED.Close 

        response.redirect("p_admin_idees_validation.asp")
        %>
        <!-- #include file="deconnexion.asp"-->
</body>
</html>