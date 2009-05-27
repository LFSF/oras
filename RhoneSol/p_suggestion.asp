<%@LANGUAGE="VBSCRIPT"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<%
Dim rsWeblog
Dim rsComments
Dim rsCat
'Dim rsCategory
%>


<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">Idées Suggestions</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Idées Suggestions_____________________________________________________________________________________</font></td>
</tr>
</table>
		
	
			<div id="body">
			
			<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
					<td>
          
	
				  <table width="100%" border="0" cellspacing="0" cellpadding="2">

			<%
			
				  dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
			
			
			
			set rsWeblog = Conn.execute("SELECT TOP 10 * FROM weblog ORDER BY date DESC")
			
			if rsWeblog.EOF Then
			Response.Write(""&emptyPosts&"")
			Else
			
			While NOT rsWeblog.EOF
			
			Set rsComments = Conn.Execute("SELECT Count(comments.blogID) AS antal FROM comments WHERE comments.blogID = " & rsWeblog("id") & ";")
			
			'Set rsCategory = Conn.Execute("SELECT * FROM category WHERE cat_id = " & rsWeblog("cat_id") & "")
			%>
			
				
		<i><h2>&nbsp;<!-- BlogbotTitleStart --><%=rsWeblog("headline")%><!-- BlogbotTitleEnd --></h2></i>
					<div class="date"><!-- BlogbotDateStart --><%=mid(rsWeblog("date"),1,10)%><!-- BlogbotDateEnd  - <a href="category.asp?cat_id=<'%=rsCategory("cat_id")%>"><'%=rsCategory("category")%></a>--></div><br>
					<!-- <p>
						<'%=rsWeblog("weblog")%> 
					</p>-->
					 <p class="right" style="BACKGROUND-COLOR: #CCCCCC">
						<img src="commentaires.gif">&nbsp;<a href="p_suggestion_comments.asp?id=<%=rsWeblog("id")%>" class="bar">commentaires <b>(<%=rsComments("antal")%>)</b></a>
					</p>
					<br>
				
			<%
			rsWeblog.MoveNext
			Wend
			rsWeblog.Close 
			Set rsWeblog = Nothing
			End If
			%>
				

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

<%
 Conn.close
%>