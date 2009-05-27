<Script language=VBScript runat=Server>
'************************ Utilities

'Reference to current script
Function ref(Where)
  ref = request.ServerVariables("SCRIPT_NAME") & "?" & Where
End Function 

'Relative-to-absolute folder mapping
Function MapFolderToDisk(rel_Folder)
  

  MapFolderToDisk = PrimaryFolder & "\" & rel_Folder
End Function 

Dim gPrimaryFolder
Function PrimaryFolder
	if isempty(gPrimaryFolder) then
		gPrimaryFolder = Server.MapPath("../UploadFolder")
		Dim FS: Set FS = CreateObject("scripting.filesystemobject")
		
		if not FS.FolderExists(gPrimaryFolder) then FS.CreateFolder gPrimaryFolder
	end if
	PrimaryFolder = gPrimaryFolder
End Function

'Create a new folder
Sub CreateFolder(FolderName)
  On error resume next
  Dim FS, TempFolder
  Set FS = CreateObject("scripting.filesystemobject")
  Set TempFolder = FS.CreateFolder(FolderName)
End Sub

'Delete the folder
Sub DeleteFolder(Name)
  On error resume next
  if len(Name)>4 then
    Dim FS
    Set FS = CreateObject("scripting.filesystemobject")
    FS.DeleteFolder(Name)
  End If
End Sub

'Delete file
Sub DeleteFile(Name)
  On error resume next
  if len(Name)>4 then
    Dim FS
    Set FS = CreateObject("scripting.filesystemobject")
    FS.DeleteFile(Name)
  End If
End Sub


'Get main menu.
Function GetMenu()
  Dim HTML
  HTML = HTML & "<Table Width=150 Align=Left Border=0 CellPadding=1 CellSpacing=0 Class=Menu>"
  HTML = HTML & "<TR><TH>Actions.</th></tr>"
  HTML = HTML & "<TR><TD> <A Href=manage.asp?Action=MKDIR>Create Folder</A></tD></tr>"
  HTML = HTML & "<TR><TD> <A Href=manage.asp?Action=UPLOAD>File Upload</A></tD></tr>"
  HTML = HTML & "<TR><TD> <A Href=download.asp>File Download</A></tD></tr>"
  HTML = HTML & "</Table>"
  GetMenu = HTML
End Function 

'Get header of page.
Function zGetMainHeader()
  Dim HTML
  HTML = "<HTML><Head><Title>Simple file management - Huge-ASP Upload/Download sample</Title></Head><Body>"
  HTML = HTML & "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sample of ScriptUtilities Huge-ASP upload. You can upload files and create/delete folders/files.<br>"
  HTML = HTML & "Root folder: " & MapFolderToDisk(".") & "<br><br>"
  zGetMainHeader = HTML
End Function
'************************ Utilities - end
</Script>
