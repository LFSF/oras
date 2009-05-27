
<!-- #include file="connexion.asp"-->


<%
rsPost ="UPDATE MEMBRE SET NEWS=0 WHERE MailMembre='" & request.form("mail") & "'"
Conn.Execute(rsPost)



Conn.close 
		Set Conn=nothing
		



response.write("L'adresse a bien ete retiree de notre liste ! Vous ne recevrez donc plus notre NewsLetter.")
%>

