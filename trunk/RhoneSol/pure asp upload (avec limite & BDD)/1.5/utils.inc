<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>
'All uploaded files and log file will be saved to the next folder :
Dim LogFolder
LogFolder = Server.MapPath(".")
Const LogSeparator = ", "

'********************************** SaveUpload **********************************
'This function creates folder and saves contents of the source fields to the disk.
'The fields are saved as files with names of form-field names.
'Also writes one line to the log file with basic informations about upload.
Function SaveUpload(Fields, DestinationFolder, LogFolder)
  If DestinationFolder = "" Then DestinationFolder = Server.MapPath(".")

  Dim OutFileName, FS, OutFolder, FolderName, Field
  Dim LogLine, pLogLine, OutLine

  'Create unique upload folder
  FolderName = UniqueFolderName

  Set FS = CreateObject("scripting.filesystemobject")
  Set OutFolder = FS.CreateFolder(DestinationFolder + "\" + FolderName)

  Dim SaveFileName
  'Save the uploaded fields and create a log line
  For Each Field In Fields.Items
    SaveFileName = Empty
    If Field.FileName <> "" Then 'This field is uploaded file. Save the file to its own folder
      SaveFileName = Field.Name & "\" & Field.FileName
      FS.CreateFolder (OutFolder & "\" & Field.Name)
    Else
      If Field.Length > 0 Then SaveFileName = Field.Name
    End If

    If Not IsEmpty(SaveFileName) Then
      Field.Value.SaveAs OutFolder & "\" & SaveFileName 'Write content of the field to the disk
    else'!!!!!!!!!
    End If
'    response.write "<br>:" & SaveFileName & ":" & Field.Value.String'!!!!!!!!!

    'Create log line with info about the field
    LogLine = LogLine & """" & LogF(Field.Name) & LogSeparator & LogF(Field.Length) & LogSeparator & LogF(Field.ContentDisposition) & LogSeparator & LogF(Field.FileName) & LogSeparator & LogF(Field.ContentType) & """" & LogSeparator
  Next
  
  'Creates line with global request info
  pLogLine = pLogLine & LogLine & Request.ServerVariables("REMOTE_ADDR") & LogSeparator & LogF(Request.ServerVariables("LOGON_USER")) & LogSeparator & Request.ServerVariables("HTTP_Content_Length") & LogSeparator & OutFolder & LogSeparator & LogF(Request.ServerVariables("ALL_RAW"))

  'Create output line for the client
  OutLine = OutLine & "Fields was saved to the <b>" & OutFolder & "</b> folder.<br>"
  
  DoLog pLogLine, "UP"
  
  'Save http header for debug purposes.
  Dim TextStream
  Set TextStream = FS.CreateTextFile(OutFolder & "\all_raw.txt")
  TextStream.Write Request.ServerVariables("ALL_RAW")
  TextStream.Close

  OutFolder = Empty 'Clear variables.
  SaveUpload = OutLine
End Function

Function UniqueFolderName
  'Creates unique name for the destination folder
  Dim UploadNumber
  Application.Lock
    If Application("UploadNumber") = "" Then
      Application("UploadNumber") = 1
    Else
      Application("UploadNumber") = Application("UploadNumber") + 1
    End If
    UploadNumber = Application("UploadNumber")
  Application.UnLock

  UniqueFolderName = Right("0" & Year(Now), 2) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & "_" & Right("0" & Hour(Now), 2) & Right("0" & Minute(Now), 2) & Right("0" & Second(Now), 2) & "-" & UploadNumber
End Function

'Writes one log line to the log file
Function DoLog(LogLine, LogPrefix)
  If LogFolder = "" Then LogFolder = Server.MapPath(".")
  Dim OutStream, FileName
  FileName = LogPrefix & Right("0" & Year(Now), 2) & Right("0" & Month(Now), 2) & Right("0" & Day(Now), 2) & ".LOG"

  Set OutStream = Server.CreateObject("Scripting.FileSystemObject").OpenTextFile(LogFolder & "\" & FileName, 8, True)
  OutStream.WriteLine Now() & LogSeparator & LogLine
  OutStream = Empty
End Function

'Returns field or "-" if field is empty
Function LogF(ByVal F)
	If "" & F = "" Then F = "-" Else F = "" & F
	F = replace(F, vbCrLf, "%13%10")
	F = replace(F, ",", "%2C")
	LogF = F
End Function

'Returns field or "-" if field is empty
Function LogFn(ByVal F)
  If "" & F = "" Then LogFn = "-" Else LogFn = formatnumber(F, 0)
End Function

Dim Kernel, TickCount, KernelTime, UserTime
Sub BeginTimer()
On Error Resume Next
  Set Kernel = CreateObject("ScriptUtils.Kernel") 'Creates the Kernel object
  'Get start times
  TickCount = Kernel.TickCount
  KernelTime = Kernel.CurrentThread.KernelTime
  UserTime = Kernel.CurrentThread.UserTime
On Error GoTo 0
End Sub

Sub EndTimer()
  'Write times
On Error Resume Next
  Response.Write "<br>Script time : " & (Kernel.TickCount - TickCount) & " ms"
  Response.Write "<br>Kernel time : " & CLng((Kernel.CurrentThread.KernelTime - KernelTime) * 86400000) & " ms"
  Response.Write "<br>User time : " & CLng((Kernel.CurrentThread.UserTime - UserTime) * 86400000) & " ms"
On Error GoTo 0
  Kernel = Empty
End Sub
</SCRIPT>
