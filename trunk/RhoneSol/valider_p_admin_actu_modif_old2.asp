
<!-- #include file="admin_securite.asp"-->
<html>
<head>
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
<link href="styles.css" rel="stylesheet" type="text/css" />
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
	espace="&#034;"
	simplecot="&#039;"
  
 if session("nameOfFile")<>"" then

'rsPost = "UPDATE ACTUALITE SET DateActu = '" & replace(REPLACE(session("date"),"""",espace),"'",simplecot) & "', TitreActu = '" & replace(REPLACE(session("titre"),"""",espace),"'",simplecot) & "', ArticleActu = '" & replace(REPLACE(session("MessageActu"),"""",espace),"'",simplecot) & "', PieceJointesActu = '" & replace(REPLACE(session("filename"),"""",espace),"'",simplecot) & "', Visible = 0 WHERE NumArticle = " & session("num")

rsPost = "UPDATE ACTUALITE SET DateActu = '" & replace(REPLACE(session("date"),"""",espace),"'",simplecot) & "', TitreActu = '" & replace(REPLACE(session("titre"),"""",espace),"'",simplecot) & "', ArticleActu = '" & replace(REPLACE(session("MessageActu"),"""",espace),"'",simplecot) & "', PieceJointesActu = '" & replace(REPLACE(session("filename"),"""",espace),"'",simplecot) & "', WHERE NumArticle = " & session("num")


else

'rsPost = "UPDATE ACTUALITE SET DateActu = '" & replace(REPLACE(session("date"),"""",espace),"'",simplecot) & "', TitreActu = '" & replace(REPLACE(session("titre"),"""",espace),"'",simplecot) & "', ArticleActu = '" & replace(REPLACE(session("MessageActu"),"""",espace),"'",simplecot) & "', Visible = 0 WHERE NumArticle = " & session("num")


rsPost = "UPDATE ACTUALITE SET DateActu = '" & replace(REPLACE(session("date"),"""",espace),"'",simplecot) & "', TitreActu = '" & replace(REPLACE(session("titre"),"""",espace),"'",simplecot) & "', ArticleActu = '" & replace(REPLACE(session("MessageActu"),"""",espace),"'",simplecot) & "', Visible = 0 WHERE NumArticle = " & session("num")

end if

Conn.Execute(rsPost)

 set FSO = Server.CreateObject("Scripting.FileSystemObject") 

dir = Server.MapPath("/fichiers_upload/upload_actualites")

 set foldPt = FSO.GetFolder(dir) 

 set fc = foldPt.Files 
%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_actualites/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>




<%
mot_recherche=session("pieces_jointes")


leresultat =InStr(f.name, mot_recherche)
%>



<li>Mot recherché : <%=mot_recherche%>
<li>Resultat Instr : <%=leresultat%>





<%
if leresultat<>0 then
f.Delete
end if

Set FSO = nothing

next

response.redirect("valid_p_admin_actu_modif.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>