<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" /> 
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />

<SCRIPT>
//Open window with progress bar.
function ProgressBar(){
  var ProgressURL
  ProgressURL = 'progress.asp?UploadID=<%=UploadID%>'

  var v = window.open(ProgressURL,'_blank','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=350,height=200')
  
  return true;
}
</SCRIPT> 

<Script>
//Expand form with a new File fields if needed.
var nfiles = 10;
function Expand(){
  nfiles++
  var adh = '<br/> File '+nfiles+' : <input type="file" name="File'+nfiles+'"> Description '+nfiles+' : <Input Name="Desc-File'+nfiles+'" Size=50>';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
}
</Script>
</head>
<body>
<%
espace="&#034;"
simplecot="&#039;"

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
  Dim RS: Set RS = OpenUploadRS


  Dim FileField
  For Each FileField in Form.Files.Items
  
    'Fo each file sent
    if len(FileField.FileName)> 0 then 'File is specified.
	if FileField.Length<1024*1024 then 
      Dim DestinationFileName
	  compteur = compteur +1

	  FileField.FileName= "ACTU" &compteur &hour(now()) &minute(now()) &second(now()) &FileField.FileName
	  FileField.FileName=Replace(FileField.FileName,"'","_")
      DestinationFileName = DestinationPath & FileField.FileName

      'Save file to physical location
      FileField.SaveAs DestinationFileName
      
      'Store extra info about upload to database
      RS.AddNew
	  '*****Ancienne Base******
		   'RS("UploadDT") = Now()
		   'RS("Description") = Form("Desc-" & FileField.Name)
		   'RS("NomImg")= FileField.FileName
		   'RS("SourceFileName") = virtDestinationPath & FileField.FileName
		   'RS("DestFileName") = DestinationFileName
		   'RS("DataSize") = FileField.Length
       '*******Fin Ancienne Base ******
	   RS("PieceJointesActu") = FileField.FileName
      RS.Update
	 
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

  'Open dynamic recordset, table Upload
  RS.Open "ACTUALITE", GetConnection, 2, 2
  
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

response.redirect("valider_p_admin_actu_insert.asp")
%>

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar();" Action="<%=PostURL%>">

<Div ID=files>
   File 1 : <input type="file" name="File1"> Description 1 : <Input Name="Desc-File1" Size=25><br/>
</Div>

<Input Type=Button Value="Add a file" OnClick=return(Expand()) Style="border=0;background=yellow;cursor:hand"><br/>
<input Name=SubmitButton Value="Upload" Type=Submit><br/>
</Form>

<br/><br/>
<div style="border-bottom: #A91905 2px solid;font-size:16">Upload files to your server</div>

<!-- Please support this free script by having a link to freeaspupload.net either in this page or somewhere else in your site. -->
<div style="border-bottom: #A91905 2px solid;font-size:10">Powered by <A HREF="http://www.freeaspupload.net/" style="color:black">Free ASP Upload</A></div>

<br/><br/>



</BODY>
</HTML>
