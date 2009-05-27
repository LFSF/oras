<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->
<%

Dim sql,val,i,j,resp
tab=array("ActuVisu","ItwVisu","OffVisu","CvVisu","IdVisu")





	'Update the record in the recordset
	for i=0 to Request.Form("NbMembre")-1
		val=""		
		for j=0 to Ubound(tab)-1
			resp="0"
				
			if Request.Form(tab(j)&i)<>"" then
				resp="1"
			end if
			
			val=val&tab(j)&"= "&resp&", "
			
			
		Next
		resp="0"
				
		if Request.Form(tab(Ubound(tab))&i)<>"" then
			resp="1"
		end if
		
		
		sql="UPDATE ADMIN SET "&val&tab(Ubound(tab))&"= "&resp&" WHERE  NumMembre = " & Request.form("NumMembre"&i)
		
		Conn.execute(sql)
	Next
		
'Return to the update select page in case another record needs deleting
Response.Redirect "gesadmin.asp?msg=1"

%>
<!-- #include file="deconnexion.asp"-->