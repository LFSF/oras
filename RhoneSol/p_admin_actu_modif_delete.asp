<%@Language="VBscript"%>

<% if not (session("admin_acces_admin")=1 or session("acces_actu")= 1) then
	response.redirect("p_admin.asp")
	else
%>

<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<%
if not(Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_actu_modif.asp" or Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp") then
	response.redirect("http://www.rhone-solidarite.com/p_admin_actu_visualisation.asp")
else
Dim rsA
Set rsA = Conn.Execute("SELECT * FROM ACTUALITE WHERE NumActu = " & Request.Querystring("num") & "") 
session("pieces_jointes")= rsA("PieceJointesActu")

Dim rsDelete
rsDelete = "DELETE * FROM ACTUALITE WHERE NumActu = " & Request.Querystring("num")
Conn.Execute(rsDelete)
majDate()


set FSO = Server.CreateObject("Scripting.FileSystemObject") 

dir = Server.MapPath("fichiers_upload/upload_actualites")

set foldPt = FSO.GetFolder(dir)

set fc = foldPt.Files 

for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_actualites/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
mot_recherche=session("pieces_jointes")

leresultat =InStr(f.name, mot_recherche)
%>

<li>Mot recherché : <%=mot_recherche%>
<li>Resultat Instr : <%=leresultat%>

<%
if leresultat<>0 then
f.Delete
end if

Set FSO = nothing

next%>


<!-- #include file="deconnexion.asp"-->
<%Response.Redirect("p_admin_actu.asp")%>
<%end if%>
<% end if %>