<%@Language="VBscript"%>


<!-- #include file="admin_securite.asp"-->
<!-- #include file="connexion.asp"-->

<%

  
 'Dim rsED
'Set rsA = Conn.Execute("SELECT * FROM t_interviews WHERE  num = " & Request.Querystring("num") & "") 
'session("pieces_jointes")= rsA("pieces_jointes")




Dim rsE


Set rsE = Conn.Execute("SELECT * FROM t_interviews WHERE  num = " & Request.Querystring("num") & "")
session("numero")=Request.Querystring("num")'rsE("num")

Dim rsDelete

if session("image")=rsE("img1") then

rsDelete = "UPDATE t_interviews SET  img1 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img2") then

rsDelete = "UPDATE t_interviews SET  img2 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img3") then

rsDelete = "UPDATE t_interviews SET  img3 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img4") then

rsDelete = "UPDATE t_interviews SET  img4 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img5") then

rsDelete = "UPDATE t_interviews SET  img5 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img6") then

rsDelete = "UPDATE t_interviews SET  img6 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img7") then

rsDelete = "UPDATE t_interviews SET  img7 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img8") then

rsDelete = "UPDATE t_interviews SET  img8 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img9") then

rsDelete = "UPDATE t_interviews SET  img9 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img10") then

rsDelete = "UPDATE t_interviews SET  img10 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img11") then

rsDelete = "UPDATE t_interviews SET  img11 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img12") then

rsDelete = "UPDATE t_interviews SET  img12 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img13") then

rsDelete = "UPDATE t_interviews SET  img13 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img14") then

rsDelete = "UPDATE t_interviews SET  img14 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img15") then

rsDelete = "UPDATE t_interviews SET  img15 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img16") then

rsDelete = "UPDATE t_interviews SET  img16 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img17") then

rsDelete = "UPDATE t_interviews SET  img17 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img18") then

rsDelete = "UPDATE t_interviews SET  img18 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img19") then

rsDelete = "UPDATE t_interviews SET  img19 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img20") then

rsDelete = "UPDATE t_interviews SET  img20 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img21") then

rsDelete = "UPDATE t_interviews SET  img21 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if



if session("image")=rsE("img22") then

rsDelete = "UPDATE t_interviews SET  img22 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img23") then

rsDelete = "UPDATE t_interviews SET  img23 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img24") then

rsDelete = "UPDATE t_interviews SET  img24 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img25") then

rsDelete = "UPDATE t_interviews SET  img25 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img26") then

rsDelete = "UPDATE t_interviews SET  img26 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img27") then

rsDelete = "UPDATE t_interviews SET  img27 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img28") then

rsDelete = "UPDATE t_interviews SET  img28 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img29") then

rsDelete = "UPDATE t_interviews SET  img29 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img30") then

rsDelete = "UPDATE t_interviews SET  img30 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img31") then

rsDelete = "UPDATE t_interviews SET  img31 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img32") then

rsDelete = "UPDATE t_interviews SET  img32 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img33") then

rsDelete = "UPDATE t_interviews SET  img33 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img34") then

rsDelete = "UPDATE t_interviews SET  img34 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img35") then

rsDelete = "UPDATE t_interviews SET  img35 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img36") then

rsDelete = "UPDATE t_interviews SET  img36 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img37") then

rsDelete = "UPDATE t_interviews SET  img37 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img38") then

rsDelete = "UPDATE t_interviews SET  img38 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img39") then

rsDelete = "UPDATE t_interviews SET  img39 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img40") then

rsDelete = "UPDATE t_interviews SET  img40 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img41") then

rsDelete = "UPDATE t_interviews SET  img41 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img42") then

rsDelete = "UPDATE t_interviews SET  img42 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img43") then

rsDelete = "UPDATE t_interviews SET  img43 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img44") then

rsDelete = "UPDATE t_interviews SET  img44 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if

if session("image")=rsE("img45") then

rsDelete = "UPDATE t_interviews SET  img45 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img46") then

rsDelete = "UPDATE t_interviews SET  img46 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img47") then

rsDelete = "UPDATE t_interviews SET  img47 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img48") then

rsDelete = "UPDATE t_interviews SET  img48 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img49") then

rsDelete = "UPDATE t_interviews SET  img49 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if


if session("image")=rsE("img50") then

rsDelete = "UPDATE t_interviews SET  img50 = '" & "" & "' WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete)

end if



set FSO = Server.CreateObject("Scripting.FileSystemObject") 



dir = Server.MapPath("/fichiers_upload/upload_interviews")


 set foldPt = FSO.GetFolder(dir) 

 set fc = foldPt.Files 





%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>




<%






leresultat =InStr(f.name, session("image"))
%>



<li>Mot recherché : <%=session("image")%>
<li>Resultat Instr : <%=leresultat%>





<%
if leresultat<>0 then
f.Delete
end if

Set FSO = nothing

 %> 
 
 <%next%>
 
  <%

Conn.close 
		Set Conn=nothing
		
	 	espace="&#034;"
	simplecot="&#039;"

'Response.Redirect("newposteditDelete.asp")
%>



<%Response.Redirect("formup_p_admin_interview_modif_ajout_images.asp?num= " & replace(REPLACE(session("numero"),"""",espace),"'",simplecot) & "")%>