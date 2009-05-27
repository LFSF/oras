<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Sans Titre</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<meta name="generator" content="HAPedit 3.1">
</head>

<body bgcolor="#FFFFFF">
    <form action="uploadImage.asp" method="post" enctype="multipart/form-data" name="forml"  onsubmit="return check_image();">
            <table>
<%
if Request.QueryString("retour")<>"" then
    Response.write "<tr><td colspan='2'>"
    if Request.QueryString("retour")="1" then
        Response.Write "Ok"
    elseif Request.QueryString("retour")="0" then
        Response.Write "Probleme"
    end if
    Response.write "</td></tr>"
end if
%>
                <tr>
                    <td>Choisissez une image:</td><td><input type="file" name="attach1" id="theFile" /></td>
                </tr>
                <tr>
                    <td></td><td><input type="reset" value="Annuler"/><input type="submit" value="Ajouter"/></td>
                </tr>
            </table>
      </form>
</body>

</html>