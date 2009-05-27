<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
<style type="text/css">
<!--
#Layer1 {
	background-color: #7EA050;
	width:850px;
	padding:2px;
}
#slogan {
	background-color:#FFFFFF;
	width:850px;
	}
.style3 {
	font-size: 11px;
	color: #FFFFFF;
	font-weight: bold;
	font:Arial, "Arial Unicode MS", Biondi;
}
.style4 {
	color: #FFFFFF;
	font-size: 11px;
}
.style5 {font-size: 11px}
-->
</style>
</head>

<body bgcolor="#CCCCCC">

<center><div id="Layer1">
<%
    if session("admin_nom")<>"" then
        Response.Write "<b>Bonjour "&session("admin_nom")&"</b><br/>"
        Response.Write "<a href='deconnect.asp' title='Se deconnecter' >"&Server.HtmlEncode("Se déconnecter")&"</a>"
    else
%>
        <form action="p_membres.asp" method="post">
    	<span class="style3">&nbsp;Nom d'utilisateur: </span> 
        <input type="text" name="loga" class="txt" id="loga"  maxlength="100" size="15" />
        <span class="style3"> Mot de passe :</span>
        <input type="password" name="password" class="txt" id="password" maxlength="30" size="15" />
        <input type="submit" name="OK" value="Se connecter" />
&nbsp;<a href="p_adhesion.asp">&nbsp;<span class="style3"><strong>Créer un nouveau compte</strong></span></a>
        </form>
<%
    end if
%>
</div>

<div id="slogan">
<!-- #include file="grand_header.txt"--></div></center>


</body>
</html>
