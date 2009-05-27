<html>
<head>
<title>Rhône-solidarité</title>

<link rel="stylesheet" href="style.css" type="text/css">
<script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}
<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>
<%if  session("compatible_IE6")="OUI" then
%>
<body  bgcolor="#bcbaa6" onload="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%else%>
<body  bgcolor="#bcbaa6"  leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<!--<div style="z-index:5;">
<SCRIPT LANGUAGE="JavaScript" SRC="ejs_menu_dyn.js">
</SCRIPT>-->
<%end if%>

<%

Verif = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= " & Server.MapPath("upload.mdb")

 Set connv = Server.CreateObject("ADODB.Connection")
 connv.Open Verif
 Set rsv = Server.CreateObject("ADODB.RecordSet")
      

 SQL1 = "Select Max(NumMembre) as num from [MEMBRE]"
 
  rsv.open SQL1,connv,1,3


'for i=0 to rsv.EOF
	cv = rsv.fields("num")
	'response.write(cv)
	'rsv.MoveNext
'next


cvn = cv+1

rsv.Close
set rsv = Nothing
connv.Close
set connv= Nothing

jour = day(date())
if (jour<10) then
	jour = "0" & jour
end if
mois = Month(Date())
if (mois<10) then
	mois = "0" & mois
end if
if cvn <10 then

num = "CV" & year(date()) & mois & jour & "000" &cvn

end if

if cvn >9 and  cvn<100 then

num = "CV" & year(date()) & mois & jour & "00" &cvn

end if

if cvn >99 and  cvn<999 then

num = "CV" & year(date()) & mois & jour & "0" &cvn

end if
%>

<%
  	espace="&#034;"
	simplecot="&#039;"
               
dbPath = Server.MapPath("upload.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath


SQL="SELECT * FROM [MEMBRE]"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
 '--code de la structure----------------------
 RS("NumMembre")=replace(REPLACE(num,"""",espace),"'",simplecot) 
 RS("NomMembre")=replace(REPLACE(session("nom"),"""",espace),"'",simplecot)
 RS("PrenomMembre")=replace(REPLACE(session("prenom"),"""",espace),"'",simplecot)
 RS("TelMembre	")=replace(REPLACE(session("tel"),"""",espace),"'",simplecot)
 RS("MailMembre")=replace(REPLACE(session("email"),"""",espace),"'",simplecot)
 RS("AdrMembre")=replace(REPLACE(session("adresse"),"""",espace),"'",simplecot)

RS.update
rs.Close
set rs = Nothing
conn.Close
set conn= Nothing
%>


<%



 
 ' -----------------envoi information au destinataire ------------------------           
Dim ObjSendMail
Set ObjSendMail = CreateObject("CDO.Message") 
     
'This section provides the configuration information for the remote SMTP server.
     
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
ObjSendMail.Configuration.Fields.Update
 


'End remote SMTP server configuration section==
     

ObjSendMail.To = session("email")
'ObjSendMail.To = "cerclerat.t@gmail.com"
ObjSendMail.Subject = "Validation d'un nouvel utilisateur"
ObjSendMail.From = "cerclerat.t@gmail.com"
     
' we are sending a text email.. simply switch the comments around to send an html email instead
ObjSendMail.HTMLBody = "Bonjour " &  session("civilite") & " " &  session("prenom") & " " & session("nom") &   "<br><br>Votre CV  a bien été enregistré sur le site www.rhone-solidarite.com .<br>Merci pour la confiance que vous nous accordez. <br><br> Le service des annonces de  Rhone-solidarite.com"

ObjSendMail.Send
     
Set ObjSendMail = Nothing  
%>

<%

response.redirect("valid_mail.asp")

%>
</body>
</html>