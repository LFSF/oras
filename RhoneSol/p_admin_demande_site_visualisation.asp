<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rh�ne-solidarit�</title>

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
    	<td colspan="2"><font color="#6faa06">Menu des demandes de site _______________________________________________________________</font></td>
    </tr>

				<tr>
				<td width=82%>
	  
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A class=lien href="p_admin_demandes_site.asp"><font size=1><b>
                         << Retour Menu des demandes de site&nbsp;</b></font>
                          </a></td></tr></table>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%
			  
			  
		  Dim Place
		  Place = 0
		  Dim rsED
		  Set rsED = Conn.Execute("SELECT * FROM CREATION WHERE Validation =1")
		  %>
          <%
		  IF rsED.EOF Then
		  Response.Write("Il n'y a aucune demande pour le moment ")
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
              <a href="p_admin_demande_site_displaybis.asp?NumCrea=<%=rsED("NumCrea")%>"><tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b></td>
                <td><%=rsED("NomCrea")%>&nbsp;&nbsp;<%=rsED("PrenomCrea")%></td>
				<td><%=rsED("ProjetCrea")%></td>
				<td width="20"><a href="p_admin_demande_site_displaybis.asp?NumCrea=<%=rsED("NumCrea")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                <!---<td width="20"><a href="p_admin_idees_valid.asp?NumCrea=<'%=rsED("NumCrea")%>"><img src="postvalid.gif" border="0"></a></td>--->
                 <td width="20"><a href="p_admin_demande_site_delete.asp?NumCrea=<%=rsED("NumCrea")%>"><img src="img/postdelete.gif" border="0"></a></td> 
                
              </tr></a>
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
  
  
 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br> <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

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
<!-- Ne pas toucher � ce qui suit : placement du footer -->

  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>