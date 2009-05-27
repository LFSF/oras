<%@Language="VBscript"%>

<!-- #include file="admin_securite.asp"-->

<% if not (session("admin_acces_admin")=1 or session("acces_off")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<!-- #include file="connexion.asp"-->

<%

 'Dim rsA
'Set rsA = Conn.Execute("SELECT * FROM T_proposer WHERE  num = " & Request.Querystring("num") & "") 
'session("pieces_jointes")= rsA("filename")

Dim rsDelete
rsDelete = "DELETE * FROM OFFRES WHERE NumOff = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)




'set FSO = Server.CreateObject("Scripting.FileSystemObject") 




'dir = Server.MapPath("/fichiers_upload/upload_cv")


 'set foldPt = FSO.GetFolder(dir) 

 'set fc = foldPt.Files 





%>



<!-- <'% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_cv/<'%=f.name%>"><'%=f.name%></a>
<li>Taille : <'%=f.size%> octets
<li>Longueur de la chaine : <'%=Len(f.name)%> octets
<li>Création : <'%=f.dateCreated%>
<li>Modification : <'%=f.dateLastModified%>
<li>Dernier accès : <'%=f.dateLastAccessed%>
<li>Chemin complet : <'%=f.Path%>




<'%



mot_recherche=session("pieces_jointes")


leresultat =InStr(f.name, mot_recherche)
%>



<li>Mot recherché : <'%=mot_recherche%>
<li>Resultat Instr : <'%=leresultat%>





<'%
if leresultat<>0 then
f.Delete
end if

Set FSO = nothing

 %> 
 
 <'%next%-->>
 
  <%


		

'Response.Redirect("newposteditDelete.asp")
%>

<!-- #include file="deconnexion.asp"-->

<%Response.Redirect("p_admin_offre_validation.asp")%>

<% end if %>