<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp" -->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
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
<%if  session("compatible_IE6")="OUI" then%>
<body  bgcolor="#bcbaa6" onload="init()" leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<%else%>
<body  bgcolor="#bcbaa6" = leftmargin="0" topmargin="8" marginwidth="0" marginheight="0" >
<!--<div style="z-index:5;">
<SCRIPT LANGUAGE="JavaScript" SRC="ejs_menu_dyn.js">
</SCRIPT>-->
<%end if


    espace="&#034;"
    simplecot="&#039;"


    'Enregistrement de l'actu dans la base de données

SQL="SELECT * FROM ACTUALITE"
Set rsED1 = server.createobject("ADODB.Recordset")
rsED1.Open SQL, Conn, 3, 3

rsED1.addnew

rsED1("NumMembre")=replace(REPLACE(session("admin_id"),"""",espace),"'",simplecot)
rsED1("DateActu")=replace(REPLACE(session("date"),"""",espace),"'",simplecot)

'rsED1("TitreActu")=replace(REPLACE(session("titre"),"""",espace),"'",simplecot)

'Test avec HtmlEncode
rsED1("TitreActu")=Server.HtmlEncode(session("titre"))

'rsED1("ArticleActu")=replace(REPLACE(session("MessageActu"),"""",espace),"'",simplecot)
'Test avec rien
rsED1("ArticleActu")=session("MessageActu")
rsED1("Visible")=0



    'Enregistrement du fichier joint dans la base de données

'Sample file Field-SaveAs.asp 
'Store extra upload info to a database
' and file contents to the disk
Server.ScriptTimeout = 5000

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 1000


'Form.SizeLimit = 10240*1024'10MB
Form.SizeLimit = 1024*10240'

'{b}Set the upload ID for this form.
'Progress bar window will receive the same ID.
if len(Request.QueryString("UploadID"))>0 then
  Form.UploadID = Request.QueryString("UploadID")'{/b}
end if
'was the Form successfully received?
Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted
  Const VirtualFolder = "UploadFolder/Actu"

  'Create destination path+filename for the source file.
  'Create an URL for image.
  Dim DestinationPath, virtDestinationPath
  DestinationPath = Server.mapPath(VirtualFolder) & "\"
  virtDestinationPath = "http://" + Request.ServerVariables("SERVER_NAME") _
  
   + GetPath(Request.ServerVariables("SCRIPT_NAME") ) _
   + VirtualFolder + "/"

  'Open recordset to store uploaded data
  'Dim RS: Set RS = OpenUploadRS


  Dim FileField
  For Each FileField in Form.Files.Items
  
    'Fo each file sent
    if len(FileField.FileName)> 0 then 'File is specified.
    if FileField.Length<1024*1024 then 
      Dim DestinationFileName
      compteur = compteur +1

      FileField.FileName= "ACTU" & compteur & hour(now()) & minute(now()) & second(now()) & FileField.FileName
      FileField.FileName=Replace(FileField.FileName,"'","_")
      DestinationFileName = DestinationPath & FileField.FileName

      'Save file to physical location
      FileField.SaveAs DestinationFileName
      
      'Store extra info about upload to database
      'RS.AddNew
      '*****Ancienne Base******
           'RS("UploadDT") = Now()
           'RS("Description") = Form("Desc-" & FileField.Name)
           'RS("NomImg")= FileField.FileName
           'RS("SourceFileName") = virtDestinationPath & FileField.FileName
           'RS("DestFileName") = DestinationFileName
           'RS("DataSize") = FileField.Length
       '*******Fin Ancienne Base ******
       'RS("PieceJointesActu") = FileField.FileName
       rsED1("PieceJointesActu") = FileField.FileName
      rsED1.Update
      'RS.Update
     
else
response.write("Fichier superieur a 1meg")   
end if
   end if

  Next
  '{b}Save file to the destination
  '{/b}

'  response.write "<Font color=green><br/>SourceFile was saved as " & DestinationFileName
'  response.write "<br/>See ListFiles table in " & Server.MapPath("upload.mdb") & " database.</Font>"

ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
    case fsSizeLimit: response.write  "<br/><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br/>"
    case else response.write "<br/><Font Color=red>Some form error.</Font><br/>"
  end Select
End If'Form.State = 0 then



Function OpenUploadRS()
  Dim RS  : Set RS = CreateObject("ADODB.Recordset")
  SQL = "SELECT * FROM ACTUALITE WHERE NumActu = " & rsED1("NumActu")
  'Open dynamic recordset, table Upload
  RS.Open SQL, GetConnection, 3, 3
  
  Set OpenUploadRS = RS
end Function 

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.open "Data Source=" & Server.MapPath("bd/Upload.mdb") 
  set GetConnection = Conn
end function

Function SplitFileName(FullPath)
  Dim Pos, PosF
  PosF = 0
  For Pos = Len(FullPath) To 1 Step -1
    Select Case Mid(FullPath, Pos, 1)
      Case ":", "/", "\": PosF = Pos + 1: Pos = 0
    End Select
  Next
  If PosF = 0 Then PosF = 1
 SplitFileName = PosF
End Function

Function GetPath(FullPath)
  GetPath = left(FullPath, SplitFileName(FullPath)-1)
End Function




'{b}get an unique upload ID for this upload script and progress bar.
Dim UploadID, PostURL
UploadID = Form.NewUploadID

'Send this ID as a UploadID QueryString parameter to this script.
PostURL = Request.ServerVariables("SCRIPT_NAME") & "?UploadID=" & UploadID'{/b}

rsED1.update
rsED1.Close


response.redirect("valid_p_admin_actu_insert.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>