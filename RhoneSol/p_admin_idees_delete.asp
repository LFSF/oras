<%@Language="VBscript"%>


<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<%
  
 'Dim rsA
'Set rsA = Conn.Execute("SELECT * FROM T_proposer WHERE  num = " & Request.Querystring("num") & "") 
'session("pieces_jointes")= rsA("filename")

Dim rsDelete
rsDelete = "DELETE * FROM IDEES WHERE NumIdee = " & Request.Querystring("num") & ""
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
<li>Cr�ation : <'%=f.dateCreated%>
<li>Modification : <'%=f.dateLastModified%>
<li>Dernier acc�s : <'%=f.dateLastAccessed%>
<li>Chemin complet : <'%=f.Path%>




<'%



mot_recherche=session("pieces_jointes")


leresultat =InStr(f.name, mot_recherche)
%>



<li>Mot recherch� : <'%=mot_recherche%>
<li>Resultat Instr : <'%=leresultat%>





<'%
if leresultat<>0 then
f.Delete
end if

Set FSO = nothing

 %> 
 
 <'%next%-->>
 
  <%

Conn.close 
		Set Conn=nothing
		

'Response.Redirect("newposteditDelete.asp")
%>



<%Response.Redirect("p_admin_idees_visualisation.asp")%>
<!-- #include file="deconnexion.asp"-->