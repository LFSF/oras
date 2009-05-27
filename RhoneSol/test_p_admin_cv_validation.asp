<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="connexion.asp"-->
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
                <tr valign="top">
                    <td colspan="7"><b><font color="blue">Liste des CV non validés</font></b></td>
                </tr>
<%
Dim Place
Place = 0

Set rsED1 = Conn.Execute("SELECT * FROM CV WHERE Visible=0 ORDER BY DateCV")

if rsED1.EOF then
    Response.Write "<tr><td>Il n'y a pas de CV enregistré dans la base</td></tr>"

else

    While Not rsED1.EOF
        If strBgcolor = "#F1F1F1" Then
            strBgcolor = "#FFFFFF"
        Else
            strBgcolor = "#F1F1F1"
        End If
        
    'Set rsED2 = Conn.Execute("SELECT * FROM MEMBRE "&where&";")
    'Set rsED2 = Conn.Execute("SELECT * FROM MEMBRE;")
    %>
                <tr bgcolor="<%=strBgcolor%>"> 
                    <td width="15"> 
                    <% Place = Place+1 %>
                    <b><%=Place%></b>&nbsp;&nbsp;</td>
                    <td width="150"><%=rsED1("DateCV")%>&nbsp;</td>
                    <td><%=rsED1("Nom")%>&nbsp;<%=rsED1("Prenom")%>&nbsp;&nbsp;</td>
                    <td><%=rsED1("FormationCV")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                    <td width="20"><a href="test_p_admin_cv_display.asp?num=<%=rsED1("NumCV")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                    <td width="20"><a href="p_admin_cv_valid.asp?num=<%=rsED1("NumCV")%>"><img src="img/postvalid.gif" border="0"></a></td>
                    <td width="20"><a href="p_admin_cv_delete.asp?num=<%=rsED1("NumCV")%>"><img src="img/postdelete.gif" border="0"></a></td>
                </tr>
    <%
        rsED1.MoveNext

    Wend

end if
rsED1.Close
%>
        </table></td>
    </tr>
        <tr valign="top">
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr valign="top">
          <td colspan="7"><b><font color="green">Liste des CV validés et valables</font></b></td>
        </tr>
<%
Place = 0

Set rsEDcv1 = Conn.Execute("SELECT * FROM CV where Visible=1")
if rsEDcv1.EOF then
    Response.Write "<tr><td>Il n'y a pas de CV enregistré dans la base</td></tr>"
                                                                                 
else                                                                             
While Not rsEDcv1.EOF
    If strBgcolor = "#F1F1F1" Then
        strBgcolor = "#FFFFFF"
    Else
        strBgcolor = "#F1F1F1"
    End If


sDate = date
sDiffDate = DateDiff("d", sDate, rsEDcv1("FinCV"))
    if sDiffDate > 0 Then
%>
            <tr bgcolor="<%=strBgcolor%>"> 
                <td width="15"> 
                <% Place = Place+1 %>
                <b><%=Place%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsEDcv1("DateCV")%>&nbsp;</td>
                <td><%=rsEDcv1("Nom")%>&nbsp;<%=rsEDcv1("Prenom")%>&nbsp;&nbsp;</td>
                <td><%=rsEDcv1("FormationCV")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td width="20"><a href="test_p_admin_cv_display.asp?num=<%=rsEDcv1("NumCV")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                <td width="20"><a href="p_admin_cv_valid.asp?num=<%=rsEDcv1("NumCV")%>"><img src="img/postvalid.gif" border="0"></a></td>
                <td width="20"><a href="p_admin_cv_delete.asp?num=<%=rsEDcv1("NumCV")%>"><img src="img/postdelete.gif" border="0"></a></td>
            </tr>
<%
    End if
    rsEDcv1.MoveNext
Wend
rsEDcv1.Close
end if
%>
        </table></td>
    </tr>
        <tr valign="top">
          <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr valign="top">
          <td colspan="7"><b><font color="red">Liste des CV validés et date dépassée</font></b></td>
        </tr>
<%
Place = 0

Set rsEDcv1 = Conn.Execute("SELECT * FROM CV where Visible=1")

if rsEDcv1.EOF then
    Response.Write "<tr><td>Il n'y a pas de CV enregistré dans la base</td></tr>"
                                                                                 
else                                                                             

While Not rsEDcv1.EOF
    If strBgcolor = "#F1F1F1" Then
        strBgcolor = "#FFFFFF"
    Else
        strBgcolor = "#F1F1F1"
    End If


sDate = date
sDiffDate = DateDiff("d", sDate, rsEDcv1("FinCV"))
    if sDiffDate < 0 Then
%>
            <tr bgcolor="<%=strBgcolor%>"> 
                <td width="15"> 
                <% Place = Place+1 %>
                <b><%=Place%></b>&nbsp;&nbsp;</td>
                <td width="150"><%=rsEDcv1("DateCV")%>&nbsp;</td>
                <td><%=rsEDcv1("Nom")%>&nbsp;<%=rsEDcv1("Prenom")%>&nbsp;&nbsp;</td>
                <td><%=rsEDcv1("FormationCV")%> &nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td width="20"><a href="test_p_admin_cv_display.asp?num=<%=rsEDcv1("NumCV")%>"><img src="img/postdisplay.gif" border="0"></a></td>
                <td width="20"><a href="p_admin_cv_valid.asp?num=<%=rsEDcv1("NumCV")%>"><img src="img/postvalid.gif" border="0"></a></td>
                <td width="20"><a href="p_admin_cv_delete.asp?num=<%=rsEDcv1("NumCV")%>"><img src="img/postdelete.gif" border="0"></a></td>
            </tr>
<%
    End if
    rsEDcv1.MoveNext
Wend
rsEDcv1.Close
end if
%>
        </table></td>
    </tr>
</table>
 <!--fin corps de texte-->
        
        
        
        <!--fin insertion  -->
        


 
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
<!-- #include file="connexion.asp"-->
</body>
</html>