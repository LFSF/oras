<%@Language="VBscript"%>


<!-- #include file="admin_securite.asp"-->


<%

response.write("var_img : "   & request("var_img") & "<br><br>")
response.write("var_id : "   & request("var_id")& "<br><br>")
response.write("var_cell : "   & request("var_cell")& "<br><br>")

var_cellule="img" & request("var_cell")
session("numero_interview")=request("var_id")
response.write(request("var_cellule")& "<br><br>")

'dbPath = Server.MapPath("bd/bd_rs.mdb")
'Set Conn = Server.CreateObject("ADODB.Connection")
'Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
' & " DBQ=" & dbPath

'Dim rsA
'Set rsA = Conn.Execute("SELECT * FROM T_proposer WHERE  num = " & session ("num") & "") 
'session("pieces_jointes")= rsA("filename")

'Dim rsDelete
'rsDelete = "DELETE img2  FROM t_interviews  WHERE img3 ='2008620181516000001634860[1].jpg' "

'rsDelete = "DELETE '20086171449522_120-200.jpg' FROM t_interviews  "
'rsDelete = "DELETE" & request("var_img") & " FROM t_interviews "

'Conn.Execute(rsDelete)

     dbPath = Server.MapPath("bd/bd_rs.mdb")
	 Set Conn = Server.CreateObject("ADODB.Connection")
	 Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
	 & " DBQ=" & dbPath      
	 
		SQL = "DELETE t_interview SET"&var_cellule&"="WHERE num=&request("var_id")
	'SQL = "UPDATE t_interviews SET " & var_cellule & "='' WHERE  num =" & request("var_id")  
	'SQL = "DELETE img3 from  t_interviews  WHERE  num =81 "  
		
	Response.Write("<br>" & sql & "<br>")
	conn.Execute(SQL)

'if session("image")=rsE("img5") then
'rsDelete = "UPDATE t_interviews SET  img5 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
'Conn.Execute(rsDelete)
'end if

%>

<%
set FSO = Server.CreateObject("Scripting.FileSystemObject") 
dir = Server.MapPath("/fichiers_upload/upload_interviews")
set foldPt = FSO.GetFolder(dir) 
set fc = foldPt.Files 
%>

<% set fc1 = foldPt.SubFolders %>

<% for each f in fc %>
<li>Nom : <a href="ublog_test/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>
<%

'La fonction InStr permet de rechercher si une chaîne de caractères existe à l’intérieur d’une autre chaîne de caractères. 
'Cette fonction retourne la position de la première occurrence de la chaîne recherchée. Syntaxe :
'InStr(Chaîne1, Chaîne2)
'Chaîne1 est la chaîne de caractères à traiter (sur laquelle porte la recherche).
'Chaîne2 est la chaîne de caractères recherchée dans Chaîne1.
'Exemple :
'Chaîne1 = "Sed lex dura lex" ’ Auteur inconnu
'Chaîne2 = "lex"
'Chaîne3 = "gex"
'La fonction InStr(Chaîne1,Chaîne2) retournera la valeur ".........."
'La fonction InStr(Chaîne1,Chaîne3) retournera la valeur 0.

mot_recherche=request("var_img")
'mot_recherche="tristan"

leresultat =InStr(f.name, mot_recherche)

%>
<li>Mot recherché : <%=mot_recherche%>
<li>Resultat Instr : <%=leresultat%>
<%
if leresultat<>0 then
f.Delete
end if
%>
<br><br>
<% next%>

Le nombre d'éléments de la collection
(fichiers ou dossiers) est <% = fc.count %>  et  <% = fc1.count %>

<%	
' ajout tristan 
Set FSO = nothing 
%>

<center>
<%
Response.Redirect("formup_p_admin_interview_modif_ajout_images.asp?num= " & replace(REPLACE(session("numero_interview"),"""",espace),"'",simplecot) & "")
%>

</body>
</html>