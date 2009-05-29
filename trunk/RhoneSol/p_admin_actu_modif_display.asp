<%@LANGUAGE="VBSCRIPT"%>

<% if not (session("admin_acces_admin")=1 or session("acces_actu")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="admin_securite.asp"-->
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
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
<%
if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_actu_modif.asp" or Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
else
set rsActu = Conn.execute("SELECT * FROM ACTUALITE WHERE NumActu = " & Request.QueryString("num") &"")
Set rsMembre = Conn.execute("SELECT * FROM MEMBRE WHERE NumMembre = " & rsActu("NumMembre"))
%>
	<tr>
    	<td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
	<tr>
		<td width=82%>
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
			<A class=lien href="p_admin_actu.asp"><font size=1><b>
					<< Retour Menu Article &nbsp;</b></font>
			</a>
		</td>
	</tr>
	<tr>
    	<td colspan="1"><font color="#6faa06" size="4">&nbsp;<%=rsActu("TitreActu")%></font></td></tr>
		<tr><td><font color="#6faa06">____________________________________________________________________________________________________</font></td>
    </tr>
	<div class="date">publié le&nbsp;<%=mid (rsActu ("DateActu"),1,10)%>&nbsp; par&nbsp; <%=rsMembre("NomMembre")%>&nbsp; <%=rsMembre("PrenomMembre")%></div><br/>
	</table>
	
	<!--       INSERTION -->
	<table>
					<tr><td><div align="justify"><%=rsActu("ArticleActu")%>&nbsp;<br/><br/></div></td></tr>
					
						<tr>
<%if rsActu("PieceJointesActu")<>"" then%>

					<td ><div align="center">
						
				<a href="uploadFolder/Actu/<%=rsActu("PieceJointesActu")%>"><%=rsActu("PieceJointesActu")%></a>

					</div></td>

<% end if %>

					</tr>
					<tr>
						<td><a href="p_admin_actu_modif_valid.asp?num=<%=Request.QueryString("num")%>"><img src="img/postvalid.gif" border="0"/></a>
						&nbsp;
						<a href="p_admin_actu_modif_edit.asp?num=<%=Request.QueryString("num")%>"><img src="img/postedit.gif" border="0"/></a>
						&nbsp;
						<a href="p_admin_actu_modif_delete.asp?num=<%=Request.QueryString("num")%>"><img src="img/postdelete.gif" border="0"/></a></td>
					</tr>
</table>

<%
rsMembre.Close
rsActu.Close 
%>
<br/><br/><br/>
		
<!--fin insertion  -->

<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
<%end if%>
</html>
  
<% end if%>