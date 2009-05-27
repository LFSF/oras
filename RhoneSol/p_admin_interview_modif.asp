<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <!-- #include file="grand_meta.txt"-->
    <!-- #include file="connexion.asp"-->
    <title>Rhône-solidarité</title>
    <link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<% if (session("admin_acces_admin")= 1 ) then 
        
        'Set rsED = Conn.Execute("SELECT * FROM INTERVIEW where CodeValidItw=0 ORDER BY NumItw ASC")
        
            Set rsED = Conn.Execute("SELECT * FROM INTERVIEW  ORDER BY CodeValidItw and NumItw ASC")
    
%> 
<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->




<div id="bandeau_vert">Espace Membres</div><div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
    <tr>
        <td width=82%>
            <div align="justify">
            
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        <A class=lien href="p_admin_interview.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table>  
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
            

              <%
          While Not rsED.EOF
          %>
              <%
            
                if (rsED("CodeValidItw")=True) then
                valide="<font color='blue'>Itw validée</font>"
                else
                valide="<font color='red'>Itw non validée</font>"
                end if
              
              
                            If strBgcolor = "#F1F1F1" Then
                                strBgcolor = "#FFFFFF"
                            Else
                                strBgcolor = "#F1F1F1"
                            End If
                            %>
                    <tr bgcolor="<%=strBgcolor%>"> 
                        <td width="15"> 
                          <% Place = Place+1 %>
                          <b><%=Place%></b>&nbsp;</td>
                        <td width="150"><%=rsED("DateItw")%>&nbsp;</td>
                        
                            <td>N°&nbsp;<%=rsED("NumItw")%>&nbsp;</td>  
                        
                        <td><%=valide%>&nbsp;&nbsp;</td>
                        
                        <td><%=rsED("RaiSocEnt")%>&nbsp;&nbsp;</td>
                        <td><%=rsED("DescriptionItw")%></a>&nbsp;</td>
                        
                        
                        
                        
                    <!--<td></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>  -->
                    
                    
                        <td width="20"><a href="p_admin_interview_view_delete.asp?idint=<%=rsED("NumItw")%>"><img src="img/postdisplay.gif" border="0" alt="Voir l'interview"></a></td>
                        
                        <% if (session("admin_acces_admin")=1 or session("admin_validation_interview")="oui") then %>
                        <td width="20"><a href="p_admin_interview_modif_valid.asp?num=<%=rsED("NumItw")%>"><img src="img/postvalid.gif" border="0" alt="Valider l'interview"></a></td>
                        <%end if%>
                        
                        <td width="20"><a href="p_admin_interview_modif_edit.asp?num=<%=rsED("NumItw")%>"><img src="img/postedit.gif" border="0" alt="Editer l'interview"></a></td>
                        
                        <% if (session("admin_acces_admin")=1 or session("admin_validation_interview")="oui") then %>
                        <td width="20"><a href="InterviewDelete2.asp?idint=<%=rsED("NumItw")%>"><img src="img/postdelete.gif" border="0" alt="Supprimer l'interview"></a></td>
                        <%end if%>
                
                
                
                
            </tr></a>
            
              <%
            rsED.MoveNext
            
            
            
            
            
            
            
            
            
            
            
            Wend
            rsED.Close 
            Set rsED = Nothing
            %>
            </table></td>
        </tr>
      </table>

<%else%>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>


<table border="0px" width="100%" cellpadding="10px">
    
    
    
    <tr>
        <td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
                <tr>
                <td width=82%>
                     
      
      
      <div align="justify">
        
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
  
          'Set rsED1 = Conn.Execute("SELECT * FROM INTERVIEW where CodeValidItw=false and auteur='" & session("admin_nom")& chr(10)& session("admin_prenom") & "' ORDER BY date_interview DESC")
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
              <td width="20"><tr bgcolor="<%=strBgcolor%>"> 
                <td width="15"> 
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsED1("DateItw")%>&nbsp;</td>
                <td><%=rsED1("RaiSocEnt")%>&nbsp;&nbsp;</td>
                <td><%=rsED1("DescriptionItw")%></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <!--     <td></a>&nbsp;&nbsp;&nbsp;&nbsp;</td>  -->
            <td width="20"><a href="p_admin_interview_view_delete.asp?idint=<%=rsED1("NumItw")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                
                <% if (session("admin_acces_admin")=1 or session("admin_validation_interview")="oui") then %>
                <td width="20"><a href="p_admin_interview_modif_valid.asp?num=<%=rsED1("NumItw")%>"><img src="img/postvalid.gif" border="0"></a></td>
                <%end if%>
                
                <td width="20"><a href="p_admin_interview_modif_edit.asp?num=<%=rsED1("NumItw")%>"><img src="img/postedit.gif" border="0"></a></td>
                
                <% if (session("admin_acces_admin")=1 or session("admin_validation_interview")="oui") then %>
                <td width="20"><a href="p_admin_interview_modif_delete.asp?num=<%=rsED1("NumItw")%>"><img src="img/postdelete.gif" border="0"></a></td>
                <%end if%>
              </tr></a>
              
              <!--Initialisation de la session--->
              
        
              <!--Fin initialisation de la session--->
              
              
              <%
            rsED1.MoveNext
            Wend
            rsED1.Close 
            Set rsED1 = Nothing
            %>
            </table></td>
        </tr>
      </table>

<%end if%>
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

</body>
</html>
<% end if %>