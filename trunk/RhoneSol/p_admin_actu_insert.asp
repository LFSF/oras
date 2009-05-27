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
if Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/verif_p_admin_actu_insert.asp" then
    Response.Write "<body onload=""location.load()"">"
else
    Response.Write "<body>"
    session("titre")=""
    session("MessageActu")=""
end if

%>


<script language="JavaScript" type="text/javascript">

function verifform()
{

// Vérifie si le titre est bien indiqué
 if(document.news.titre.value == "")
 {
  alert("\nMerci d'indiquer votre titre." 
  document.news.titre.focus();
  return false;
 }

}

</script>


<!-- #include file="connexion.asp"-->
<!-- #include file="admin_securite.asp"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->
<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!--#include file="menu_deroulant.txt"--></div>


<div align="justify">
	<table border="0px" width="100%" cellpadding="10px">
	   <tr>
			<td><font color="#6faa06">Nouvel article ______________________________________________________</font></td>
	   </tr>
	   <tr>
			<td width="82%">
	   
			<!----AJOUT CORPS DE TEXTE IMPORTE DE ORAS---->
			
			<a href="p_admin_actu.asp"><font size="1"><b><< Retour Page Administration &nbsp;</b></font></a>
	
			</td>
		</tr>
	</table>  
</div>

<form name="news" method="POST"  enctype="application/x-www-form-urlencoded" action="verif_p_admin_actu_insert.asp" onsubmit="return verifform()">
          
	<table width="100%" border="0" cellspacing="0" cellpadding="3">
				  
		<tr> 
			<td width="100">Auteur:&nbsp;<%= session("admin_nom") %>&nbsp;<%= session("admin_prenom")%></td>
		</tr>
				   
		<tr> 
			<td width="100">Date:</td>
			<div id="__champ_date__">


			<td><input type="text" name="date" value="<% Response.Write "" & FormatDateTime(Now, vbShortDate)%>"></td>
		</tr>
				  
		<tr> 
			<td width="100">Titre:</td>
			<td><%
					 if session("titre")<>"" then
					 	Response.Write "<input name=""titre"" type=""text"" size=""60"" maxlength=""60"" value="""&Server.HtmlEncode(session("titre"))&""">"
					 else
					 	Response.Write "<input name="" titre"" type=""text"" size=""60"" maxlength=""60"" >"
					 end if
				%>
			</td>
		</tr>
	
		
	</table>
	 
	
	<table border="0" width="100%" cellpadding="10px">
		<tr > 
			<td><textarea class="txt" id="message" name="message" rows="10" cols="60">
				  <%
						 if session("MessageActu")<>"" then
						 Response.Write Server.HtmlEncode(session("MessageActu"))
						end if
					 %>
				  </textarea>
			</td>
		</tr>
	  
		<tr valign="top"> 
			 <td>&nbsp;</td>
			 <td><input type="submit" name="Action" value="Valider"></td>
		</tr>
	</table>

</form>

  
  <!--fin corps de texte-->
        
        
        
        <!--fin insertion  -->
        


 

<!-- Ne pas toucher à ce qui suit : placement du footer -->


<!-- #include file="grand_footer.txt"--> 
<!--#include file="deconnexion.asp"-->
</div>
</body>
</html>