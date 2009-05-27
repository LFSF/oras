
<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->
<html>
<head>
<title>Rhône-solidarité</title>

<link rel="stylesheet" href="style.css" type="text/css">

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

rsPost = "UPDATE OFFRES SET Visible=1 WHERE NumOff=" & Request.Querystring("num") & ""

Conn.Execute(rsPost)



%>





 
  <%

Conn.close 
		Set Conn=nothing
		

'Response.Redirect("newposteditDelete.asp")
%>




<%

response.redirect("p_admin_offre_validation.asp")
%>
<!-- #include file="deconnexion.asp"-->
</body>
</html>