<%@Language="VBscript"%>


<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->


<%
'effacer les infos annonces
rsDeleteAnnonce="DELETE * FROM ANNONCES WHERE NumCV = " & Request.QueryString("num") & ""
Conn.Execute(rsDeleteAnnonce)
'puis les infos cv
rsDeleteCV = "DELETE * FROM CV WHERE NumCV = " & Request.QueryString("num") & ""
Conn.Execute(rsDeleteCV)
majDate()
%>

<!-- #include file="deconnexion.asp"-->

<%Response.Redirect("p_admin_cv_validation.asp")%>