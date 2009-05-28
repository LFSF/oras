<%@LANGUAGE="VBSCRIPT"%>
<% if not (session("admin_acces_admin")=1 or session("acces_actu")= 1) then
	response.redirect("p_admin.asp")
	else
%>
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

<% if (session("admin_acces_admin")=1 ) then %> 
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
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
        
        <A class=lien href="p_admin_actu.asp"><font size=1><b>
                         << Retour Menu Article &nbsp;</b></font>
 </a></td></tr></table>



<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
<%
	session("actu_del") = "v"
    Dim Place
    Place = 0
    Set rsED = Conn.Execute("SELECT * FROM ACTUALITE where Visible=1 ORDER BY DateActu DESC")

    IF rsED.EOF Then
    Response.Write("Il n'y a aucune actualité pour le moment ")
    Else
    While Not rsED.EOF

    If strBgcolor = "#F1F1F1" Then
    strBgcolor = "#FFFFFF"
    Else
    strBgcolor = "#F1F1F1"
    End If
%>
           <a href="p_admin_actu_modif_display.asp?num=<%=rsED("NumActu")%>"><tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsED("DateActu")%>&nbsp;</td>
                <td><%=rsED("TitreActu")%></a>&nbsp;&nbsp;</td>
                 <td> (<%=rsED("NumMembre")%>)</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td width="20"><a href="p_admin_actu_modif_display.asp?num=<%=rsED("NumActu")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                
                <!--<'% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
                <td width="20"><a href="p_admin_actu_modif_valid.asp?num=<'%=rsED("NumActu")%>"><img src="img/postvalid.gif" border="0"></a></td>
                <'%end if%>
                <td width="20"><a href="p_admin_actu_modif_edit.asp?num=<'%=rsED("NumActu")%>"><img src="img/postedit.gif" border="0"></a></td>--->
                
                <% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
                <td width="20"><a href="p_admin_actu_modif_delete.asp?num=<%=rsED("NumActu")%>"><img src="img/postdelete.gif" border="0"></a></td>
                <%end if%>
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
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
        
        <A class=lien href="p_admin_actu.asp"><font size=1><b>
                         << Retour Menu Article &nbsp;</b></font>
 </a></td></tr></table>



<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
<%
    Place = 0
    Set rsED = Conn.Execute("SELECT * FROM ACTUALITE where Visible=1 AND NumMembre=" & session("admin_id") & " ORDER BY DateActu DESC")

    IF rsED.EOF Then
    Response.Write("Il n'y a aucune actualité pour le moment ")
    Else
    While Not rsED.EOF

    If strBgcolor = "#F1F1F1" Then
    strBgcolor = "#FFFFFF"
    Else
    strBgcolor = "#F1F1F1"
    End If
%>
           <a href="p_admin_actu_modif_display.asp?num=<%=rsED("NumActu")%>"><tr bgcolor="<%=strBgcolor%>"onmouseover="this.style.color='orange'; this.style.cursor='hand';"  onmouseout="this.style.color='black';"> 
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsED("DateActu")%>&nbsp;</td>
                <td><%=rsED("TitreActu")%></a>&nbsp;&nbsp;</td>
                 <td> (<%=rsED("NumMembre")%>)</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td width="20"><a href="p_admin_actu_modif_display.asp?num=<%=rsED("NumActu")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                <% if (session("admin_acces_admin")=1 or session("admin_validation_actualites")=1) then %>
                <td width="20"><a href="p_admin_actu_modif_delete.asp?num=<%=rsED("NumActu")%>"><img src="img/postdelete.gif" border="0"></a></td>
                <%end if%>
              </tr></a>
              
              
              <%
            rsED.MoveNext
            Wend
            rsED.Close
            End If
            %>
            </table></td>
        </tr>
      </table>

<%End if%>
 <!--fin corps de texte-->
        

        <!--fin insertion-->

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

<%end if %>
