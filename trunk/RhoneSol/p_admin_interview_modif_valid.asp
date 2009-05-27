
<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<% if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_modif.asp" then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
else
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
	<!-- #include file="connexion.asp"-->

	<title>Rhône-solidarité</title>

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
<!--<div style="z-index:5;" -->

<%end if

espace="&#034;"
simplecot="&#039;"



rsPost = "UPDATE INTERVIEW SET CodeValidItw='non' AND DateValidItw='" & Date() & "' WHERE NumItw=" & Request.Querystring("num") & ""

Conn.Execute(rsPost)

<!-- #include file="deconnexion.asp"-->

response.redirect("p_admin_interview_modif.asp")
%>
</body>
</html>
<% end if %>
<% end if %>