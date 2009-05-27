<%
Option Explicit
response.buffer=True
%>
<%'format.inc, contains head and Foot function, optional.%>
<!--#INCLUDE FILE="format.inc"-->
<%'utils.inc, contains Log functions%>
<!--#INCLUDE FILE="utils.inc"-->
<%
'Sample custom file browser and multiple files/folders download with on-the-fly compression
'c1997-1998 PSTRUH Software, http://www.pstruh.cz


  'Compress exe files
  Const ARJPath = "arj.exe"
  Const PKZIPPath = "pkzip.exe"

  'This is the root folder of file browser. You can set this value to the any folder
  Dim PrimaryFolder
  PrimaryFolder = Server.MapPath(".")
  'PrimaryFolder = "c:\download\root"

'  BeginTimer 'Starts timer.
  If Request("PT") <> "" Or Request("A") <> "" Then 'download
    on error resume next
      'Try to download files
      DownloadFiles
      if Err<>0 then 'Dowload error, write folder with error message
        HTMLListFolder "<br>" & Err.Description
      end if
    on error goto 0
  Else
    HTMLListFolder ""'Write folder with no message
'    EndTimer 'Writes info about consumed time.
  End If
  

'Shows contents of folder as HTML with references to download files
Sub HTMLListFolder(Message)
  Dim Path
  Path = Request("Path")
  If Path = "" Then Path = "."
  'Security check - the user can access only subfolders of PrimaryFolder
  If Left(GetTranFileName(Path), Len(PrimaryFolder)) <> PrimaryFolder Then Path = "."
  If Len(GetTranFileName(Path)) <= Len(PrimaryFolder) Then Path = "."

  response.write Head("Sample custom file browser and multiple files/folders downloads - " & Path, "Demonstrates using of the ByteArray class (ScriptUtils library) for working with binary data and Respose.BinaryWrite method of ASP. Allows multiple files/folders download with on-the-fly compression.")
  response.write hDescription
  response.write CheckRequirements
  response.write "<b>" & Message & "</b>"
  Response.Write WriteFolder(Path)
  response.write Foot
End Sub

Function hDescription()
	Dim HTML

	HTML = HTML & "<Table Width=600><tr><td>"
	HTML = HTML & "    The file is sample of using <b><A Href=http://www.pstruh.cz/help/ScptUtl/upload.asp>Pure asp file upload</A></b> to download files with on-the-fly zip/arj. This script requires ScriptUtilities installed on server-side (does not work with PureASP upload)."
	HTML = HTML & "</td></tr></Table>"
	hDescription = HTML
End Function

'********************************** DownloadFiles **********************************
'Collect downloaded files, compress them and writes contents to the client.
Sub DownloadFiles()
  Dim ContentType, OutByteArray, PT
  PT = Request("PT")
  ContentType = "application/x-msdownload"
  If PT = "" And Request("File").Count = 1 Then 'One file without compression
    Set OutByteArray = GetFileAsBinary(GetTranFileName(Request("File")))  'Get file as byte array
  ElseIf Request("File").Count + Request("Path").Count = 0 Then 'None selected
    Err.Raise 1, "DownloadFiles", "None of files/folders was selected"
    Exit Sub
  Else 'Some more files/folders is selected
    Dim FS, TempFolderName, TempFolder, TempName, OutField

    'Create download temporary folder
    TempName = GetNextTempName()
    Set FS = CreateObject("scripting.filesystemobject")
    TempFolderName = GetTempPath() + "\" + TempName + "\"
    Set TempFolder = FS.CreateFolder(TempFolderName)

    'Copy each downloaded file to the temp folder
    For Each OutField In Request("File")
      FS.copyfile GetTranFileName(OutField), TempFolder.Path & "\"
    Next
    'Copy each downloaded folder to the temp folder
    For Each OutField In Request("Path")
      FS.copyfolder GetTranFileName(OutField), TempFolder.Path & "\"
    Next

    'Get compressed temp folder as binary data
    Set OutByteArray = GetFolderAsBinary(TempFolder, PT)  'Get byte array

    'Change content type
    If PT = "ZIP" Or PT = "ARJ" Then
      ContentType = "application/x-zip-compressed"
    End If

    'Delete temporary folder
    TempFolder.Delete
  End If
  'Output to the client.
  Response.ContentType = ContentType
  Response.AddHeader "Content-Disposition", "attachment;filename=""download." & PT & """"
  Response.BinaryWrite OutByteArray.ByteArray 'Write the file to client
  DoDownloadLog OutByteArray, PT
  OutByteArray = Empty 'Clear the variable
End Sub


'********************************** WriteFolder **********************************
'Writes contents of folder as HTML
Function WriteFolder(ByVal InputPath)
  Dim FyzPath
  FyzPath = GetTranFileName(InputPath)
  Dim FS, ShellObject, OutputFolder, InputFolder, File, FilesFolder
  Set FS = CreateObject("Scripting.FileSystemObject")
  on error resume next
    Set InputFolder = FS.GetFolder(FyzPath)
    'If error, set to PrimaryFolder
    If Err <> 0 Then Set InputFolder = FS.GetFolder(PrimaryFolder)
  On Error GoTo 0
  InputPath = Mid(InputFolder.Path, 2 + Len(PrimaryFolder))
  If InputPath = "" Then InputPath = "."

  'Write folders
  Response.Write "<Table Border=0  CellPadding=0 CellSpacing=0 BGColor=#E0E0E0 Style=""font-size:8pt;font-family:Arial,Arial CE,Helvetica,sans-serif"">"
  Response.Write "<Form>"
  Response.Write "<tr bgcolor=white><td colspan=4 bgcolor=black> <font color=white><b>Folder '" & InputPath & "' - subfolders</font> </td></tr>"
  Response.Write "<tr bgcolor=white><th> Folder </th><th></th><th> Size </th><th> Last modified </th></tr>"
  If InputPath <> "." Then Response.Write "<tr><td colspan=3> <a href=" & Request.ServerVariables("SCRIPT_NAME") & "?Path=" & InputPath & "/" & ".." & ">" & ".." & " </td></tr>"
  For Each FilesFolder In InputFolder.SubFolders
    Response.Write "<tr><td> "
    Response.Write "<input type=""CHECKBOX"" name=""path"" value=""" & InputPath & "/" & FilesFolder.Name & """>"
    Response.Write "<a href=" & Request.ServerVariables("SCRIPT_NAME") & "?Path=" & InputPath & "/" & FilesFolder.Name & ">" & FilesFolder.Name & "</a>"
    Response.Write " </td><td><font size=1> <a href=" & Request.ServerVariables("SCRIPT_NAME") & "?Path=" & InputPath & "/" & FilesFolder.Name & "&PT=ZIP>zip</a>"
    Response.Write " <a href=" & Request.ServerVariables("SCRIPT_NAME") & "?Path=" & InputPath & "/" & FilesFolder.Name & "&PT=ARJ>arj</a></font>"
    Response.Write " </td><td align=right> " & formatnumber(FilesFolder.Size, 0) & " </td><td> " & FilesFolder.DateLastModified
    Response.Write " </td></tr>"
  Next
  Response.Write "</table>"

  'Write files
  Response.Write "<Table Border=0  CellPadding=0 CellSpacing=0 BGColor=#E0E0E0 Style=""font-size:8pt;font-family:Arial,Arial CE,Helvetica,sans-serif"">"
  Response.Write "<tr bgcolor=white><td colspan=3 bgcolor=black> <font color=white><b>Folder '" & InputPath & "' - files</font> </td></tr>"
  Response.Write "<tr bgcolor=white><th> File </th><th> Size </th><th> Last modified </th></tr>"
  For Each File In InputFolder.Files
    Response.Write "<tr><td> "
    Response.Write "<input type=""CHECKBOX"" name=""File"" value=""" & InputPath & "/" & File.Name & """>"
    Response.Write "<a title=" & File.Name & " href=" & Request.ServerVariables("SCRIPT_NAME") & "?A=D&File=" & InputPath & "/" & File.Name & ">" & File.Name & "</a>"
    Select Case LCase(Right(File.Name, 3))
      Case "zip", "arj":
      Case Else:
        Response.Write "<font size=1> <a href=" & Request.ServerVariables("SCRIPT_NAME") & "?File=" & InputPath & "/" & File.Name & "&PT=ZIP>zip</a>"
        Response.Write " <a href=" & Request.ServerVariables("SCRIPT_NAME") & "?File=" & InputPath & "/" & File.Name & "&PT=ARJ>arj</a></font>"
    End Select
    Response.Write " </td><td align=right> " & formatnumber(File.Size, 0) & " </td><td> " & File.DateLastModified & " </td></tr>"
  Next
  Response.Write "<tr><td colspan=3> <Input Type=""Radio"" Name=""PT"" Value=""ZIP"" Checked>ZIP <Input Type=""Radio"" Name=""PT"" Value=""ARJ"">ARJ <Input type=Submit Value=""Download files/folders""> </td></tr>"
  Response.Write "<Input Type=""Hidden"" Name=""A"" Value=""D"">"
  Response.Write "</Form>"
  Response.Write "</table>"
End Function


'********************************** GetFolderAsBinary **********************************
'Returns folder as compressed binary Array.
Function GetFolderAsBinary(TempFolder, PT)
  Dim Binary, PAKCommand, TempName
  'Create safearray
  Set Binary = GetByteArray
  'Command for compress the folder
    Select Case PT
      Case "ZIP":
        Randomize
        TempName = TempFolder.Path & "\" & GetNextTempName() & ".ZIP" ' TempDIR
        PAKCommand = PKZIPPath & " -r -p -Jhrs " + TempName + " " + TempFolder.Path & "\*.*"
      Case "ARJ":
        Randomize
        TempName = TempFolder.Path & "\" & GetNextTempName() & ".ARJ"
        PAKCommand = ARJPath & " a -r -i " + TempName + " " + TempFolder.Path & "\*.*"
      Case Else:
        Err.Raise 1, "GetFolderAsBinary", "Compress method must be defined."
        Exit Function
    End Select
    Dim OK
    If PAKCommand <> "" Then
      'Run external program to compress folder
      If RunExe(PAKCommand) = 0 Then
        OK = True
      End If
    End If

'    If Not OK Then
'      'Some error - probably pkzip.exe or arj.exe is not in the path.
'      Err.Raise 1, "GetFolderAsBinary", "Error executing " & PAKCommand & "."
'      Exit Function
'    End If
  'Read compressed file from the disk
  Binary.ReadFrom TempName
  Set GetFolderAsBinary = Binary
End Function

'********************************** GetFileAsBinary **********************************
Function GetFileAsBinary(FileName)
  Dim Binary
  'Create safearray
  Set Binary = GetByteArray

  'Read file from the disk
  Binary.ReadFrom FileName
  Set GetFileAsBinary = Binary
End Function




'********************************** Utilities **********************************
'Returns ByteArray object. Solves problem with registration and installation
Function GetByteArray()
  On error resume next
  Dim Binary
  Set Binary = CreateObject("ScriptUtils.ByteArray") 'Creates ByteArray object
  'response.write hex(Err)
  If Err = &h46 then
    on error goto 0
    Err.Raise 5, "ScriptUtils.ByteArray", "Insufficient permissions to the scptult.ocx file. User: '" & GetUserName & "' must have read permission to the file."
  elseIf Err = &h1ad then
    on error goto 0
    Err.Raise 6, "ScriptUtils.ByteArray", "Script Utilities is not correctly installed. Please, install Script Utilities on this server or copy and register scptutl.ocx file on this server."
  elseIf Err = &h8007045A then
    on error goto 0
    Err.Raise 6, "ScriptUtils.ByteArray", "The evaluation version of Script Utilities was expired. Please install full version."
  elseIf Err = &h8007007E then
    on error goto 0
    Err.Raise 6, "ScriptUtils.ByteArray", "The ScriptUtilities library (scptutl.ocx) is missing. Please copy the library or reinstall the software."
  elseIf Err <> 0 then
    Dim E, N
    N = Hex(Err)
    E = Err.Description
    on error goto 0
    Err.Raise 6, "ScriptUtils.ByteArray", "Cannot create ScriptUtils.ByteArray object, Error: '" & N & " " & E & "'"
  end if
  Set GetByteArray = Binary
End Function

'Runs command and wait for exit
Function RunExe(Command)
  On Error Resume Next
  Dim ShellObject, Res, Msg
  Set ShellObject = CreateObject("WScript.Shell")
  Res = ShellObject.Run(Command, 1, True) & vbCrLf
  ShellObject = Empty
  If Err <> 0 Then
    Msg = "Error executing " & Command & ". (" & Hex(Err.Number) & ", " & Err.Description & ")"
    On Error goto 0
    Err.Raise 1, "RunExe", Msg
    Res = Err
  elseif Res<>0 then
    Msg = "Error executing " & Command & ". (ErrorLevel:" & Res & ""
    On Error goto 0
    Err.Raise 1, "RunExe", Msg
  End If
  RunExe = Res
  On Error GoTo 0
End Function

'Returns temporary folder
Function GetTempPath()
  Dim TempPath, Kernel
  TempPath = CreateObject("ScriptUtils.Kernel").TempPath ' Temp path is system temp path
  If Right(TempPath, 1) <> "\" Then TempPath = TempPath + "\"
'  TempPath = Server.MapPath(".")' Temp path is path of the script.
  GetTempPath = TempPath
End Function

'The function returns temp name
Function GetNextTempName()
  Randomize
  GetNextTempName = Right("0" & Minute(Now), 2) & Right("0" & Second(Now), 2) & CLng(Rnd() * 9999)
End Function

'The function combines relative name with PrimaryFolder
Function GetTranFileName(RelativeName)
  Dim OutName
  RelativeName = replace(RelativeName, "/", "\")
  OutName = PrimaryFolder & "\" & RelativeName
  GetTranFileName = OutName
End Function

Sub DoDownloadLog(OutByteArray, PT)
  Const LogSeparator = ", "
  Dim LogLine, pLogLine, OutField
  'Copy name of the each downloaded file the log line
  For Each OutField In Request("File")
    LogLine = LogLine & OutField & LogSeparator
  Next
  'Copy name of the each downloaded folder the log line
  For Each OutField In Request("Path")
    LogLine = LogLine & OutField & LogSeparator
  Next
  LogLine = Left(LogLine, Len(LogLine) - Len(LogSeparator))

  'Creates line with global request info
  pLogLine = pLogLine & Request.ServerVariables("REMOTE_ADDR") & LogSeparator
  pLogLine = pLogLine & LogF(Request.ServerVariables("LOGON_USER")) & LogSeparator
  pLogLine = pLogLine & OutByteArray.Length & LogSeparator
  pLogLine = pLogLine & LogF(PT) & LogSeparator

  'Log consumed time
on error resume next
  pLogLine = pLogLine & LogF(Kernel.TickCount - TickCount) & LogSeparator
  pLogLine = pLogLine & LogF(CLng((Kernel.CurrentThread.KernelTime - KernelTime) * 86400000)) & LogSeparator
  pLogLine = pLogLine & LogF(CLng((Kernel.CurrentThread.UserTime - UserTime) * 86400000)) & LogSeparator
on error goto 0

  pLogLine = pLogLine & PrimaryFolder & LogSeparator
  pLogLine = pLogLine & """" & LogLine & """" & LogSeparator
  pLogLine = pLogLine & LogF(Request.ServerVariables("HTTP_USER_AGENT")) & LogSeparator
  pLogLine = pLogLine & LogF(Request.ServerVariables("HTTP_COOKIE"))
  DoLog pLogLine, "DW"
End Sub

'************** Special utilities
'Checks if all of required objects are installed
Function CheckRequirements()
  Dim Msg
  Msg = "<br><b>This script requires some objects installed to run properly.</b><br>" & vbCrLf

  Msg = Msg & CheckOneObject("ScriptUtils.Kernel")
  Msg = Msg & CheckOneObject("ScriptUtils.ByteArray")
  Msg = Msg & CheckOneObject("Scripting.FileSystemObject")
  Msg = Msg & CheckOneObject("WScript.Shell")
  
  CheckRequirements = Msg
'  MsgBox Msg
End Function

'Checks if the one object is installed.
Function CheckOneObject(oClass)
  Dim Msg
  On Error Resume Next
  CreateObject oClass
  If Err = 0 Then Msg = "OK" Else Msg = "Error:" & Hex(Err.Number) & "," & Err.Description
  CheckOneObject = oClass & " - " & Msg & "<br>" & vbCrLf
End Function
'************** Special utilities - end
%>

