<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->
<!-- #include file="FCKeditor/fckeditor.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
    <!-- #include file="grand_meta.txt"-->
    <title>Rhône-solidarité</title>
    <link href="styles.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="scripts/wysiwyg.js"></script>
    <script type="text/javascript">
      WYSIWYG.attach('all')
    </script>
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>
<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><font color="#6faa06">Newsletter ______________________________________________________</font></td>
    </tr>
                <tr>
                <td width=82%>
      <div align="justify">
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
        
        <A class=lien href="p_admin.asp"><font size=1><b>
                         << Retour Menu &nbsp;</b></font>
                          </a></div></td></tr></table>   

    <form name="news" method="POST"  action="verif_p_admin_newsletter_insert.asp">
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
            <tr> 
                <td width="100">Auteur :&nbsp;<%= session("admin_nom") %>&nbsp;<%= session("admin_prenom")%></td>
            </tr>
            <tr> 
                <td width="100">Date :</td>
                <td><input type="text" name="date" value="<% Response.Write "" & FormatDateTime(Now, vbShortDate)
                Response.Write " " & FormatDateTime(Now, vbShortTime)%>"></td>
            </tr>
            <tr> 
                <td width="100">Titre de la news :</td>
                <td><input name="titre" type="text" size="60" maxlength="60"></td>
            </tr> 
        </table>
<br/><br/> 
        <table border="0px" width="150%" cellpadding="10px">
            <tr>
                <td>
                    <textarea class="txt" id="message" name="message" rows="10" cols="60"></textarea>
                </td>
<%
' J'ai mis l'autre FCKeditor qui est bien mieux :)
'Dim oFCKeditor
'Set oFCKeditor = New FCKeditor
'oFCKeditor.BasePath = "FCKeditor/"
'oFCKeditor.Create "FCKeditor1"
%>
            </tr>
<br/><br/>
            <tr valign="top"> 
                <td>&nbsp;</td>
                <td><input type="submit" name="Action" value="Valider"></td>
            </tr>
        </table>
    </form>


  <!--fin corps de texte-->

        <!--           fin insertion  -->
 
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  


</body>
</html>