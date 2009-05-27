
<html>
<head>
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
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

<%
espace="&#034;"
simplecot="&#039;"
'********Infos Interview*********
rsPost = "UPDATE INTERVIEW SET DateItw = '" & replace(REPLACE(session("date_interview"),"""",espace),"'",simplecot)& "', StatutEnt = '" & replace(REPLACE(session("statut"),"""",espace),"'",simplecot) & "', RaiSocEnt = '" & replace(REPLACE(session("rs"),"""",espace),"'",simplecot) & "', AdrEnt = '" & replace(REPLACE(session("adresse"),"""",espace),"'",simplecot) & "', CodeValidItw = 0 WHERE NumItw = " & session("num") & ""

rsPost1 = "UPDATE INTERVIEW SET CPEnt = '" & replace(REPLACE(session("cp"),"""",espace),"'",simplecot)& "', VilleEnt = '" & replace(REPLACE(session("ville"),"""",espace),"'",simplecot) & "', PaysEnt = '" & replace(REPLACE(session("pays"),"""",espace),"'",simplecot) & "', CiviliteRespEnt = '" & replace(REPLACE(session("civilite"),"""",espace),"'",simplecot) & "', NomRespEnt = '" & replace(REPLACE(session("nom_responsable"),"""",espace),"'",simplecot) & "', PrenomRespEnt = '" & replace(REPLACE(session("prenom_responsable"),"""",espace),"'",simplecot) & "' WHERE NumItw = " & session("num") & ""

rsPost2 = "UPDATE INTERVIEW SET MailRespEnt = '" & replace(REPLACE(session("email"),"""",espace),"'",simplecot)& "', TelRespEnt = '" & replace(REPLACE( session("tel"),"""",espace),"'",simplecot) & "', DescriptionItw = '" & replace(REPLACE( session("titre_interview"),"""",espace),"'",simplecot) & "', IntroItw = '" & replace(REPLACE( session("intro_interview"),"""",espace),"'",simplecot) & "' WHERE NumItw = " & session("num") & ""
'********Infos Interview*********
Conn.Execute(rsPost)
Conn.Execute(rsPost1)
Conn.Execute(rsPost2)



'**********Les Questions et réponses modification****************
set rsNumQuest=Conn.Execute("Select NumQuest FROM QUESTION where NumItw="&session("num")&" order by NumQuest")
i=1
while not rsNumQuest.EOF 
rsQuest= "UPDATE QUESTION SET Question = '" & replace(REPLACE(session("question"&i),"""",espace),"'",simplecot) & "' WHERE NumItw = " & session("num") & "AND NumQuest = " & rsNumQuest("NumQuest") & ""
rsRep= "UPDATE QUESTION SET Reponse = '" & replace(REPLACE(session("reponse"&i),"""",espace),"'",simplecot) & "' WHERE NumItw = " & session("num") & "AND NumQuest = " & rsNumQuest("NumQuest") & ""

Conn.Execute(rsQuest)
Conn.Execute(rsRep)
i=i+1
rsNumQuest.MoveNext
Wend
			rsNumQuest.Close 
			Set rsNumQuest = Nothing
			
			
'**********Les Questions et réponses ajout****************
while i < 21 

if session("question" & i & "")<> "" then
rsNewQuest="INSERT INTO QUESTION (Question,Reponse,NumItw) values ('"&session("question"&i)&"','"&session("reponse"&i)&"',"&session("num")&")"
i = i + 1
Conn.Execute(rsNewQuest)
else
response.redirect("valid_p_admin_interview_modif.asp")
end if
wend
set rsNewQuest = Nothing

%>

<%

response.redirect("valid_p_admin_interview_modif.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>