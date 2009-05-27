<!-- #include file="connexion.asp"-->
<%
'response.write(Request.Querystring("UrlImg"))
'Fonction qui permet de supprimer l' image sélectionnée
	
	
	sql="Delete * From ListFiles where NomImg ='" & Request.Querystring("UrlImg") & "'"
	Conn.Execute(sql)
	

%>
<!-- #include file="deconnexion.asp"-->

	<!-------SUPPRESSION FICHIER DANS LE DOSSIER UPLOAD----->


 <% Set FSO = Server.CreateObject("Scripting.FileSystemObject") %>


<% 
'dir = Server.MapPath("ublog_test/") 
'dir = Server.MapPath("/..")
'dir = Server.MapPath("/.")


dir = Server.MapPath("UploadFolder/")





%>


<% set foldPt = FSO.GetFolder(dir) %>

<% set fc = foldPt.Files %>

<% set fc1 = foldPt.SubFolders %>


<% for each f in fc %>
<li>Nom : <%=Request.Querystring("UrlImg")%>
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

mot_recherche=Request.Querystring("UrlImg")
'mot_recherche="tristan"
'mot_recherche2=Request.Querystring("UrlImg")
'mot_recherche2="tristan"


leresultat =InStr(f.name, mot_recherche)
'leresultat2 =InStr(f.name, mot_recherche2)


%>
<li>Mot recherché : <%=mot_recherche%> et 
<%
'=mot_recherche2
%>

<li>Resultat Instr : <%=leresultat%>  et 
<%
'=leresultat2
%> 
<%
if leresultat<>0 or  leresultat2<>0 then
%>
<li><font color=red>Fichier à effacer</font>

<%
if leresultat<>0 then
f.Delete
end if
%>

<%
end if
%>
<br><br>
<% next%>




<!--------------- fin  SUPPRESSION FICHIER----------------->
<%	
	
	
	
	 Set FSO = nothing 
	
	%>	
	
	
	<%
	'REDIRECTION VERS UN EAUTRE  PAGE ASP
	session("redirection_db-multiple-file-to-disk.asp")="ok"
	session("variable_id_img")=mid(Request.Querystring("UrlImg"),1,4)
	response.redirect("p_admin_interview_modif_ajout_images_upload.asp?idint="&Session("idint"))
	
	
	%>