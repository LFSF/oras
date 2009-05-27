<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
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
        <td colspan="2"><font color="#6faa06">Menu Idées / Suggestions _______________________________________________________________</font></td>
    </tr>
    

                <tr>
                <td width=82%>
                     
      
      
      <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        <A class=lien href="p_admin_idees.asp"><font size=1><b>
                         << Retour Menu Idées &nbsp;</b></font>
                          </a></td></tr></table>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%

              
          Dim Place
          Place = 0
          Dim rsED
          Set rsED = Conn.Execute("SELECT * FROM IDEES where visible=1 ORDER BY DateIdee DESC")
          %>
          <%
          IF rsED.EOF Then
          Response.Write("Il n'y a aucune idée / suggestion pour le moment ")
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
              <a href="p_admin_idees_display.asp?num=<%=rsED("NumIdee")%>"><tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b></td>
                <td width="150"><%=rsED("DateIdee")%></td>
                <td><%=rsED("MessageIdee")%></td>
                <%
                'Set rsED2 = Conn.Execute("SELECT * FROM MEMBRE where NumMembre= " & rsED("NumMembre") & "")
                %>
                
                <td><%=rsED("Nom")%>&nbsp;&nbsp;<%=rsED("Prenom")%></td>
                <td><%=rsED("Association")%></td>
                <td width="20"><a href="p_admin_idees_display.asp?num=<%=rsED("NumIdee")%>"><img src="img/postdisplay.gif" border="0"></td></a>
                <!---<td width="20"><a href="p_admin_idees_valid.asp?num=<'%=rsED("num")%>"><img src="postvalid.gif" border="0"></a></td>--->
                 <td width="20"><a href="p_admin_idees_delete.asp?num=<%=rsED("NumIdee")%>"><img src="img/postdelete.gif" border="0"></a></td> 
                
              </tr></a>
              <%
            rsED.MoveNext
            Wend
            rsED.Close 
            Set rsED = Nothing
            'rsED2.Close 
            'Set rsED2 = Nothing
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

 



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->
<!-- #include file="deconnexion.asp"-->  
</div>

</body>
</html>