<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title><%Server.HtmlEncode("Votre espace d'image")%></title>
<script type="text/javascript" >
function envoyerpath(img){
    window.opener.document.getElementById('src').value= img.src;
    window.close();
}

function check_file(){

    var msg="";

    var filename = document.getElementById("theFile").value;
    if (filename == "")  {
      msg += "Veuillez choisir une image avant de valider.\n";

    }else{
      // On recupere la position du . pour essayer de recuperer l'extension de l'image
      var dotIndex = filename.lastIndexOf('.',filename.length-1);
      var ext= filename.substr(dotIndex+1,filename.length-1);
      ext=ext.toLowerCase();
      if(ext!="png" && ext!="gif" && ext!="jpg" && ext!="jpeg")
        msg += "Veuillez choisir une image au format gif, png, jpg, jpeg.\n";

    }


    if (msg == ""){
      return(true);
    }else{
      alert(msg);
      return(false);
    }


}
</script>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<meta name="generator" content="HAPedit 3.1">
</head>
<BODY>
<div style="background-color:grey;border:2px solid black;">
<table cellspacing="0">
    <tr>
        <td>
    <form action="uploadImage.asp" method="post" enctype="multipart/form-data" name="forml"  onsubmit="return check_file();">
            <table>
<!-- #include file="util.asp"-->
<%
Dim pathdir
pathdir= "fichiers_upload/img_article/"&session("admin_email")&"_"&session("admin_nom")&"/"


'Envoi du filtre
Response.Write "<input type='hidden' name='lefiltre' value='"&lefiltre&"' />"

'Affichage du chemin de retour s'il y en a un
if Request.QueryString("retour")<>"" then
    Response.write "<tr><td colspan='2'>"
    if Request.QueryString("retour")="1" then
        Response.Write "<div style='background-color:green;border: 1px solid green;padding:2px;color:white;'>L'image a bien �t� ajout�e</div>"
    elseif Request.QueryString("retour")="0" then
        Response.Write "<div style='background-color:red;border: 1px solid black;padding:2px;'>Il y a eu un probleme lors du chargement de l'image</div>"
    end if
    Response.write "</td></tr>"
end if
%>
                <tr >
                    <td>Choisissez une image:</td><td><input type="file" name="attach1" id="theFile" /></td>
                </tr>
                <tr >
                    <td colspan="2" align="right"><font style="font-size: 10px;">fichier au format <%=lefiltre%> et <font style="color:white"><%=Server.HtmlEncode("< 2Mo")%></font></font></td>
                </tr>
                <tr >
                    <td></td><td><input type="reset" value="Annuler"/><input type="submit" value="Ajouter"/></td>
                </tr>
            </table>
      </form>
        </td>
    </tr>
</table>
</div>

<div>
<%




'Cr�er un objet Scripting.FileSystemObject
  Set FSO = Server.CreateObject("Scripting.FileSystemObject")



'R�cup�rer le path long du dossier qui nous int�resse
  dir = Server.MapPath(pathdir)
  Folder= dir

If Not FSO.FolderExists(Folder) Then

    pathdir= "fichiers_upload/img_article/"
    dir = Server.MapPath(pathdir)
    set foldPt = FSO.GetFolder(dir)

else
    'Obtenir un pointeur vers ce m�me dossier
  set foldPt = FSO.GetFolder(dir)

End If

'Lire la collection des fichiers de ce dossier
  set fc = foldPt.Files


nbParLigne=5
cpt=0
Response.Write "<table cellspacing=""5"">"
'enfin lire cette collection
  for each f in fc


    if Filtrer(f.name,lefiltre)=1 then
        if cpt mod nbParLigne = 0 then
            Response.Write "<tr>"
        end if

        Response.Write "<td>"
        Response.Write "<a href=""javascript:;"" onclick=""envoyerpath(document.images["&cpt&"])""><img name="&cpt&" src="""&pathdir&"\"&f.name&""" width=""95"" height=""95"" alt="""&pathdir&"\"&f.name&""" title="""&f.dateCreated&""" - """&f.size / 1000&""" Ko"" border=""0""/></a>"
        Response.Write "</td>"


        if cpt mod nbParLigne = nbParLigne-1 then
            Response.Write "</tr>"
        end if
        cpt=cpt+1
    end if

  next
Response.Write "</table>"
'Le nombre d'�l�ments de la collection
'(fichiers ou dossiers) est
    if(cpt=0) then
        Response.Write "Il n'y a pas de photos sur ce dossier"
    else
        Response.Write cpt&" fichier(s)"
    end if

%>  </td>
    </tr>
</table>
</div>
</BODY>

</html>