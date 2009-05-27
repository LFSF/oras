<%@Language="VBscript"%>





<%

dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
  
 Dim rsA
Set rsA = Conn.Execute("SELECT * FROM t_interviews WHERE  num = " & session("num") & "") 









set FSO = Server.CreateObject("Scripting.FileSystemObject") 



'dir = Server.MapPath("ublog_test/") 
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
if session("img1") <> rsA("img1") then
leresultat =InStr(f.name, session("img1"))
else 
leresultat = 0
end if

%>








<%
if leresultat<>0 then
f.Delete


end if



 %> 
 
 <% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>


<%
if session("img2") <> rsA("img2") then
leresultat2 =InStr(f.name, session("img2"))
else leresultat2 = 0
end if


if leresultat2<>0 then
f.Delete
end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

%>



<%
if session("img3") <> rsA("img3") then
leresultat3 =InStr(f.name, session("img3"))
else leresultat3 =  0
end if

if leresultat3<>0 then
f.Delete
end if

%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img4") <> rsA("img4") then
leresultat4 =InStr(f.name, session("img4"))
else leresultat4 =  0
end if

if leresultat4<>0 then
f.Delete
end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img5") <> rsA("img5") then
leresultat5 =InStr(f.name, session("img5"))
else leresultat5 = 0
end if

if leresultat5<>0 then
f.Delete


end if

%>
<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img6") <> rsA("img6") then
leresultat6 =InStr(f.name, session("img6"))
else leresultat6 =  0
end if


if leresultat6<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img7") <> rsA("img7") then
leresultat7 =InStr(f.name, session("img7"))
else leresultat7 =  0
end if

if leresultat7<>0 then
f.Delete

end if







%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img8") <> rsA("img8") then
leresultat8 =InStr(f.name, session("img8"))
else leresultat8 =  0
end if
if leresultat8<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img9") <> rsA("img9") then
leresultat9 =InStr(f.name, session("img9"))
else leresultat9 =  0
end if
if leresultat9<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img10") <> rsA("img10") then
leresultat10 =InStr(f.name, session("img10"))
else leresultat10 =  0
end if


if leresultat10<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img11") <> rsA("img11") then
leresultat11 =InStr(f.name, session("img11"))
else leresultat11 =  0
end if


if leresultat11<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img12") <> rsA("img12") then
leresultat12 =InStr(f.name, session("img12"))
else leresultat12 =  0
end if


if leresultat12<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img13") <> rsA("img13") then
leresultat13 =InStr(f.name, session("img13"))
else leresultat13 =  0
end if


if leresultat13<>0 then
f.Delete

end if



%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img14") <> rsA("img14") then
leresultat14 =InStr(f.name, session("img14"))
else leresultat14 =  0
end if

if leresultat14<>0 then
f.Delete

end if
%>
<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%



if session("img15") <> rsA("img15") then
leresultat15 =InStr(f.name, session("img15"))
else leresultat15 =  0
end if





if leresultat15<>0 then
f.Delete

end if






%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img16") <> rsA("img16") then
leresultat16 =InStr(f.name, session("img16"))
else leresultat16 =  0
end if

if leresultat16<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img17") <> rsA("img17") then
leresultat17 =InStr(f.name, session("img17"))
else leresultat17 =  0
end if

if leresultat17<>0 then
f.Delete

end if






%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img18") <> rsA("img18") then
leresultat18 =InStr(f.name, session("img18"))
else leresultat18 =  0
end if




if leresultat18<>0 then
f.Delete

end if



%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img19") <> rsA("img19") then
leresultat19 =InStr(f.name, session("img19"))
else leresultat19 =  0
end if


if leresultat19<>0 then
f.Delete

end if





%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img20") <> rsA("img20") then
leresultat20 =InStr(f.name, session("img20"))
else leresultat20 =  0
end if



if leresultat20<>0 then
f.Delete

end if


%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img21") <> rsA("img21") then
leresultat21 =InStr(f.name, session("img21"))
else leresultat21 =  0
end if

if leresultat21<>0 then
f.Delete

end if



%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img22") <> rsA("img22") then
leresultat22 =InStr(f.name, session("img22"))
else leresultat22 =  0
end if

if leresultat22<>0 then
f.Delete

end if


%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%



if session("img23") <> rsA("img23") then
leresultat23 =InStr(f.name, session("img23"))
else leresultat23 =  0
end if


if leresultat23<>0 then
f.Delete

end if


%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img24") <> rsA("img24") then
leresultat24 =InStr(f.name, session("img24"))
else leresultat24 =  0
end if

if leresultat24<>0 then
f.Delete

end if


%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%


if session("img25") <> rsA("img25") then
leresultat25 =InStr(f.name, session("img25"))
else leresultat25 =  0
end if

if leresultat25<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img26") <> rsA("img26") then
leresultat26 =InStr(f.name, session("img26"))
else leresultat26 =  0
end if
if leresultat26<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img27") <> rsA("img27") then
leresultat27 =InStr(f.name, session("img27"))
else leresultat27 =  0
end if
if leresultat27<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img28") <> rsA("img28") then
leresultat28 =InStr(f.name, session("img28"))
else leresultat28 =  0
end if
if leresultat28<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img29") <> rsA("img29") then
leresultat29 =InStr(f.name, session("img29"))
else leresultat29 =  0
end if



if leresultat29<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img30") <> rsA("img30") then
leresultat30 =InStr(f.name, session("img30"))
else leresultat30 =  0
end if



if leresultat30<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img31") <> rsA("img31") then
leresultat31 =InStr(f.name, session("img31"))
else leresultat31 =  0
end if


if leresultat31<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img32") <> rsA("img32") then
leresultat32 =InStr(f.name, session("img32"))
else leresultat32 =  0
end if



if leresultat32<>0 then
f.Delete
end if

%>



<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%


if session("img33") <> rsA("img33") then
leresultat33 =InStr(f.name, session("img33"))
else leresultat33 =  0
end if

if leresultat33<>0 then
f.Delete

end if


%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img34") <> rsA("img34") then
leresultat34 =InStr(f.name, session("img34"))
else leresultat34 =  0
end if
if leresultat34<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img35") <> rsA("img35") then
leresultat35 =InStr(f.name, session("img35"))
else leresultat35 =  0
end if

if leresultat35<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%


if session("img36") <> rsA("img36") then
leresultat36 =InStr(f.name, session("img36"))
else leresultat36 =  0
end if

if leresultat36<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img37") <> rsA("img37") then
leresultat37 =InStr(f.name, session("img37"))
else leresultat37 =  0
end if

if leresultat37<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%


if session("img38") <> rsA("img38") then
leresultat38 =InStr(f.name, session("img38"))
else leresultat38 =  0
end if

if leresultat38<>0 then
f.Delete

end if

%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%


if session("img39") <> rsA("img39") then
leresultat39 =InStr(f.name, session("img39"))
else leresultat39 =  0
end if

if leresultat39<>0 then
f.Delete

end if

%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img40") <> rsA("img40") then
leresultat40 =InStr(f.name, session("img40"))
else leresultat40 =  0
end if

if leresultat40<>0 then
f.Delete

end if
%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img41") <> rsA("img41") then
leresultat41 =InStr(f.name, session("img41"))
else leresultat41 =  0
end if
if leresultat41<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img42") <> rsA("img42") then
leresultat42 =InStr(f.name, session("img42"))
else leresultat42 =  0
end if

if leresultat42<>0 then
f.Delete

end if

%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img43") <> rsA("img43") then
leresultat43 =InStr(f.name, session("img43"))
else leresultat43 =  0
end if

if leresultat43<>0 then
f.Delete

end if
%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img44") <> rsA("img44") then
leresultat44 =InStr(f.name, session("img44"))
else leresultat44 =  0
end if
if leresultat44<>0 then
f.Delete

end if


%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img45") <> rsA("img45") then
leresultat45 =InStr(f.name, session("img45"))
else leresultat45 =  0
end if


if leresultat45<>0 then
f.Delete

end if
%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img46") <> rsA("img46") then
leresultat46 =InStr(f.name, session("img46"))
else leresultat46 =  0
end if


if leresultat46<>0 then
f.Delete

end if


%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img47") <> rsA("img47") then
leresultat47 =InStr(f.name, session("img47"))
else leresultat47 =  0
end if

if leresultat47<>0 then
f.Delete

end if
%>


<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img48") <> rsA("img48") then
leresultat48 =InStr(f.name, session("img48"))
else leresultat48 =  0
end if


if leresultat48<>0 then
f.Delete

end if


%>



<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%
if session("img49") <> rsA("img49") then
leresultat49 =InStr(f.name, session("img49"))
else leresultat49 =  0
end if


if leresultat49<>0 then
f.Delete

end if
%>

<% next%>



<% for each f in fc %>
<li>Nom : <a href="fichiers_upload/upload_interviews/<%=f.name%>"><%=f.name%></a>
<li>Taille : <%=f.size%> octets
<li>Longueur de la chaine : <%=Len(f.name)%> octets
<li>Création : <%=f.dateCreated%>
<li>Modification : <%=f.dateLastModified%>
<li>Dernier accès : <%=f.dateLastAccessed%>
<li>Chemin complet : <%=f.Path%>

<%

if session("img50") <> rsA("img50") then
leresultat50 =InStr(f.name, session("img50"))
else leresultat50 =  0
end if

if leresultat50<>0 then
f.Delete
end if

%>



<%
Set FSO = nothing
%>
 
 <%next%>
 
  <%
  
Conn.close 
		Set Conn=nothing
		

'Response.Redirect("newposteditDelete.asp")
%>



<%Response.Redirect("p_admin_interview_modif_ajout_images.asp")%>