<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	%><!-- #include file="deconnexion.asp"--><%
	response.redirect("p_admin.asp")
	else
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
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
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
    
    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
                <tr>
                <td width=82%>
                     
      
      
      <div align="justify">
<% if (session("admin_acces_admin")= 1 ) then 
        
%> 

        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        <A class=lien href="p_admin_interview.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table> 
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%
          Dim Place
          Place = 0
          Dim rsED
          Set rsED = Conn.Execute("SELECT * FROM INTERVIEW ORDER BY NumItw ASC")          
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
                <td><%=rsED("RaiSocEnt")%></a></td>
                
                
                <td width="20"><a href="p_admin_interview_modif_ajout_images_upload.asp?idint=<%=rsED("NumItw")%>"><img src="img racine/postedit.gif" border="0"></a></td>
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

<%
else
%>

        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        <A class=lien href="p_admin_interview.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table> 
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
              <%
          Dim Place1
          Place1 = 0
          Dim rsED1
           Set rsED1 = Conn.Execute("SELECT * FROM INTERVIEW where NumMembre="&session("admin_id")&" ORDER BY NumItw ASC")        
          %>
              <%
          While Not rsED1.EOF
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
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b></td>
                <td width="150"><%=rsED1("DateItw")%></td>
                <td><%=rsED1("RaiSocEnt")%></a></td>
                
                
                <td width="20"><a href="p_admin_interview_modif_ajout_images_upload.asp?idint=<%=rsED1("NumItw")%>"><img src="img racine/postedit.gif" border="0"></a></td>
              </tr>
              
              <!-----------------Initialisation de la session-------------->
              
        
              <!-----------------Fin initialisation de la session----------------------->
              
              
              <%
            rsED1.MoveNext
            Wend
            rsED1.Close 
            Set rsED1 = Nothing
            %>
            </table></td>
        </tr>
      </table>
  <!--fin corps de texte-->

<!-- #include file="deconnexion.asp"-->
<%end if%>
        
        
        
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
</body>
<!-- #include file="deconnexion.asp"-->
</html>
<% end if %>