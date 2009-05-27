<!-- #include file="admin_securite.asp"-->
<html>
<head>
    <!-- #include file="connexion.asp"-->
    <title>Rhône-solidarité</title>
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
    espace="&#034;"
    simplecot="&#039;"

rsPost = "UPDATE CV SET Visible=1 WHERE NumCV = " & Request.Querystring("num") & ""
Conn.Execute(rsPost)
majDate()

response.redirect("p_admin_cv_validation.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>