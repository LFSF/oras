<%@Language="VBscript"%>

<!-- #include file="admin_securite.asp"-->

<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>


<%

dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
  
 Dim rsA
Set rsA = Conn.Execute("SELECT * FROM t_interviews WHERE  num = " & Request.Querystring("num") & "") 
session("img1")= rsA("img1")
session("img2")= rsA("img2")
session("img3")= rsA("img3")
session("img4")= rsA("img4")
session("img5")= rsA("img5")
session("img6")= rsA("img6")
session("img7")= rsA("img7")
session("img8")= rsA("img8")
session("img9")= rsA("img9")
session("img10")= rsA("img10")

session("img11")= rsA("img11")
session("img12")= rsA("img12")
session("img13")= rsA("img13")
session("img14")= rsA("img14")
session("img15")= rsA("img15")
session("img16")= rsA("img16")
session("img17")= rsA("img17")
session("img18")= rsA("img18")
session("img19")= rsA("img19")
session("img20")= rsA("img20")

session("img21")= rsA("img21")
session("img22")= rsA("img22")
session("img23")= rsA("img23")
session("img24")= rsA("img24")
session("img25")= rsA("img25")
session("img26")= rsA("img26")
session("img27")= rsA("img27")
session("img28")= rsA("img28")
session("img29")= rsA("img29")
session("img30")= rsA("img30")

session("img31")= rsA("img31")
session("img32")= rsA("img32")
session("img33")= rsA("img33")
session("img34")= rsA("img34")
session("img35")= rsA("img35")
session("img36")= rsA("img36")
session("img37")= rsA("img37")
session("img38")= rsA("img38")
session("img39")= rsA("img39")
session("img40")= rsA("img40")

session("img41")= rsA("img41")
session("img42")= rsA("img42")
session("img43")= rsA("img43")
session("img44")= rsA("img44")
session("img45")= rsA("img45")
session("img46")= rsA("img46")
session("img47")= rsA("img47")
session("img48")= rsA("img48")
session("img49")= rsA("img49")
session("img50")= rsA("img50")







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

mot_recherche= session("img1")

leresultat =InStr(f.name, mot_recherche)


leresultat3 =InStr(f.name, session("img3"))
leresultat4 =InStr(f.name, session("img4"))
leresultat5 =InStr(f.name, session("img5"))
leresultat6 =InStr(f.name, session("img6"))
leresultat7 =InStr(f.name, session("img7"))
leresultat8 =InStr(f.name, session("img8"))
leresultat9 =InStr(f.name, session("img9"))
leresultat10 =InStr(f.name, session("img10"))

leresultat11 =InStr(f.name, session("img11"))
leresultat12 =InStr(f.name, session("img12"))
leresultat13 =InStr(f.name, session("img13"))
leresultat14 =InStr(f.name, session("img14"))
leresultat15 =InStr(f.name, session("img15"))
leresultat16 =InStr(f.name, session("img16"))
leresultat17 =InStr(f.name, session("img17"))
leresultat18 =InStr(f.name, session("img18"))
leresultat19 =InStr(f.name, session("img19"))
leresultat20 =InStr(f.name, session("img20"))

leresultat21 =InStr(f.name, session("img21"))
leresultat22 =InStr(f.name, session("img22"))
leresultat23 =InStr(f.name, session("img23"))
leresultat24 =InStr(f.name, session("img24"))
leresultat25 =InStr(f.name, session("img25"))
leresultat26 =InStr(f.name, session("img26"))
leresultat27 =InStr(f.name, session("img27"))
leresultat28 =InStr(f.name, session("img28"))
leresultat29 =InStr(f.name, session("img29"))
leresultat30 =InStr(f.name, session("img30"))

leresultat31 =InStr(f.name, session("img31"))
leresultat32 =InStr(f.name, session("img32"))
leresultat33 =InStr(f.name, session("img33"))
leresultat34 =InStr(f.name, session("img34"))
leresultat35 =InStr(f.name, session("img35"))
leresultat36 =InStr(f.name, session("img36"))
leresultat37 =InStr(f.name, session("img37"))
leresultat38 =InStr(f.name, session("img38"))
leresultat39 =InStr(f.name, session("img39"))
leresultat40 =InStr(f.name, session("img40"))

leresultat41 =InStr(f.name, session("img41"))
leresultat44 =InStr(f.name, session("img44"))
leresultat42 =InStr(f.name, session("img42"))
leresultat43 =InStr(f.name, session("img43"))
leresultat45 =InStr(f.name, session("img45"))
leresultat46 =InStr(f.name, session("img46"))
leresultat47 =InStr(f.name, session("img47"))
leresultat48 =InStr(f.name, session("img48"))
leresultat49 =InStr(f.name, session("img49"))
leresultat50 =InStr(f.name, session("img50"))






%>



<li>Mot recherché : <%=mot_recherche%>
<li>Resultat Instr : <%=leresultat%>





<%
if leresultat<>0 then
f.Delete
end if



if leresultat3<>0 then
f.Delete
end if
if leresultat4<>0 then
f.Delete
end if
if leresultat5<>0 then
f.Delete
end if
if leresultat6<>0 then
f.Delete
end if
if leresultat7<>0 then
f.Delete
end if
if leresultat8<>0 then
f.Delete
end if
if leresultat9<>0 then
f.Delete
end if
if leresultat10<>0 then
f.Delete
end if

if leresultat11<>0 then
f.Delete
end if
if leresultat12<>0 then
f.Delete
end if
if leresultat13<>0 then
f.Delete
end if
if leresultat14<>0 then
f.Delete
end if
if leresultat15<>0 then
f.Delete
end if
if leresultat16<>0 then
f.Delete
end if
if leresultat17<>0 then
f.Delete
end if
if leresultat18<>0 then
f.Delete
end if
if leresultat19<>0 then
f.Delete
end if
if leresultat20<>0 then
f.Delete
end if

if leresultat21<>0 then
f.Delete
end if
if leresultat22<>0 then
f.Delete
end if
if leresultat23<>0 then
f.Delete
end if
if leresultat24<>0 then
f.Delete
end if
if leresultat25<>0 then
f.Delete
end if
if leresultat26<>0 then
f.Delete
end if
if leresultat27<>0 then
f.Delete
end if
if leresultat28<>0 then
f.Delete
end if
if leresultat29<>0 then
f.Delete
end if
if leresultat30<>0 then
f.Delete
end if

if leresultat31<>0 then
f.Delete
end if
if leresultat32<>0 then
f.Delete
end if
if leresultat33<>0 then
f.Delete
end if
if leresultat34<>0 then
f.Delete
end if
if leresultat35<>0 then
f.Delete
end if
if leresultat36<>0 then
f.Delete
end if
if leresultat37<>0 then
f.Delete
end if
if leresultat38<>0 then
f.Delete
end if
if leresultat39<>0 then
f.Delete
end if
if leresultat40<>0 then
f.Delete
end if

if leresultat41<>0 then
f.Delete
end if
if leresultat42<>0 then
f.Delete
end if
if leresultat43<>0 then
f.Delete
end if
if leresultat44<>0 then
f.Delete
end if
if leresultat45<>0 then
f.Delete
end if
if leresultat46<>0 then
f.Delete
end if
if leresultat47<>0 then
f.Delete
end if
if leresultat48<>0 then
f.Delete
end if
if leresultat49<>0 then
f.Delete
end if
if leresultat50<>0 then
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


leresultat2 =InStr(f.name, session("img2"))



%>

<%
if leresultat2<>0 then
f.Delete
end if



Set FSO = nothing
%>
 
 <%next%>
 
  <%

 Dim rsDelete
rsDelete = "DELETE * FROM t_interviews WHERE num = " & Request.Querystring("num") & ""
Conn.Execute(rsDelete) 

  
Conn.close 
        Set Conn=nothing
        

'Response.Redirect("newposteditDelete.asp")
%>



<%Response.Redirect("p_admin_interview_modif.asp")%>

<% end if %>