<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=Server.HtmlEncode("Déconnexion")%></title>

</head>

<body style="background-color:#cccccc;">
<!-- #include file="connexion.asp"-->
<%
session_destroy()
%>
<div align="center" style="background-color:white;padding:1%;border:2px solid black;font-size:15px;width: 75%;margin-left:10%">Merci de votre visite.<br/>
Vous allez être redirigé vers la page d'accueil.
</div>
<%
Response.AddHeader "Refresh", "2;URL=http://"&Request.ServerVariables("SERVER_NAME")
%>
<!-- #include file="deconnexion.asp"-->
</body>
</html>