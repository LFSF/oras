<%
Option Explicit

Dim Action: Action = ucase(Request.QueryString("Action"))

Dim CurrentFolder
Dim CurrentPath

'Get destination folder/disk path for the data
CurrentFolder = Request.QueryString("Folder")
if len(CurrentFolder) = 0 then
  CurrentFolder = Request.Cookies("Folder")
end if
if instr(CurrentFolder, "..") then CurrentFolder = ".."
if len(CurrentFolder)=0 then CurrentFolder = "."


'Create destination folder if it does not exists.
CreateFolder CurrentPath


Dim HTML
select case Action
  Case "UPLOAD" : HTML = do_Upload (CurrentFolder)
  Case "MKDIR" : HTML = do_CreateFolder(CurrentFolder)
  Case "CHDIR" : HTML = do_ChangeFolder(CurrentFolder)
  Case "RMDIR" : HTML = do_Delete(CurrentFolder, Action)
  Case "RMFILE" : HTML = do_Delete(CurrentFolder, Action)
End Select


'Top header, styles.
GetMainHeader
'Left Menu - upload, folder.
Response.write GetMenu

Response.write "<Div Style=Width=483>"
Response.write HTML 
Response.write FolderContents(CurrentFolder)
Response.write "</Div>"
GetMainFooter
%><!--#INCLUDE FILE="_upload.asp"--><% 
'************************ do_Upload
'Accepts uploads and returns upload form.
Function do_Upload(rel_Folder)
  Server.ScriptTimeout = 3600
'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm 
  '{b}Set the upload ID for this form.
  'Progress bar window will receive the same ID.
  Form.UploadID = Request.QueryString("UploadID")'{/b}

  Form.SizeLimit = 10*1024*1024 '10MB

  Dim HTML, hResult
  Const fsCompletted  = 0
  Const fsSizeLimit   = &HD
  Const fsTimeOut     = &HE
  Const fsError       = &HA
  
  If Form.State > fsError Then 'Some error state. 
    If Form.State = fsSizeLimit Then 'Data size exceeds limit. 
      hResult = "Upload size (" & Request.TotalBytes/1024 & "B) exceeds limit (" & Form.SizeLimit/1024 & "kB)."
    ElseIf Form.State = fsTimeOut Then 'Request timeout 
      hResult = "Upload time exceeds limit (" & Form.ReadTimeout & "s)."
    Else
      hResult = "Another upload problem (code " & Form.State & ")"
    End If
    hResult = "<Font Color=Red>" & hResult & "</Font><br>"
    Response.Status = "400 Bad request"
  ElseIf Form.State = fsCompletted Then 'Completted
    Form.Files.Save MapFolderToDisk(rel_Folder)
    hResult = "Files was saved to " & rel_Folder & " folder."
    hResult = "<Font Color=Green>" & hResult & "</Font><br>"
  ElseIf Request.QueryString("Action") = "Cancel" Then   
    hResult = "Upload was cancelled."  
  End If 

  '{b}get an unique upload ID for this upload script and progress bar.
  Dim UploadID, PostURL
  UploadID = Form.NewUploadID

  HTML = HTML & hResult
  HTML = HTML & "Upload files to '" & rel_Folder & "' folder. Limit:" & Form.SizeLimit/1024 & "kB.<br>"
  HTML = HTML & "<form method=post ENCTYPE=multipart/form-data Action=" & ref("UploadID=" & UploadID & "&Action=UPLOAD") & " OnSubmit=""return ProgressBar();"">"
  HTML = HTML & "<Input Type=Button Value=""+Add a file"" OnClick=Expand()>  <input type=submit value=""Upload files &gt;&gt;""><br>"
  HTML = HTML & "<Div ID=files> File 1 : <input type=file name=File1></Div>"
  HTML = HTML & "</Form>"
  HTML = HTML & "<"+"Script>var nfiles = 1;"
  HTML = HTML & "function Expand(){"
  HTML = HTML & "nfiles++;"
  HTML = HTML & "files.insertAdjacentHTML('BeforeEnd','<BR>File '+nfiles+' : <input type=file name=File'+nfiles+'>');"
  HTML = HTML & "};"
  HTML = HTML & "function ProgressBar(){" & vbCrLf
  HTML = HTML & "  var ProgressURL;" & vbCrLf
  HTML = HTML & "  ProgressURL = 'progress.asp?UploadID=" & UploadID & "'" & vbCrLf
  HTML = HTML & "  var v = window.open(ProgressURL,'_blank','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=350,height=200')" & vbCrLf
  HTML = HTML & "  return true;" & vbCrLf
  HTML = HTML & "};" & vbCrLf
  HTML = HTML & "</"+"Script>"
  HTML = HTML & ""
  do_Upload = HTML
End Function



'************************ do_DeleteFolder
'Delete folder Request("NewFolder")
Function do_Delete(rel_Path, Action)
  Dim NewName, DiskName: NewName = Request("Name")
  Dim HTML

  'Is the Folder/File specified?
  if len(NewName)>0 and instr(NewName, "..")=0 then

    'Get disk path to the Folder/File
    DiskName = MapFolderToDisk(rel_Path & "\" & NewName)

    if Action="RMDIR" then
      'Delete the folder
      DeleteFolder DiskName
    else
      'Delete the file
      DeleteFile DiskName
    end if

    'Are there some problems?
    if Err<>0 then
      HTML = "<Font Color=Red>Error delete: " & Err.Description & "</Font>"
    else
      HTML = "<Font Color=Green>Folder/File '" & NewName & "' was deleted.</Font>"
    end if
  end if
  do_Delete = HTML
End Function 

'************************ do_CreateFolder
'Create a new folder Request("NewFolder")
Function do_CreateFolder(rel_Folder)
  Dim NewFolder, DiskFolder: NewFolder = Request("NewFolder")

  Dim HTML
  'Is the folder specified?
  if len(NewFolder)>0 and instr(NewFolder, "..")=0 then
    
    'Get disk path to the new folder
    DiskFolder = MapFolderToDisk(rel_Folder & "\" & NewFolder)

    'Create the folder
    CreateFolder DiskFolder

    'Are there some problems?
    if Err<>0 then
      HTML = "<Font Color=Red>Error create folder: " & Err.Description & "</Font>"
    else
      HTML = "<Font Color=Green>Folder '" & NewFolder & "' was created.</Font>"
    end if
  end if

  'HTML form to create folder
  HTML = HTML & "<form method=post Action=" & ref("Action=MKDIR") & ">"
  HTML = HTML & "<input type=submit value=""Create Folder &gt;&gt;""><br>"
  HTML = HTML & "<Div ID=files> New folder name : <input name=NewFolder></Div>"
  HTML = HTML & "</Form>"
  do_CreateFolder = HTML
End Function

'************************ do_ChangeFolder
'Change the current folder to Request("NewFolder") 
Function do_ChangeFolder(rel_Folder)
  Dim NewFolder: NewFolder = Request("NewFolder")

  if instr(NewFolder, "..") then 
    'one level up
    Dim Pos: Pos = instrrev(rel_Folder, "\")
    if Pos>0 then
      NewFolder = left(rel_Folder, Pos-1)
    else
      NewFolder = "."
    end if
  elseif NewFolder = "." then
    'go to root folder
    NewFolder = NewFolder    
  else
    'go to a new folder.
    NewFolder = rel_Folder & "\" & NewFolder
  end if

  'Does the folder exists?
  On Error Resume next
  Dim FS, Folder
  Set FS = CreateObject("scripting.filesystemobject")
  Set Folder = FS.GetFolder(MapFolderToDisk(NewFolder))

  Dim HTML
  if Err=0 then
    'the folder exists. Change current folder, set cookie
    rel_Folder = NewFolder
    CurrentFolder = NewFolder
    response.cookies("Folder") = CurrentFolder
  else
    'Some problem with folder.
    HTML = "<Font Color=Red>Error change folder: " & Err.Description & "</Font>"
  end if
  do_ChangeFolder = HTML 
End Function 


'************************ FolderContents
'Get folder contents as a HTML file.
Function FolderContents(rel_Folder)
  Dim FS, Folder, F, HTML
  Set FS = CreateObject("scripting.filesystemobject")
  Set Folder = FS.GetFolder(MapFolderToDisk(rel_Folder))

  'Table header
  HTML = HTML & "<Table CellPadding=1 CellSpacing=0 Class=TableList>"
  HTML = HTML & "<TR><TH ColSpan=2>Contents of '" & rel_Folder & "' folder.</th></tr>"
  if rel_Folder<>"." then
    HTML = HTML & "<TR><TD><A Href=" & ref("Action=CHDIR&NewFolder=.") & ">/</A><TD Align=Right>-</TR>"
    HTML = HTML & "<TR><TD><A Href=" & ref("Action=CHDIR&NewFolder=..") & ">..</A><TD Align=Right>-</TR>"
  end if

  HTML = HTML & "<TR><TH>FileName</TH><TH>FileSize<TH></tr>"

  'List of folder files
  HTML = HTML & "<TR><TH ColSpan=2 Align=Left>Files (" & Folder.Files.Count & ").</th></tr>"
  For Each F in Folder.Files
    HTML = HTML & "<TR><TD>" 
    HTML = HTML & "<A OnClick=""return dp('"  & F.Name &  "')"" Href=""" & ref("Action=RMFILE&Name=") & F.Name & """ Title=""Delete file " & F.Name & " ."">X</A>&nbsp;"
    HTML = HTML & F.Name & "<TD Align=Right>" & FormatNumber(F.Size,0) & "B</TR>"
  Next


  'Links to root and up folders  
  HTML = HTML & "<TR><TH ColSpan=2 Align=Left>SubFolders (" & Folder.SubFolders.Count & ").</th></tr>"

  'List of folder subfolders
  For Each F in Folder.SubFolders
    HTML = HTML & "<TR><TD>"
    HTML = HTML & "<A OnClick=""return dp('"  & F.Name &  "')"" Href=""" & ref("Action=RMDIR&Name=") & F.Name & """ Title=""Delete folder " & F.Name & " ."">X</A>&nbsp;"
    HTML = HTML & "<A Href=""" & ref("Action=CHDIR&NewFolder=") & F.Name & """>" & F.Name & "</A><TD Align=Right>" & FormatNumber(F.Size,0) & "B</TR>"
  Next
  HTML = HTML & "</Table>" & vbCrlF



  HTML = HTML & "<"+"Script>"
  HTML = HTML & "function dp(FileName){if(confirm('Are you sure to delete '+FileName+ ' ?')){return true;};else return false;};"
  HTML = HTML & "</"+"Script>"
  FolderContents = HTML
End Function 

Sub GetMainFooter
%>
<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>© 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.pstruh.cz">PSTRUH Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.pstruh.cz/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>
</Div>
</BODY></HTML>
<%
End Sub

Sub GetMainHeader
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - sample file manager.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://www.pstruh.cz/help/scptutl/upload.asp">Power ASP 
      file upload/download</A> - sample file manager.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates using of Huge ASP file upload to accept files and store them on server-side folder. 
			<br>Primary upload folder is <%=PrimaryFolder%>


			</P>
  </TD></TR></TABLE>

<%
End Sub
%>

<!--#INCLUDE FILE="_common.asp"-->
