
<!-- #include file="admin_securite.asp"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->
<% if not (session("admin_acces_admin")=1 or session("acces_off")= 1) then
	response.redirect("p_admin.asp")
	else
%>
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



<%

    espace="&#034;"
    simplecot="&#039;"





  
  



   
   

rsPost = "UPDATE OFFRES SET Visible=1 WHERE NumOff=" & Request.Querystring("num") & ""






Conn.Execute(rsPost)
majDate()


%>





 
  <%

'Response.Redirect("newposteditDelete.asp")
%>



<!-- #include file="deconnexion.asp"-->
<%

response.redirect("p_admin_offre_validation.asp")
%>
</body>


</html>
<%end if%>