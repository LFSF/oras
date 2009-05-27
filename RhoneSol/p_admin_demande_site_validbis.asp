
<!-- #include file="admin_securite.asp"-->
<html>
<head>
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
<!--<div style="z-index:5;">
<SCRIPT LANGUAGE="JavaScript" SRC="ejs_menu_dyn.js">
</SCRIPT>-->
<%end if%>


<!-- #include file="FCKeditor/fckeditor.asp" -->


<%

'dbPath = Server.MapPath("bd/bd_rs.mdb")

'Set Conn = Server.CreateObject("ADODB.Connection")

'Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  '& " DBQ=" & dbPath


'strTekst = Request.Form("FCKeditor1")
'strTekst = Replace(strTekst, "'", "''")


'rsPost = "INSERT INTO t_actualites (auteur, [date], titre, article, pieces_jointes, visible_sur_site) values ('" & session("auteur") & "', '" & session("date") & "', '" & session("titre") & "', '" & session("FCKeditor1") & "', '" & session("filename") & "', '" & "non" & "' )"
    
'Conn.Execute(rsPost)
'Conn.close 
        'Set Conn=nothing

'Response.Write("Nouvel article ajouté")
%>


<%

    espace="&#034;"
    simplecot="&#039;"




dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
  
  



   
   

rsPost = "UPDATE creation_site SET vu = '" & "oui" & "' WHERE num = " & session ("num") & ""






Conn.Execute(rsPost)
majDate()


%>





 
  <%

Conn.close 
        Set Conn=nothing
        

'Response.Redirect("newposteditDelete.asp")
%>




<%

response.redirect("p_admin_demande_site_validation.asp")
%>
</body>
</html>