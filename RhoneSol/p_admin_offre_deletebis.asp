<%@Language="VBscript"%>


<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<%

  
 'Dim rsA
'Set rsA = Conn.Execute("SELECT * FROM T_proposer WHERE  num = " & session ("num") & "") 
'session("pieces_jointes")= rsA("filename")

Dim rsDelete
rsDelete = "DELETE * FROM OFFRES WHERE NumOff = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)
%>

 
  <%

Conn.close 
		Set Conn=nothing
		

'Response.Redirect("newposteditDelete.asp")
%>



<%Response.Redirect("p_admin_offre_validation.asp")%>
<!-- #include file="deconnexion.asp"-->