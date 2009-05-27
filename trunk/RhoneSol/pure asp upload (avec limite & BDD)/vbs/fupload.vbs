
'Upload file using http protocol And multipart/form-data
'v1.01
'2001 Antonin Foller, Motobit Software
do_vbsUpload

Sub do_vbsUpload()
  'We need at least two arguments (File + URL)
  If WScript.Arguments.Count < 2 Then InfoEcho
  
  'Are some required objects missing?
  If InStr(CheckRequirements, "Error") > 0 Then InfoEcho
  
  Dim FileName, DestURL, FieldName
  FieldName = "FileField" 'Default field name
  
  Dim aCounter, Arg
  aCounter = 1 'Argument counter
  For Each Arg In WScript.Arguments
    Select Case aCounter
      Case 1: FileName = Arg
      Case 2: DestURL = Arg
      Case 3: FieldName = Arg
    End Select
    aCounter = aCounter + 1
  Next
  
  UploadFile DestURL, FileName, FieldName
End Sub



'******************* upload - begin
'Upload file using input type=file
Sub UploadFile(DestURL, FileName, FieldName)
  'Boundary of fields.
  'Be sure this string is NOT in the source file
  Const Boundary = "-2"
  
  Dim FileContents, FormData
  'Get source file as a binary data.
  FileContents = GetFile(FileName)
  
  'Build multipart/form-data document
  FormData = BuildFormData(FileContents, Boundary, FileName, FieldName)
  
  'Post the data to the destination URL
  IEPostBinaryRequest DestURL, FormData, Boundary
End Sub

'Build multipart/form-data document with file contents and header info
Function BuildFormData(FileContents, Boundary, FileName, FieldName)
  Dim FormData, Pre, Po
  Const ContentType = "application/upload"
  
  'The two parts around file contents in the multipart-form data.
  Pre = "--" + Boundary + vbCrLf + mpFields(FieldName, FileName, ContentType)
  Po = vbCrLf + "--" + Boundary + "--" + vbCrLf
  
  'Build form data using recordset binary field
  Const adLongVarBinary = 205
  Dim RS: Set RS = CreateObject("ADODB.Recordset")
  RS.Fields.Append "b", adLongVarBinary, Len(Pre) + LenB(FileContents) + Len(Po)
  RS.Open
  RS.AddNew
    Dim LenData
    'Convert Pre string value to a binary data
    LenData = Len(Pre)
    RS("b").AppendChunk (StringToMB(Pre) & ChrB(0))
    Pre = RS("b").GetChunk(LenData)
    RS("b") = ""
    
    'Convert Po string value to a binary data
    LenData = Len(Po)
    RS("b").AppendChunk (StringToMB(Po) & ChrB(0))
    Po = RS("b").GetChunk(LenData)
    RS("b") = ""
    
    'Join Pre + FileContents + Po binary data
    RS("b").AppendChunk (Pre)
    RS("b").AppendChunk (FileContents)
    RS("b").AppendChunk (Po)
  RS.Update
  FormData = RS("b")
  RS.Close
  BuildFormData = FormData
End Function

'sends multipart/form-data to the URL using IE
Function IEPostBinaryRequest(URL, FormData, Boundary)
  'Create InternetExplorer
  Dim IE: Set IE = CreateObject("InternetExplorer.Application")
  
  'You can uncoment next line to see form results
  IE.Visible = True
   
  'Send the form data to URL as POST multipart/form-data request
  IE.Navigate URL, , , FormData, _
    "Content-Type: multipart/form-data; boundary=" + Boundary + vbCrLf

  Do While IE.Busy
    Wait 1, "Upload to " & URL
  Loop
  
  'Get a result of the script which has received upload
  On Error Resume Next
  IEPostBinaryRequest = IE.Document.body.innerHTML
'  IE.Quit
End Function

'Infrormations in form field header.
Function mpFields(FieldName, FileName, ContentType)
  Dim MPTemplate 'template for multipart header
  MPTemplate = "Content-Disposition: form-data; name=""{field}"";" + _
   " filename=""{file}""" + vbCrLf + _
   "Content-Type: {ct}" + vbCrLf + vbCrLf
  Dim Out
  Out = Replace(MPTemplate, "{field}", FieldName)
  Out = Replace(Out, "{file}", FileName)
  mpFields = Replace(Out, "{ct}", ContentType)
End Function


Sub Wait(Seconds, Message)
  On Error Resume Next
  CreateObject("wscript.shell").Popup Message, Seconds, "", 7
End Sub


'Returns file contents as a binary data
Function GetFile(FileName)
  Dim Stream: Set Stream = CreateObject("ADODB.Stream")
  Stream.Type = 1 'Binary
  Stream.Open
  Stream.LoadFromFile FileName
  GetFile = Stream.Read
  Stream.Close
End Function

'Converts OLE string to multibyte string
Function StringToMB(S)
  Dim I, B
  For I = 1 To Len(S)
    B = B & ChrB(Asc(Mid(S, I, 1)))
  Next
  StringToMB = B
End Function
'******************* upload - end

'******************* Support
'Basic script info
Sub InfoEcho()
  Dim Msg
  Msg = Msg + "Upload file using http and multipart/form-data" & vbCrLf
  Msg = Msg + "Copyright (C) 2001 Antonin Foller, Motobit Software" & vbCrLf
  Msg = Msg + "use" & vbCrLf
  Msg = Msg + "[cscript|wscript] fupload.vbs file url [fieldname]" & vbCrLf
  Msg = Msg + "  file ... Local file to upload" & vbCrLf
  Msg = Msg + "  url ... URL which can accept uploaded data" & vbCrLf
  Msg = Msg + "  fieldname ... Name of the source form field." & vbCrLf
  Msg = Msg + vbCrLf + CheckRequirements
  WScript.Echo Msg
  WScript.Quit
End Sub

'Checks if all of required objects are installed
Function CheckRequirements()
  Dim Msg
  Msg = "This script requires some objects installed to run properly." & vbCrLf
  Msg = Msg & CheckOneObject("ADODB.Recordset")
  Msg = Msg & CheckOneObject("ADODB.Stream")
  Msg = Msg & CheckOneObject("InternetExplorer.Application")
  CheckRequirements = Msg
'  MsgBox Msg
End Function

'Checks if the one object is installed.
Function CheckOneObject(oClass)
  Dim Msg
  On Error Resume Next
  CreateObject oClass
  If Err = 0 Then Msg = "OK" Else Msg = "Error:" & Err.Description
  CheckOneObject = oClass & " - " & Msg & vbCrLf
End Function
'******************* Support - end
