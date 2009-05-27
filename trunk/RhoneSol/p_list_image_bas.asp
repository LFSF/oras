<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" >
function envoyerpath(img){
    window.opener.document.getElementById('src').value= img.src;
    window.close();
}
</script>
</head>

<body>
<%
'Retournle l'extension du fichier et vide si erreur
function GetExtension(filename)

   if InStrRev(filename,".") > 0 then
              GetExtension= Mid(filename,InStrRev(filename,".")+1,len(filename))
      else
              GetExtension=""
      end if
end function

'Regarde si l'extension du fichier corresponds au filtre retourne vrai si c'est le cas faux sinon
function AvecUnSeulFiltre(filename,filtre)
    if GetExtension(filename)=filtre then
        AvecUnSeulFiltre=1
    else
        AvecUnSeulFiltre=0
    end if
end function

Dim lefiltre

lefiltre="jpg|png|gif|jpeg"

'Retourne vrai si le nom de fichier a une nom de fichier valide par les filtres
function Filtrer(filename,lesfiltres)
    tableau = Split(lesfiltres,"|", -1)
    i=0
    continue=1
    res=0
    While (i<UBound(tableau) and continue=1)
        if AvecUnSeulFiltre(filename,tableau(i))=1 then
            continue=0
            res=1
        end if
        i=i+1
    Wend
    Filtrer=res
end function





'Créer un objet Scripting.FileSystemObject
  Set FSO = Server.CreateObject("Scripting.FileSystemObject")

  pathdir= "fichiers_upload/img_article/"
'Récupérer le path long du dossier qui nous intéresse
  dir = Server.MapPath(pathdir)

'Obtenir un pointeur vers ce même dossier
  set foldPt = FSO.GetFolder(dir)

'Lire la collection des fichiers de ce dossier
  set fc = foldPt.Files

'ou la collection des sous-dossiers de ce dossier
'  set fc = foldPt.SubFolders
nbParLigne=4
cpt=0
Response.Write "<table cellspacing=""5"">"
'enfin lire cette collection
  for each f in fc


    if Filtrer(f.name,lefiltre)=1 then
        if cpt mod nbParLigne = 0 then
            Response.Write "<tr>"
        end if

        Response.Write "<td>"
        Response.Write "<a href=""javascript:;"" onclick=""envoyerpath(document.images["&cpt&"])""><img name="&cpt&" src="""&pathdir&"\"&f.name&""" width=""90"" height=""90"" alt="""&pathdir&"\"&f.name&""" title="""&f.dateCreated&""" - """&f.size / 1000&""" Ko"" border=""0""/></a>"
        Response.Write "</td>"


        if cpt mod nbParLigne = nbParLigne-1 then
            Response.Write "</tr>"
        end if
        cpt=cpt+1
    end if

  next
Response.Write "</table>"
'Le nombre d'éléments de la collection
'(fichiers ou dossiers) est
    if(cpt=0) then
        Response.Write "Il n'y a pas de photos sur ce dossier"
    else
        Response.Write cpt&" fichier(s)"
    end if

%>
</body>
</html>