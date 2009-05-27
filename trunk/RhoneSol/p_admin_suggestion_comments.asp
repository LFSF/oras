<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>




<link href="styles.css" rel="stylesheet" type="text/css" />

</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Menu Article_______________________________________________________________</font></td>
    </tr>
	

				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Page Administration &nbsp;</b></font>
                          </a></td></tr></table>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%
			  				  dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
			  
			  
		  Dim Place
		  Place = 0
		  Dim rsED
		  Set rsED = Conn.Execute("SELECT * FROM comments ORDER BY date")
		  %>
          <%
		  IF rsED.EOF Then
		  Response.Write("There are no comments yet")
		  Else
		  While Not rsED.EOF
		  %>
		  
              <%
					If strBgcolor = "#F1F1F1" Then
						strBgcolor = "#FFFFFF"
					Else
						strBgcolor = "#F1F1F1"
					End If
					%>
              <tr bgcolor="<%=strBgcolor%>"> 
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b></td>
                <td width="150"><%=rsED("date")%></td>
                <td><%=rsED("name")%></a></td>
                <td width="20"><a href="deleteComment.asp?id=<%=rsED("id")%>"><img src="postdelete.gif" border="0"></a></td> 
                <!--<td width="20"><a href="editComment.asp?id=<%=rsED("id")%>"><img src="postedit.gif" border="0"></a></td>-->
              </tr>
              <%
			rsED.MoveNext
			Wend
			rsED.Close 
			Set rsED = Nothing
			End If
			%>
            </table></td>
        </tr>
      </table></td>
  </tr>
  
  
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

  <!------ fin corps de texte-------------------->
		
		
		
		<!-------------------------------------------FIN AJOUT DE TEXTE IMPORTE DE ORAS----------------------------------->
       
                        
                   
                         
                          
                        
                     
                      
                   <DIV class=txt align="justify">&nbsp;</DIV>
                       
                    
						<!------ fin corps de texte-------------------->
					</td>
					</tr>
					</table>


  </center>
    
	</td></tr>

</table>

 



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>