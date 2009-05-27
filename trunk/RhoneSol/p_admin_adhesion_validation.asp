<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<!-- #include file="connexion.asp"-->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>


<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!--#include file ="menu_deroulant.txt" --></div>

<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Page Administration &nbsp;</b></font>
                          </a></td></tr></table> 
						  
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
		  
		    <table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr><td colspan="4"><b><font color="blue">Liste des adherents ayant confirmé leur adhesion par mail ETANT ADMINMEMBRE</font></b></td><td></td><td></td><td></td></tr>
			<tr><td colspan="4">&nbsp;</td><td></td><td></td><td></td></tr>
			
			
              <%
		  Dim Place0
		  Place0 = 0
		  Dim rsED0

		  
		  
		  
		  Set rsED0 = Conn.Execute("SELECT * FROM MEMBRE where AdhesionMembre = 'oui' ORDER BY DateMembre ASC ")
		  %>
              <%
		  While Not rsED0.EOF
		  
				  if(rsED0("AdminMembre")=1) then
				  
							  %>
								  <%
										If strBgcolor = "#F1F1F1" Then
											strBgcolor = "#FFFFFF"
										Else
											strBgcolor = "#F1F1F1"
										End If
										%>
							   <a href="p_admin_adhesion_display.asp?num=<%=rsED0("NumMembre")%>">
							   <tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
								  

								  <td width="15"> 
									  <% Place0 = Place0+1 %>
									  <b><%=Place0%></b>&nbsp;&nbsp;</td>
									<td width="150"><%=rsED0("DateMembre")%>&nbsp;</td>
									<td><%=rsED0("NomMembre")%>&nbsp;<%=rsED0("PrenomMembre")%>&nbsp;&nbsp;</td>
									 <td><%=rsED0("OrganismeMembre")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td width="20"><a href="p_admin_adhesion_display.asp?num=<%=rsED0("NumMembre")%>"><img src="img/postdisplay.gif" border="0"></a></td>
									<!--<td width="20"><a href="p_admin_adhesion_validbis.asp?num=<%=rsED0("NumMembre")%>"><img src="postvalid.gif" border="0"></a></td>-->
									
									<td width="20"><a href="p_admin_adhesion_deletebis.asp?num=<%=rsED0("NumMembre")%>"><img src="img/postdelete.gif" border="0"></a></td>
								  </tr>
								  </a>
								  
								  
								  <%
								  
					end if			  
			rsED0.MoveNext
		
			
			Wend
			rsED0.Close 
			Set rsED0 = Nothing
			%>
            </table>
			
			</td>
        </tr>
      </table>
		  
		  </br>  
		  
		  </br>
		  
		  
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr><td colspan="4"><b><font color="green">Liste des adherents ayant confirmé leur adhesion par mail NON ADMINMEMBRE</font></b></td><td></td><td></td><td></td></tr>
			<tr><td colspan="4">&nbsp;</td><td></td><td></td><td></td></tr>
			
			
              <%
		  Dim Place
		  Place = 0
		  Dim rsED

		  
		  
		  
		  Set rsED = Conn.Execute("SELECT * FROM MEMBRE where AdhesionMembre = 'oui' ORDER BY DateMembre ASC ")
		  %>
              <%
		  While Not rsED.EOF
		  
				  if(rsED("AdminMembre")=0) then
				  
							  %>
								  <%
										If strBgcolor = "#F1F1F1" Then
											strBgcolor = "#FFFFFF"
										Else
											strBgcolor = "#F1F1F1"
										End If
										%>
							   <a href="p_admin_adhesion_display.asp?num=<%=rsED("NumMembre")%>">
							   <tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
								  

								  <td width="15"> 
									  <% Place = Place+1 %>
									  <b><%=Place%></b>&nbsp;&nbsp;</td>
									<td width="150"><%=rsED("DateMembre")%>&nbsp;</td>
									<td><%=rsED("NomMembre")%>&nbsp;<%=rsED("PrenomMembre")%>&nbsp;&nbsp;</td>
									 <td><%=rsED("OrganismeMembre")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
									<td width="20"><a href="p_admin_adhesion_display.asp?num=<%=rsED("NumMembre")%>"><img src="img/postdisplay.gif" border="0"></a></td>
									<!--<td width="20"><a href="p_admin_adhesion_validbis.asp?num=<%=rsED("NumMembre")%>"><img src="postvalid.gif" border="0"></a></td>-->
									
									<td width="20"><a href="p_admin_adhesion_deletebis.asp?num=<%=rsED("NumMembre")%>"><img src="img/postdelete.gif" border="0"></a></td>
								  </tr>
								  </a>
								  
								  
								  <%
								  
					end if			  
			rsED.MoveNext
		
			
			Wend
			rsED.Close 
			Set rsED = Nothing
			%>
            </table>
			
			</td>
        </tr>
      </table>
	  
	  </br>
	    </br>
	  					  
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr><td colspan="4"><b><font color="red">Liste des adherents n'ayant pas confirmé leur adhesion par mail</font></b></td><td></td><td></td><td></td></tr>
			<tr><td colspan="4">&nbsp;</td><td></td><td></td><td></td></tr>
			
			
              <%
		  Dim Place1
		  Place1 = 0
		  Dim rsED1

		  
		  
		  
		  Set rsED1 = Conn.Execute("SELECT * FROM MEMBRE where AdhesionMembre = 'non' ORDER BY DateMembre ASC ")
		  %>
              <%
		  While Not rsED1.EOF
		  %>
              <%
					If strBgcolor1 = "#F1F1F1" Then
						strBgcolor1 = "#FFFFFF"
					Else
						strBgcolor1 = "#F1F1F1"
					End If
					%>
           <a href="p_admin_adhesion_displayw²?num=<%=rsED1("NumMembre")%>">
		   <tr bgcolor="<%=strBgcolor1%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
              

			  <td width="15"> 
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsED1("DateMembre")%>&nbsp;</td>
                <td><%=rsED1("NomMembre")%>&nbsp;<%=rsED1("PrenomMembre")%>&nbsp;&nbsp;</td>
				 <td><%=rsED1("OrganismeMembre")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td width="20"><a href="p_admin_adhesion_display.asp?num=<%=rsED1("NumMembre")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                <!--<td width="20"><a href="p_admin_adhesion_validbis.asp?num=<%=rsED1("NumMembre")%>"><img src="postvalid.gif" border="0"></a></td>-->
				
				<td width="20"><a href="p_admin_adhesion_deletebis.asp?num=<%=rsED1("NumMembre")%>"><img src="img/postdelete.gif" border="0"></a></td>
              </tr>
			  </a>
			  
			  
              <%
			rsED1.MoveNext
			Wend
			rsED1.Close 
			Set rsED1 = Nothing
			%>
            </table>
			
			</td>
        </tr>
      </table>
	  
 <!--fin corps de texte-->
		
		<!--fin insertion -->
 
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>