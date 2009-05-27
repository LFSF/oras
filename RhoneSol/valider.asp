<html>
<head>

<title>Rhône-solidarité</title>

<body>

<%if request.form("profil")=1 then
response.redirect("pa_consulter_emploi_stage.asp")
%>
pas fait 1
<%end if%>

pas fait 2
<%if request.form("profil")=2 then
session("iTurl") = "p_proposer.asp"
response.redirect("p_proposer.asp")
end if%>

pas fait 3
<%if request.form("profil")=3 then
session("iTurl") = "p_deposer.asp"
response.redirect("p_deposer.asp")
end if%>


<%if request.form("profil")=4 then
response.redirect("pa_consulter_cv.asp")
%>
pas fait 4
<%end if%>

pas fait 5
<%if request.form("profil")=5 then
response.redirect("p_petite_annonce.asp")
end if%>

  
 </body>
</html>