<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="connexion.asp"-->
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<SCRIPT LANGUAGE="JavaScript">
function fonc1()
{
window.location.href='p_infos_historique.asp'
}
function fonc2()
{
window.location.href='p_infos_definition.asp'
}
function fonc3()
{
window.location.href='p_infos_cadre.asp'
}
function fonc4()
{
window.location.href='p_infos_financements.asp'
}
</SCRIPT>


<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">CONSULTATION CV</div>


<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">CV Emplois____________________________________________________________________</font></td>
    </tr>
	
	</table>
	
  
	
	<!--       INSERTION -->
	
							  
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
					<td>
          
	
				  <table width="100%" border="0" cellspacing="0" cellpadding="2">
				  
				  <tr>
    	<th>N°</th>
   
    	<th>Date</th>
   
    	<th>Intitulé</th>
    	<th>Lieu du poste</th>
   
    	<th>Durée espérée</th>
    
    	<th>Disponibile à partir du</th>
    </tr>
	
				  
              <%
		  Dim Place
		  Place = 0
		  Dim rsED1

	

		  
		  
		  Set rsED1 = Conn.Execute("SELECT * FROM ANNONCES WHERE ProfilAnn=2 ORDER BY DateAnn DESC")
		 


	
		
					
		
	

		 
		  While Not rsED1.EOF
		  
		  If strBgcolor = "#F1F1F1" Then
		  strBgcolor = "#FFFFFF"
		Else
		strBgcolor = "#F1F1F1"
		End If
					%>
					
              <tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';">

			  
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b>
				  
				  </td>
				      
                <td width="110"><%=mid(rsED1("DateAnn"),1,10)%>
				</td>
                <td><%=rsED1("IntituleAnn")%>
				</td>
				 <td><%=rsED1("LieuAnn")%>  <%session("recup_pieces_jointes")= rsED1("LieuAnn")%>
				 </td>
				 
				 
				 
              <td><%
				
    
	  
			  
			  
			  if rsED1("DureeEspereeAnn")="def" then
    response.write("C.D.I")
	else
	response.write(rsED1("DureeEspereeAnn"))
end if
  

%>

				</td>
				<td><%=rsED1("DispoJourAnn")%>&nbsp;<%=rsED1("DispoMoisAnn")%>&nbsp;<%=rsED1("DispoAnneeAnn")%>
				</td>
			  <td width="20"></td>
               
			   <td width="20"><a href="pa_consulter_cvbis.asp?num=<%=rsED1("NumAnn")%>">
			   <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr>

	 

	
	

	
	 
	 
	 
		
			 
			  
			  
              <%
			  
			  			  

 
			  
			rsED1.MoveNext
				
			Wend
			rsED1.Close 
			
			Set rsED1 = Nothing
			%>
			

			
            </table>
			<tr>
    	<td colspan="2"><font color="#6faa06">CV Stage____________________________________________________________________</font></td>
    </tr>
	
	</table>
	
  
	
	<!--       INSERTION -->
	
							  
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
					<td>
          
	
				  <table width="100%" border="0" cellspacing="0" cellpadding="2">
				  
				  <tr>
    	<th>N°</th>
   
    	<th>Date</th>
   
    	<th>Intitulé</th>
  
    	<th>Lieu du poste</th>
   
    	<th>Durée espérée</th>
    
    	<th>Disponibile à partir du</th>
    </tr>
				  
				  
              <%
		  Dim Place1
		  Place1 = 0
		  Dim rsED2

		  Set rsED2 = Conn.Execute("SELECT * FROM ANNONCES where ProfilAnn=2 ORDER BY DateAnn DESC")
 
		  While Not rsED2.EOF
		  If strBgcolor = "#F1F1F1" Then
		  strBgcolor = "#FFFFFF"
		Else
		strBgcolor = "#F1F1F1"
		End If
					%>
					
              <tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b> 
				  </td>
				  
				  			<%
Session.LCID = 1036
%>	
    
				  
                <td width="110"><%=mid(rsED2("DateAnn"),1,10)%>
				</td>
                <td><%=rsED2("IntituleAnn")%>
				</td>
				 <td><%=rsED2("LieuAnn")%>  <%session("recup_pieces_jointes")= rsED2("LieuAnn")%>
				 </td>
              <td><%	  if rsED2("DureeEspereeAnn")="def" then
       response.write("C.D.I")
	   else
	   response.write(rsED2("DureeEspereeAnn"))
end if

	%>
				</td>
				<td><%=rsED2("DispoJourAnn")%>&nbsp;<%=rsED2("DispoMoisAnn")%>&nbsp;<%=rsED2("DispoAnneeAnn")%>
				</td>
			  <td width="20"></td>
               
			   <td width="20"><a href="pa_consulter_cvbis.asp?num=<%=rsED2("NumAnn")%>">
			   <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr>
			
			 

			  
              <%
			  
		
			  
			rsED2.MoveNext
			Wend
			rsED2.Close 
			
			Set rsED2 = Nothing
			%>
			

    	
            </table>
			<tr>
    	<td colspan="2"><font color="#6faa06">CV Autre____________________________________________________________________</font></td>
    </tr>
	
	</table>
	
  
	
	<!--       INSERTION -->
	
							  
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
					<td>
          
	
				  <table width="100%" border="0" cellspacing="0" cellpadding="2">
				  
				  <tr>
    	<th>N°</th>
   
    	<th>Date</th></td>
   
    	<th>Intitulé</th></td>
  
    	<th>Lieu du poste</th></td>
   
    	<th>Durée espérée</th></td>
    
    	<th>Disponibile à partir du</th>
    </tr>
			  
              <%
		  Dim Place2
		  Place2 = 0
		  Dim rsED3
		  

		  

		  Set rsED3 = Conn.Execute("SELECT * FROM ANNONCES where ProfilAnn=3  ORDER BY DateAnn DESC")
	
		  While Not rsED3.EOF
		  If strBgcolor = "#F1F1F1" Then
		  strBgcolor = "#FFFFFF"
		Else
		strBgcolor = "#F1F1F1"
		End If
					%>
					
              <tr bgcolor="<%=strBgcolor%>" onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place2 = Place2+1 %>
                  <b><%=Place2%></b>
  
				  </td>
                <td width="110"><%=mid(rsED3("DateAnn"),1,10)%>
				</td>
                <td><%=rsED3("IntituleAnn")%>
				</td>
				 <td><%=rsED3("LieuAnn")%>  <%session("recup_pieces_jointes")= rsED3("LieuAnn")%>
				 </td>
				 <td><%if rsED3("DureeEspereeAnn")="Def" then
   response.write("C.D.I")
   else
   response.write(rsED3("DureeEspereeAnn"))
end if
%>
				</td>
				<td><%=rsED3("DispoJourAnn")%>&nbsp;<%=rsED3("DispoMoisAnn")%>&nbsp;<%=rsED3("DispoAnneeAnn")%>
				</td>
				
              
			  <td width="20"></td>
               
			   <td width="20"><a href="pa_consulter_cvbis.asp?num=<%=rsED3("NumAnn")%>">
			   <img src="img/divers/feuille.jpg" border="0"></a></td>
              </tr>
			
			
			  
			  
              <%
			  
		  
			  
			rsED3.MoveNext
			Wend
			rsED3.Close 
			
			Set rsED3 = Nothing
			%>
			
			
        </table>
                     
                       
					
					</td>
			</tr>
	</table>
		
		
		
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
<!-- #include file="deconnexion.asp"-->
</html>