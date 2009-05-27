<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>

Const IncludeType = 1 'ScriptUtilities has two types of the include. This (1) is full version using ScriptUtilities library. Include (2) is in the free version.
'Sample multiple binary files upload via ASP - upload include
'c1997-1999 PSTRUH Software, http://www.pstruh.cz
'The file is part of ScriptUtilities library

'Limit of upload size
Dim UploadSizeLimit

'********************************** GetUpload **********************************
'This function reads all form fields from binary input and returns it as a dictionary object.
'The dictionary object containing form fields. Each form field is represented by six values :
'See HTML documentation of FormFields class (ScriptUtilities, http://www.pstruh.cz)
'.Name name of the form field (<Input Name="..." Type="File,...">)
'.ContentDisposition = Content-Disposition of the form field
'.FileName = Source file name for <input type=file>
'.ContentType = Content-Type for <input type=file>
'.Value = Binary value of the source field. You can convert it to a string by String method : GetUpload.FieldName.Value.String
'.Length = Len of the binary data field
Function GetUpload()
  Dim Result
  Set Result = Nothing
  If Request.ServerVariables("REQUEST_METHOD") = "POST" Then 'Request method must be "POST"
    Dim CT, PosB, Boundary, Length, PosE
    CT = Request.ServerVariables("HTTP_Content_Type") 'reads Content-Type header
    If LCase(Left(CT, 19)) = "multipart/form-data" Then 'Content-Type header must be "multipart/form-data"
      'This is upload request.
      'Get the boundary and length from Content-Type header
      PosB = InStr(LCase(CT), "boundary=") 'Finds boundary
      If PosB > 0 Then Boundary = Mid(CT, PosB + 9) 'Separetes boundary

      '****** Error of IE5.01 - doubbles http header, Boundary contains one extra content type
      PosB = InStr(LCase(Boundary), "boundary=") 
      If PosB > 0 then 'Patch for the IE error
        PosB = InStr(Boundary, ",")
        If PosB > 0 Then Boundary = Left(Boundary, PosB - 1)
      end if
      '****** Error of IE5.01 - doubbles http header

      Length = CLng(Request.ServerVariables("HTTP_Content_Length")) 'Get Content-Length header
      If "" & UploadSizeLimit <> "" Then
        UploadSizeLimit = CLng(UploadSizeLimit)
        If Length > UploadSizeLimit Then
          Request.BinaryRead (Length)
          Err.Raise 2, "GetUpload", "Upload size " & FormatNumber(Length, 0) & "B exceeds limit of " & FormatNumber(UploadSizeLimit, 0) & "B"
          Exit Function
        End If
      End If
      
      If Length > 0 And Boundary <> "" Then 'Are there required informations about upload ?
        Boundary = "--" & Boundary
        Dim Head, Binary, TempByteArray
        Set Binary = GetByteArray()
		TempByteArray = Request.BinaryRead(Length) 'Reads binary data from client
        Binary.ByteArray = TempByteArray
        
        'Retrieves the upload fields from binary data
        Set Result = SeparateFields(Binary, Boundary)
        Binary = Empty 'Clear variables
      Else
        Err.Raise 10, "GetUpload", "Zero length request ."
      End If
    Else
      Err.Raise 11, "GetUpload", "No file sent."
    End If
  Else
    Err.Raise 1, "GetUpload", "Bad request method."
  End If
  Set GetUpload = Result
End Function

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

'********************************** SeparateFields **********************************
'This function retrieves the upload fields from binary data and retuns the fields as array
'Binary is safearray ( VT_UI1 | VT_ARRAY ) of all document raw binary data from input.
Function SeparateFields(Binary, Boundary)
  Dim PosOpenBoundary, PosCloseBoundary, PosEndOfHeader, isLastBoundary
  Dim Fields
  PosOpenBoundary = Binary.Find(Boundary) 'Finds the first boundary from the binary data - this is begin of uploaded field
  PosCloseBoundary = Binary.Find(Boundary, PosOpenBoundary + Len(Boundary)) 'Finds the next boundary from the binary data - this is end of uploaded field
  Set Fields = CreateObject("Scripting.Dictionary")

  Do While (PosOpenBoundary > 0 And PosCloseBoundary > 0 And Not isLastBoundary)
    'Header and file/source field data
    Dim HeaderContent, FieldContent
    'Header fields
    Dim Content_Disposition, FormFieldName, SourceFileName, Content_Type
    'Helping variables
    Dim Field, TwoCharsAfterEndBoundary
    'Get end of header
    PosEndOfHeader = Binary.Find(vbCrLf + vbCrLf, PosOpenBoundary + Len(Boundary)) 'Finds end of header - From Boundary to 2*CrLf

    'Separates field header
    Set HeaderContent = Binary.Mid(PosOpenBoundary + Len(Boundary) + 2, PosEndOfHeader - PosOpenBoundary - Len(Boundary) - 2) 'Separate upload header. Constant 2 is opening CrLf
    'Separates field content
    Set FieldContent = Binary.Mid((PosEndOfHeader + 4), PosCloseBoundary - (PosEndOfHeader + 4) - 2)  'Separate field content. Constant 2 is closing CrLf
    'Separates header fields from header
    GetHeadFields HeaderContent.String, Content_Disposition, FormFieldName, SourceFileName, Content_Type

    'Create one field and assign parameters
    Set Field = CreateUploadField()
    Field.Name = FormFieldName
    Field.ContentDisposition = Content_Disposition
    Field.FilePath = SourceFileName
    Field.FileName = GetFileName(SourceFileName)
    Field.ContentType = Content_Type
    Field.Length = FieldContent.Length
    Set Field.Value = FieldContent

    Fields.Add FormFieldName, Field

    'Is this last boundary ?
    TwoCharsAfterEndBoundary = Binary.Mid(PosCloseBoundary + Len(Boundary), 2).String
    isLastBoundary = TwoCharsAfterEndBoundary = "--"

    If Not isLastBoundary Then 'This is not last boundary - go to next form field.
      PosOpenBoundary = PosCloseBoundary
      PosCloseBoundary = Binary.Find(Boundary, PosOpenBoundary + Len(Boundary)) 'Finds the next boundary from the binary data - this is end of uploaded field
    End If
  Loop
  Set SeparateFields = Fields
End Function

'********************************** Utilities **********************************
'Separates header fields from upload header
Function GetHeadFields(ByVal Head, Content_Disposition, Name, FileName, Content_Type)
  Content_Disposition = LTrim(SeparateField(Head, "content-disposition:", ";"))

  Name = (SeparateField(Head, "name=", ";")) 'ltrim
  If Left(Name, 1) = """" Then Name = Mid(Name, 2, Len(Name) - 2)

  FileName = (SeparateField(Head, "filename=", ";")) 'ltrim
  If Left(FileName, 1) = """" Then FileName = Mid(FileName, 2, Len(FileName) - 2)

  Content_Type = LTrim(SeparateField(Head, "content-type:", ";"))
End Function

'Separates one field between sStart and sEnd
Function SeparateField(From, ByVal sStart, ByVal sEnd)
  Dim PosB, PosE, sFrom
  sFrom = LCase(From)
  PosB = InStr(sFrom, sStart)
  If PosB > 0 Then
    PosB = PosB + Len(sStart)
    PosE = InStr(PosB, sFrom, sEnd)
    If PosE = 0 Then PosE = InStr(PosB, sFrom, vbCrLf)
    If PosE = 0 Then PosE = Len(sFrom) + 1
    SeparateField = Mid(From, PosB, PosE - PosB)
  Else
    SeparateField = Empty
  End If
End Function

'Separetes file name from the full path of file
Function GetFileName(FullPath)
  Dim Pos, PosF
  PosF = 0
  For Pos = Len(FullPath) To 1 Step -1
    Select Case Mid(FullPath, Pos, 1)
      Case "/", "\": PosF = Pos + 1: Pos = 0
    End Select
  Next
  If PosF = 0 Then PosF = 1
  GetFileName = Mid(FullPath, PosF)
End Function

Function GetUserName()
  On Error Resume Next
  GetUserName = CreateObject("Wscript.Network").UserName
End Function
</SCRIPT>
<SCRIPT RUNAT=SERVER LANGUAGE=JSCRIPT>
//The function creates Field object. I'm sorry to use JScript, but VBScript can't create custom objects till version 5.0
function CreateUploadField(){ return new uf_Init() }
function uf_Init(){
  this.Name = null
  this.ContentDisposition = null
  this.FileName = null
  this.FilePath = null
  this.ContentType = null
  this.Value = null
  this.Length = null
}
</SCRIPT>
