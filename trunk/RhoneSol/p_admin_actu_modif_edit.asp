<% if not (session("admin_acces_admin")=1 or session("acces_actu")= 1) then
	response.redirect("p_admin.asp")
	else
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<script type="text/javascript" src="scripts/wysiwyg.js"></script>
<script type="text/javascript" src="js/ajaxUpload.js"></script>
<script type="text/javascript">
WYSIWYG.attach('all');
</script>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<%
if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_actu_modif.asp" or Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_modif.asp")
else
if Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/verif_p_admin_actu_modif.asp" then
    Response.Write "<body onload=""location.load()"">"
else
    Response.Write "<body>"
    session("titre")=""
    session("MessageActu")=""
end if
%>

<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->
<!-- #include file="grand_header.txt"-->

<%
session("numActu")= Request.Querystring("num")
Set rsE = Conn.Execute("SELECT * FROM ACTUALITE WHERE NumActu = " & Request.Querystring("num"))
%>


<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<div align="justify"> 
<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td><font color="#6faa06">Modification Article _____________________________________________________________</font></td>
    </tr>
    <tr>
        <td width=82%>
 			       
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
        
        <a href="p_admin_actu_modif.asp"><font size="1"><b><< Retour Menu Article &nbsp;</b></font></a>
			
			</td>
	</tr>
</table>  
</div>

<form method="POST"  enctype="application/x-www-form-urlencoded" action="verif_p_admin_actu_modif.asp">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
	<tr> 
        <td width="100">Auteur:&nbsp;<%=session("admin_nom") %>&nbsp;<%=session("admin_prenom")%></td>
    </tr>
    <tr> 
        <td width="100">Date:</td>
        <td width="100"><input type="text" name="date" value="<%=rsE("DateActu")%>"></td>
    </tr>
                
                
    <tr> 
       <td>Titre:</td>
       <td>
                        <%

                        if session("titre")<>"" then
                            Response.Write "<input name=""titre"" type=""text"" size=""60"" maxlength=""60"" value="""&Server.HtmlEncode(session("titre"))&""">"
                        else
                            Response.Write "<input name=""titre"" type=""text"" size=""60"" value="""&rsE("TitreActu")&""" maxlength=""60"">"
                        end if
                      %>
       </td>
   </tr>
</table>
                  <br/><br/>
				   
                <table border="0px" width="100%" cellpadding="10px">
                <tr> 
                
                <td colspan="2">
                  <textarea class="txt" id="message" name="message" rows="10" cols="60" >
                      <%
                      if session("MessageActu")<>"" then
                            Response.Write Server.HtmlEncode(session("MessageActu"))
                      else
                            Response.Write Server.HtmlEncode(rsE("ArticleActu"))
                      end if

                      %>
                  </textarea>
                </td>
            </tr> 
			
                <tr valign="top"> 
                  <td>&nbsp;</td>
                  <td><input type="hidden" name="num" value="<%=rsE("NumActu")%>"><input type="submit" name="Action" value="Enregistrer"></td>
                </tr>
              
        
        <tr>
            <td><a href="p_admin_actu_modif_display.asp?num=<%=Request.QueryString("num")%>"><img src="img/postdisplay.gif" border="0"></a>
            &nbsp;
            <a href="p_admin_actu_modif_valid.asp?num=<%=Request.QueryString("num")%>"><img src="img/postvalid.gif" border="0"></a>
            &nbsp;
            <a href="p_admin_actu_modif_delete.asp?num=<%=Request.QueryString("num")%>"><img src="img/postdelete.gif" border="0"></a></td>
        </tr>
      </table>
<%session("pieces_jointes")=rsE("PieceJointesActu")%>
                
                <%session("num")=rsE("NumActu")%>

</form>
<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  

</div>
</body>
<!-- #include file="deconnexion.asp"-->
<%end if%>
</html>
<%end if%>