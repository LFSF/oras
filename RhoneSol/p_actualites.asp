<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <!-- #include file="grand_meta.txt"-->
    <!-- #include file="connexion.asp"-->
    <title>Rh&ocirc;ne-solidarit&eacute;</title>
    <link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Actualit&eacute;s</div>

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><font color="#6faa06">Actualit&eacute;s____________________________________________________________________</font></td>
    </tr>
    
    </table>

    <!--INSERTION -->

<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
    <tr >
        <td>
            <table width="100%" cellspacing="0" cellpadding="2">
<%
Dim Place
Place = 0

Set rsED = Conn.Execute("SELECT NumActu,NumMembre,DateActu,TitreActu,Visible,ArticleActu FROM ACTUALITE where Visible=1 ORDER BY DateActu DESC")

if rsED.EOF Then
    Response.Write("Il n'y a aucune Actualit&eacute; pour le moment")
End if
Dim cpt

cpt=0

While Not rsED.EOF
If strBgcolor = "#F1F1F1" Then
    strBgcolor = "#FFFFFF"
Else
    strBgcolor = "#F1F1F1"
End If
%>
    <tr height="30" bgcolor="<%=strBgcolor%>" valign="top">
        <td width="15"> 
            <%Place = Place+1 %>
            <b><%=Place%></b>
        </td>
        <td width="110">
            <%=rsED("DateActu")%>
        </td>
        <td align="left">
            <b><a href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>" color="blue"><%=rsED("TitreActu")%></a></b><br/>
            <%
              if cpt<3 then
                Response.Write "<p id='resume'>"
                Response.Write Left(notag(rsED("ArticleActu")),250)
                Response.Write "...</p>"
              end if
            %>
        </td> <td width="20"><a href="p_actualitesbis.asp?num=<%=rsED("NumActu")%>"><img src="img/postdisplay.gif" border="0"></a></td>
        <!--<td align="right">

        </td>-->
    </tr>
<%
cpt=cpt+1
rsED.MoveNext
Wend
rsED.Close
%>
            </table>
            <br />
<br />
            
     <table id="tableau">
    <tr>
        <td class="titre">
        
        <!--
        <img src="img/post_it/presentation/postit_1.jpg" />
        -->
        
         <img src="img/menu/bouton_orange.gif" />
        
        
        </td><td><a href="p_adhesion.asp">Rejoignez nous</a></td>
    </tr>
</table>

<p align="justify">Vous avez envie d'&eacute;crire des articles sur le commerce &eacute;quitable ou sur la solidarite internationale?
 <br/><a href="p_adhesionP.asp"><b>Devenez "R&eacute;dacteur" pour Rh&ocirc;ne-Solidarit&eacute;.</b></a></p>                
                       
                    
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

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>


<%
conn.Close
set conn= Nothing
%>
<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>