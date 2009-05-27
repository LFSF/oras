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

<%
  	espace="&#034;"
	simplecot="&#039;"
               
 
     
dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath


SQL="SELECT * FROM [t_petite_annonce]"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********
 
 '--code de la structure----------------------
 RS("civilite")=replace(REPLACE(session("civilite"),"""",espace),"'",simplecot)
 RS("nom")=replace(REPLACE(session("nom"),"""",espace),"'",simplecot)
 RS("prenom")=replace(REPLACE(session("prenom"),"""",espace),"'",simplecot)
 RS("adresse")=replace(REPLACE(session("adresse"),"""",espace),"'",simplecot)
 RS("cp")=replace(REPLACE(session("cp"),"""",espace),"'",simplecot)
 RS("ville")=replace(REPLACE(session("ville"),"""",espace),"'",simplecot)
 RS("email")=replace(REPLACE(session("email"),"""",espace),"'",simplecot)
 RS("verif_email")=replace(REPLACE(session("verif_email"),"""",espace),"'",simplecot)
 RS("tel")=replace(REPLACE(session("tel"),"""",espace),"'",simplecot)
 RS("sujet")=replace(REPLACE(session("sujet"),"""",espace),"'",simplecot)
 RS("creer_pass")=replace(REPLACE(session("creer_pass"),"""",espace),"'",simplecot)
 RS("verif_pass")=replace(REPLACE(session("verif_pass"),"""",espace),"'",simplecot)
 RS("validite_annonce")=replace(REPLACE(session("validite_annonce"),"""",espace),"'",simplecot)
 RS("rubrique")=replace(REPLACE(session("rubrique"),"""",espace),"'",simplecot)
 RS("votre_annonce")=replace(REPLACE(session("votre_annonce"),"""",espace),"'",simplecot)
 RS("checbox")=replace(REPLACE(session("checbox"),"""",espace),"'",simplecot)
 RS("date_inscription")=replace(REPLACE(date,"""",espace),"'",simplecot)

 RS.update
rs.Close
set rs = Nothing
conn.Close
set conn= Nothing

Response.Redirect("valid_petite_annonce.asp")
%>
</body>
</html>