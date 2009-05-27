
<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>

<% if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_modif.asp" or Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_interview_visualisation.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
else
%>
<!-- #include file="connexion.asp"-->
<%
	 Set rsLireImg = Conn.Execute("Select NomImg From ListFiles where NumItw ="& Request.Querystring("idint"))
%>

	<!-------SUPPRESSION FICHIER DANS LE DOSSIER UPLOAD----->


 <%Set FSO = Server.CreateObject("Scripting.FileSystemObject")%>


<% 

'répertoire selectionné
dir = Server.MapPath("UploadFolder/")

'retourne les informations sur un répertoire
set foldPt = FSO.GetFolder(dir) 

set fc = foldPt.Files 



IF rsLireImg.EOF Then
			  Response.Write("Il n'y a aucune image ")
			  Else
			  While Not rsLireImg.EOF
for each f in fc 
	'IF rsLireImg.EOF Then
			  'Response.Write("Il n'y a aucune image ")
			  'Else
			  'While Not rsLireImg.EOF
					'rsLireImg("NomImg")
			'rsLireImg.MoveNext
			'Wend
				'rsLireImg.Close 
				'Set rsLireImg = Nothing
	'End If		
	
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

	mot_recherche=rsLireImg("NomImg")
	'mot_recherche="tristan"
	'mot_recherche2=Request.Querystring("UrlImg")
	'mot_recherche2="tristan"

	leresultat =InStr(f.name, mot_recherche)
	'leresultat2 =InStr(f.name, mot_recherche2)

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
<% next

rsLireImg.MoveNext
			Wend
				rsLireImg.Close 
				Set rsLireImg = Nothing
	End If			
%>




<!--------------- fin  SUPPRESSION FICHIER----------------->
<%	
	
	
	
	 Set FSO = nothing 
	
%>	


<%
'permet de supprimer toutes les informations d'une interview dans la BDD
	sqlImg="Delete * From ListFiles where NumItw =" & Request.Querystring("idint") 
	sqlQuestion="Delete * From QUESTION where NumItw =" & Request.Querystring("idint")
	sqlInterview="Delete * From Interview where NumItw =" & Request.Querystring("idint")
	
	

	
	

	Conn.Execute(sqlImg)
	Conn.Execute(sqlQuestion)
	Conn.Execute(sqlInterview)
	<!-- #include file="deconnexion.asp"-->

%>	
	
<%
	'REDIRECTION VERS UN EAUTRE  PAGE ASP
	session("redirection_db-multiple-file-to-disk.asp")="ok"
	session("variable_id_img")=mid(Request.Querystring("UrlImg"),1,4)
	response.redirect("p_admin_interview_modif.asp")
%>
<% end if %>
<% end if %>