<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>Sans Titre</title>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<meta name="generator" content="HAPedit 3.1">
</head>
<body>
<%
'Créer un objet Scripting.FileSystemObject
  Set FSO = _
   Server.CreateObject("Scripting.FileSystemObject")  

'Récupérer le path long du dossier qui nous intéresse
  dir = Server.MapPath("../img/")

'Obtenir un pointeur vers ce même dossier
  set foldPt = FSO.GetFolder(dir)

'Lire la collection des fichiers de ce dossier
  set fc = foldPt.Files

'ou la collection des sous-dossiers de ce dossier
  set fc = foldPt.SubFolders

'enfin lire cette collection
  for each f in fc
   %><li>Nom :  <%=f.name%></li>
   <li>Taille :  <%=f.size%>  octets</li>
   <li>Création :  <%=f.dateCreated%></li>
   <li>Modification :  <%=f.dateLastModified%></li>
   <li>Dernier accès :  <%=f.dateLastAccessed%></li>
   <br><br>
 <% next

'Le nombre d'éléments de la collection
'(fichiers ou dossiers) est
  Response.Write fc.count
%>
</body>
</html>