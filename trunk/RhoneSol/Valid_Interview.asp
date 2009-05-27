<!-- #include file="connexion.asp"-->

<%
'Validation de l'interview
	InfoDate= now
	'sqlQuestion="Delete * From QUESTION where NumItw =" & Request.Querystring("idint")
	'sqlInterview="Delete * From Interview where NumItw =" & Request.Querystring("idint")
	sqlInterviewOk="Update INTERVIEW set CodeValidItw =1, DateValidItw='"&now&"'  where NumItw =" & Request.Querystring("idint")
	
	
	Conn.Execute(sqlInterviewOk)
	'response.write (sqlInterviewOk)

%>	
	<!-- #include file="deconnexion.asp"-->
<%
	'REDIRECTION VERS UN EAUTRE  PAGE ASP
	session("redirection_db-multiple-file-to-disk.asp")="ok"
	session("variable_id_img")=mid(Request.Querystring("UrlImg"),1,4)
	response.redirect("p_admin_interview_visualisation.asp")
%>