<!-- #include file="connexion.asp"-->
<%
'response.write(Request.Querystring("UrlImg"))
'Fonction qui permet de supprimer l' image s�lectionn�e
	
	
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

'La fonction InStr permet de rechercher si une cha�ne de caract�res existe � l�int�rieur d�une autre cha�ne de caract�res. 
'Cette fonction retourne la position de la premi�re occurrence de la cha�ne recherch�e. Syntaxe :
'InStr(Cha�ne1, Cha�ne2)
'Cha�ne1 est la cha�ne de caract�res � traiter (sur laquelle porte la recherche).
'Cha�ne2 est la cha�ne de caract�res recherch�e dans Cha�ne1.
'Exemple :
'Cha�ne1 = "Sed lex dura lex" � Auteur inconnu
'Cha�ne2 = "lex"
'Cha�ne3 = "gex"
'La fonction InStr(Cha�ne1,Cha�ne2) retournera la valeur ".........."
'La fonction InStr(Cha�ne1,Cha�ne3) retournera la valeur 0.

mot_recherche=Request.Querystring("UrlImg")
'mot_recherche="tristan"
'mot_recherche2=Request.Querystring("UrlImg")
'mot_recherche2="tristan"


leresultat =InStr(f.name, mot_recherche)
'leresultat2 =InStr(f.name, mot_recherche2)


%>
<li>Mot recherch� : <%=mot_recherche%> et 
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
<li><font color=red>Fichier � effacer</font>

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