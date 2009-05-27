<%
'Sample file Field-SaveAs.asp 
'Store extra upload info to a database
' and file contents to the disk
Server.ScriptTimeout = 5000

'On recupere l'identifiant de l'interview pour l'associer a l'image
numitwimg = request.querystring("numitw")
if numitwimg = "" then
numitwimg = 1
end if

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
  Const VirtualFolder = "UploadFolder"

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
	  FileField.FileName= "toto" & FileField.FileName

      DestinationFileName = DestinationPath & FileField.FileName

      'Save file to physical location
      FileField.SaveAs DestinationFileName
      
      'Store extra info about upload to database
      RS.AddNew
	   RS("NomImg") = FileField.FileName
       RS("DescriptionImg") = Form("Desc-" & FileField.Name)
       RS("SourceFileName") = virtDestinationPath & FileField.FileName
       RS("UrlImg") = DestinationFileName
       RS("NumItw") = numitwimg
       '...
      RS.Update
else
response.write("Fichier superieur a 1Mo")   
end if
   end if

  Next 

  'What to do with Form("Description")?
  Response.write "<br>Source file names:"
  Dim Field: For Each Field in Form.Files.Items
    Response.write "<br>&nbsp;" & Field.FileName
  Next
  '{b}Save file to the destination
  '{/b}

'  response.write "<Font color=green><br>SourceFile was saved as " & DestinationFileName
'  response.write "<br>See ListFiles table in " & Server.MapPath("upload.mdb") & " database.</Font>"

ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
    case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
    case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then



Function OpenUploadRS()
  Dim RS  : Set RS = CreateObject("ADODB.Recordset")

  'Open dynamic recordset, table IMAGE
  RS.Open "IMAGE", GetConnection, 2, 2
  
  Set OpenUploadRS = RS
end Function 

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.open "Data Source=" & Server.MapPath("bd/bd_int.mdb") 
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

%>  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload sample.</TITLE>
 <STYLE TYPE="text/css"><!--TD  {font-family:Arial,Helvetica,sans-serif }TH  {font-family:Arial,Helvetica,sans-serif }TABLE  {font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>



<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - upload multiple files to a disk, store extra file upload info in a database&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demontrates using 
      of Huge-ASP file upload to upload files to server and store file path in server-side database. 
      The sample ASP file is running with Microsoft.Jet.OLEDB (MDB) connection, but you can use it 
      with any other SQL server or file drivers (MS SQL server, Oracle, MySQL, FoxPro driver, etc.).
      </P>
<P>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You can select source file and write some description of the file.
Source file is stored on server disk. Description, file name, file size and path to stored file are saved in server-side database along with current upload time.
</P>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Form size limit is <%=Form.SizeLimit%>B (<%=Form.SizeLimit \ 1024 %>kB - you can change it, see source) .
  </TD></TR></TABLE>




<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar();" Action="<%=PostURL%>">

<Div ID=files>
   File 1 : <input type="file" name="File1"> Description 1 : <Input Name="Desc-File1" Size=50><br>
   File 2 : <input type="file" name="File2"> Description 2 : <Input Name="Desc-File2" Size=50><br>
   File 3 : <input type="file" name="File3"> Description 3 : <Input Name="Desc-File3" Size=50><br>
   File 4 : <input type="file" name="File4"> Description 4 : <Input Name="Desc-File4" Size=50><br>
File 5 : <input type="file" name="File5"> Description 5 : <Input Name="Desc-File5" Size=50><br>
File 6 : <input type="file" name="File6"> Description 6 : <Input Name="Desc-File6" Size=50><br>
   File 7 : <input type="file" name="File7"> Description 7 : <Input Name="Desc-File7" Size=50><br>
     File 8 : <input type="file" name="File8"> Description 8 : <Input Name="Desc-File8" Size=50><br>
	File 9 : <input type="file" name="File9"> Description 9 : <Input Name="Desc-File9" Size=50><br>
	File 10 : <input type="file" name="File10"> Description 10 : <Input Name="Desc-File10" Size=50>
</Div>

<Input Type=Button Value="Add a file" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"><br>

Description: <input Name=Description Size=60><br>
<input Name=SubmitButton Value="Submit »" Type=Submit><br>
</Form>

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
  var adh = '<BR> File '+nfiles+' : <input type="file" name="File'+nfiles+'"> Description '+nfiles+' : <Input Name="Desc-File'+nfiles+'" Size=50>';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
}
</Script>


<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>© 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.motobit.com">Motobit Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.motobit.com/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>

</BODY></HTML>
