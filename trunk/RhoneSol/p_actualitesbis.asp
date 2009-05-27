<%@LANGUAGE="VBSCRIPT"%>
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

<div id="bandeau_orange">Actualités</div>

<table border="0px" width="100%" cellpadding="10px">
<%
set rsActu = Conn.execute("SELECT * FROM ACTUALITE WHERE NumActu = " & Request.QueryString("num") & "")
set rsMembre = Conn.Execute("SELECT * FROM MEMBRE WHERE NumMembre = " & rsActu("NumMembre") & "")
%>
    <tr>
        <td colspan="1"><a class=lien href="p_actualites.asp">
                           <font size=1><b><< Retour Page Actualités</b></font>
                        </a>
        </td>
    </tr>
    <tr>
        <td colspan="1"><font color="#6faa06" size="4">&nbsp;<%=rsActu("TitreActu")%></font></td>
    </tr>
    <!--<tr>
        <td><font color="#6faa06">____________________________________________________________________________________________________</font></td>
    </tr>-->
    <div class="date">Publiée le&nbsp;<%=mid(rsActu("DateActu"),1,10)%> par <%=rsMembre("PrenomMembre")%>&nbsp;<%=rsMembre("NomMembre")%>.</div><br/>
    </table>
    
    <!--INSERTION -->
    <table>
                    <tr>
                        <td ><div align="justify" style="padding:2%;width:80%">
                    <%=rsActu("ArticleActu")%>&nbsp;<br/><br/>
                        </div></td>
                    </tr>
                    <tr>
<%if rsActu("PieceJointesActu")<>"" then%>

                    <td ><div align="center">
                        
                    <a href="uploadFolder/Actu/<%=rsActu("PieceJointesActu")%>"><br/><img src="img racine/piece_jointe.jpg" border="0" ></a>
                    <ul>
                        <%
                          titre=rsActu("PieceJointesActu")
                          'Affiche que le titre , pas le path
                          Response.Write "<li>"&Mid(titre,InStrRev(titre,"/")+1,len(titre))&"</li>"
                        %>
                    </ul>
                    </div></td>

<% end if %>

                    </tr>
                    <tr><td><br/><br/><br/></td></tr>
                    <tr>
                        <td>
                            <a href="p_actualites.asp"><font color="#6faa06" size="1">Retour au menu Actualités</font></a>
                        </td>
                    </tr>
</table>

<%
rsActu.Close 
rsMembre.Close
%>
<br/><br/><br/>

<!--fin insertion-->

<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>
  
  