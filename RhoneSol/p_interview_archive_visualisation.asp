<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="connexion.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title><% =Server.HtmlEncode("Rhône-solidarité")%></title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>


<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<table border="0px" width="100%" cellpadding="10px">
    
    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Espace Archives Interviews_______________________________________________________________</font></td>
    </tr>
                <tr>
                <td width=82%>
                     
      
      
      <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        </td></tr></table> 
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%
          Dim Place
          Place = 0
          Dim rsED
          
          Set rsED = Conn.Execute("SELECT * FROM INTERVIEW WHERE DatePublicationItw<#"&date&"# ORDER BY NumItw ASC")
          %>
              <%
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
                <td width="150"><%=rsED("DateItw")%></td>
                <td><%=Server.HtmlEncode(rsED("RaiSocEnt"))%></a></td>
                
                
                <td width="20"><a href="p_interview_archive.asp?idint=<%=rsED("NumItw")%>"><img src="img/postdisplay.gif" border="0"></a></td>
              </tr>
              
              <!-----------------Initialisation de la session-------------->
              
        
              <!-----------------Fin initialisation de la session----------------------->
              
              
              <%
            rsED.MoveNext
            Wend
            rsED.Close 
            Set rsED = Nothing
            %>
            </table></td>
        </tr>
      </table>
  <!--fin corps de texte-->
        
        
        
        <!--           fin insertion  -->
        


 
<br />
<br />
<br />
<br />
<br />
<br />
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>