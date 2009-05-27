<%@LANGUAGE="VBSCRIPT"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">




<%
Dim rsWeblog
Dim rsComments
'Dim rsCat
%>

<%
			
				  dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
			
			
			
			%>

			<%
			set rsWeblog = Conn.execute("SELECT * FROM weblog WHERE id = "& Request.QueryString("id") &"")
			%>
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">Idées Suggestions</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Idées Suggestions____________________________________________________________________________________</font></td>
</tr>
</table>
		
	
			<div id="body">
			
			<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
					<td>
          
	
				  <table width="100%" border="0" cellspacing="0" cellpadding="2">

					<%
					'Set rsCat = ObjConn.Execute("SELECT * FROM category WHERE cat_id = " & rsWeblog("cat_id") & "")
					%>
			
				
					<h2>&nbsp;<!-- BlogbotTitleStart --><%=rsWeblog("headline")%><!-- BlogbotTitleEnd --></h2>
					<div class="date"><!-- BlogbotDateStart --><%=mid(rsWeblog("date"),1,10)%><!-- BlogbotDateEnd --> </div><br>
					<p>
						<!-- BlogbotContentStart --><%=rsWeblog("weblog")%><!-- BlogbotContentEnd -->
					</p>
					
					<br>
				
			<%
			rsWeblog.Close 
			Set rsWeblog = Nothing
			%>
			
			<%
			Set rsComments = Conn.Execute("SELECT * FROM comments WHERE blogID = "& Request.QueryString("id") &" ORDER BY date")
			While not rsComments.EOF
			%>
					<br>
					<p class="left" style="BACKGROUND-COLOR: #CCCCCC">
						<img src="commentaires.gif">&nbsp;<%=mid(rsComments("date"),1,10)%>
					</p>
					<p>
						<%=Server.HTMLencode(rsComments("comment"))%>
					</p><br>
					<p class="comment_name">
					<img src="user.gif">&nbsp;<%=posted_by%>&nbsp;<a href="<%=rsComments("url")%>" target="_blank"><%=Server.HTMLencode(rsComments("name"))%></a>
					</p>
			<%
			rsComments.Movenext
			Wend
			%>
			<br><br>
			<p class="left" style="BACKGROUND-COLOR: #CCCCCC">Ajouter vos commentaires à ce post</p><br>
			<p><!-- #include file="p_suggestion_comment_form.asp" --></p>	
		
				
			</div>
				</table>
			<br />
<br />
	
<!--           fin insertion  -->
		


 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>

