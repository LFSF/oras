<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>
Const IncludeType = 2 'ScriptUtilities has two types of the include. This (2) is free. Include (1) is in the registered version.
'v. 1.5 c1997-2001 Antonin Foller, PSTRUH Software, http://www.pstruh.cz
'True PureASP upload - FREE upload include
'Please (if you want) include link to PSTRUH Software home page if you are using this free script
'The file enables http upload to ASP without any external components,
'using Scripting.Dictionary, Scripting.FileSystemObject and ADODB.Recordset.
'The file also simulates part of ByteArray object to convert binary data to a string and save binary data to the disk


'Limit of upload size
Dim UploadSizeLimit

'********************************** GetUpload **********************************
'This function reads all form fields from binary input and returns it as a dictionary object.
'The dictionary object containing form fields. Each form field is represented by next values :
'See HTML documentation of FormFields class (ScriptUtilities, http://www.pstruh.cz)
'.Name name of the form field (<Input Name="..." Type="File,...">)
'.ContentDisposition = Content-Disposition of the form field
'.FileName = Source file name for <input type=file>
'.FilePath = Full path of source file
'.ContentType = Content-Type for <input type=file>
'.Value = Binary value of the source field.
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

      '****** Error of IE5.01 - doubbles http header
      PosB = InStr(LCase(CT), "boundary=") 
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
        Dim Head, Binary
        Binary = Request.BinaryRead(Length) 'Reads binary data from client
        
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

'********************************** SeparateFields **********************************
'This function retrieves the upload fields from binary data and retuns the fields as array
'Binary is safearray ( VT_UI1 | VT_ARRAY ) of all document raw binary data from input.
Function SeparateFields(Binary, Boundary)
  Dim PosOpenBoundary, PosCloseBoundary, PosEndOfHeader, isLastBoundary
  Dim Fields
  Boundary = StringToBinary(Boundary)

  PosOpenBoundary = InStrB(Binary, Boundary)
  PosCloseBoundary = InStrB(PosOpenBoundary + LenB(Boundary), Binary, Boundary, 0)

  Set Fields = CreateObject("Scripting.Dictionary")
  Do While (PosOpenBoundary > 0 And PosCloseBoundary > 0 And Not isLastBoundary)
    'Header and file/source field data
    Dim HeaderContent, bFieldContent
    'Header fields
    Dim Content_Disposition, FormFieldName, SourceFileName, Content_Type
    'Helping variables
    Dim TwoCharsAfterEndBoundary
    'Get end of header
    PosEndOfHeader = InStrB(PosOpenBoundary + Len(Boundary), Binary, StringToBinary(vbCrLf + vbCrLf))

    'Separates field header
    HeaderContent = MidB(Binary, PosOpenBoundary + LenB(Boundary) + 2, PosEndOfHeader - PosOpenBoundary - LenB(Boundary) - 2)
    
    'Separates field content
    bFieldContent = MidB(Binary, (PosEndOfHeader + 4), PosCloseBoundary - (PosEndOfHeader + 4) - 2)

    'Separates header fields from header
    GetHeadFields BinaryToString(HeaderContent), FormFieldName, SourceFileName, Content_Disposition, Content_Type

    'Create one field and assign parameters
    Dim FieldContent 'Binary data of the field contents
    Dim Field        'All field values.
    Set Field = New clField
    Set FieldContent = New clByteArray
    FieldContent.ByteArray = bFieldContent

    Set Field.Value = FieldContent
    Field.Name = FormFieldName
    Field.ContentDisposition = Content_Disposition
    Field.FilePath = SourceFileName
    Field.FileName = GetFileName(SourceFileName)
    Field.ContentType = Content_Type
    Field.Length = FieldContent.Length

    Dim dField
    dField = Fields(FormFieldName)
    if isempty (dField) then'This is a first occurence of a source field name.
      Set Fields(FormFieldName) = Field
    else'Second occurence of a source field name. This is multiselect or something similar.
      if isarray(dField) then ' There is an array of values in the dictionary field under this key. Add a new value to the array
        ReDim Preserve dField(ubound(dField)+1)
        Set dField(ubound(dField) - 1) = Field
      else'There is one value in the dictionary field under this key. Create an array from the old and new value.
        dField = Array(dField, Field)
      end if
      Fields(FormFieldName) = dField
    end if

    'Is this last boundary ?
    TwoCharsAfterEndBoundary = BinaryToString(MidB(Binary, PosCloseBoundary + LenB(Boundary), 2))
    isLastBoundary = TwoCharsAfterEndBoundary = "--"

    If Not isLastBoundary Then 'This is not last boundary - go to next form field.
      PosOpenBoundary = PosCloseBoundary
      PosCloseBoundary = InStrB(PosOpenBoundary + LenB(Boundary), Binary, Boundary)
    End If
  Loop
  Set SeparateFields = Fields
End Function

'************** Upload Utilities 
'Separates header fields from upload header
Function GetHeadFields(ByVal Head, Name, FileName, Content_Disposition, Content_Type)
  'Get name of the field. Name is separated by name= and ;
  Name = (SeparateField(Head, "name=", ";")) 'ltrim
  'Remove quotes (if the field name is quoted)
  If Left(Name, 1) = """" Then Name = Mid(Name, 2, Len(Name) - 2)

  'Same for source filename
  FileName = (SeparateField(Head, "filename=", ";")) 'ltrim
  If Left(FileName, 1) = """" Then FileName = Mid(FileName, 2, Len(FileName) - 2)

  'Separate content-disposition and content-type header fields
  Content_Disposition = LTrim(SeparateField(Head, "content-disposition:", ";"))
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
      Case ":", "/", "\": PosF = Pos + 1: Pos = 0
    End Select
  Next
  If PosF = 0 Then PosF = 1
  GetFileName = Mid(FullPath, PosF)
End Function
'************** Upload Utilities - end


'************** Binary+MultiByte <-> String conversion fuctions
Function BinaryToString(Binary)
  '2001 Antonin Foller, PSTRUH Software
  'Optimized version of PureASP conversion function
  'Selects the best algorithm to convert binary data to String data
  Dim TempString 

  On Error Resume Next
  'Recordset conversion has a best functionality
  TempString = RSBinaryToString(Binary)
  If Len(TempString) <> LenB(Binary) then'Conversion error
    'We have to use multibyte version of BinaryToString
    TempString = MBBinaryToString(Binary)
  end if
  BinaryToString = TempString
End Function

Function MBBinaryToString(Binary)
  '1999 Antonin Foller, PSTRUH Software
  'MultiByte version of BinaryToString function
	'Optimized version of simple BinaryToString algorithm.
  dim cl1, cl2, cl3, pl1, pl2, pl3
  Dim L', nullchar
  cl1 = 1
  cl2 = 1
  cl3 = 1
  L = LenB(Binary)
  
  Do While cl1<=L
    pl3 = pl3 & Chr(AscB(MidB(Binary,cl1,1)))
    cl1 = cl1 + 1
    cl3 = cl3 + 1
    if cl3>300 then
      pl2 = pl2 & pl3
      pl3 = ""
      cl3 = 1
      cl2 = cl2 + 1
      if cl2>200 then
        pl1 = pl1 & pl2
        pl2 = ""
        cl2 = 1
      End If
    End If
  Loop
  MBBinaryToString = pl1 & pl2 & pl3
End Function


Function RSBinaryToString(xBinary)
  '1999 Antonin Foller, PSTRUH Software
  'This function converts binary data (VT_UI1 | VT_ARRAY or MultiByte string)
	'to string (BSTR) using ADO recordset
	'The fastest way - requires ADODB.Recordset
	'Use this function instead of MBBinaryToString if you have ADODB.Recordset installed
	'to eliminate problem with PureASP performance

	Dim Binary
	'MultiByte data must be converted to VT_UI1 | VT_ARRAY first.
	if vartype(xBinary) = 8 then Binary = MultiByteToBinary(xBinary) else Binary = xBinary
	
  Dim RS, LBinary
  Const adLongVarChar = 201
  Set RS = CreateObject("ADODB.Recordset")
  LBinary = LenB(Binary)
	
	if LBinary>0 then
		RS.Fields.Append "mBinary", adLongVarChar, LBinary
		RS.Open
		RS.AddNew
			RS("mBinary").AppendChunk Binary 
		RS.Update
		RSBinaryToString = RS("mBinary")
	Else
		RSBinaryToString = ""
	End If
End Function

Function MultiByteToBinary(MultiByte)
  ' This function converts multibyte string to real binary data (VT_UI1 | VT_ARRAY)
  ' Using recordset
  Dim RS, LMultiByte, Binary
  Const adLongVarBinary = 205
  Set RS = CreateObject("ADODB.Recordset")
  LMultiByte = LenB(MultiByte)
	if LMultiByte>0 then
		RS.Fields.Append "mBinary", adLongVarBinary, LMultiByte
		RS.Open
		RS.AddNew
			RS("mBinary").AppendChunk MultiByte & ChrB(0)
		RS.Update
		Binary = RS("mBinary").GetChunk(LMultiByte)
	End If
  MultiByteToBinary = Binary
End Function

Function StringToBinary(String)
  Dim I, B
  For I=1 to len(String)
    B = B & ChrB(Asc(Mid(String,I,1)))
  Next
  StringToBinary = B
End Function

Function BinaryToStringSimple(Binary)
  'Multibyte conversion idea.
  'not used.
  Dim I, S
  For I = 1 To LenB(Binary)
    S = S & Chr(AscB(MidB(Binary, I, 1)))
  Next
  BinaryToStringSimple = S
End Function
'************** Binary+MultiByte <-> String conversion fuctions - end


'The function simulates save of binary data using conversion to a string and filesystemobject
Function SaveBinaryData(FileName, ByteArray)
  Dim FS : Set FS = CreateObject("Scripting.FileSystemObject")
  Dim TextStream : Set TextStream = FS.CreateTextFile(FileName)
    TextStream.Write BinaryToString(ByteArray) 'BinaryToString is in upload.inc.
  TextStream.Close
End Function

'************** ScriptUtilities ByteArray class emaulation
'ByteArray class is native implemented by ScriptUtilities library
'This is simple VBS code which simulates some of ScriptUtilities ByteArray functionality
'required for file upload
Class clByteArray
  'Stored bytearray.
  public ByteArray

  Public Default Property Get ba
    ba = ByteArray
  End Property	

  'Returns length of source binary data
  public Property Get Length
    Length = LenB(ByteArray)
  End Property	

  'Returns length of source binary data
  public Property Get String
    String = BinaryToString(ByteArray)
  End Property	

  'Stores the binary data to a file.
  Public Function SaveAs(FileName)
    SaveBinaryData FileName, ByteArray
  End Function
End Class

'One upload form field contains next properties.
Class clField
  Public Name, ContentDisposition, FileName, FilePath, ContentType, Value, Length
  Public Default Property Get n
    n = Name 
  End Property
End Class
'************** ScriptUtilities ByteArray class emaulation - end

'************** Special utilities
'Checks if all of required objects are installed
Function CheckRequirements()
  Dim Msg
  Msg = "<br><b>This script requires some default VBS objects installed to run properly.</b><br>" & vbCrLf
  Msg = Msg & CheckOneObject("ADODB.Recordset")
  Msg = Msg & CheckOneObject("Scripting.FileSystemObject")
  Msg = Msg & CheckOneObject("Scripting.Dictionary")
  CheckRequirements = Msg
'  MsgBox Msg
End Function

'Checks if the one object is installed.
Function CheckOneObject(oClass)
  Dim Msg
  On Error Resume Next
  CreateObject oClass
  If Err = 0 Then Msg = "OK" Else Msg = "Error:" & Err.Description
  CheckOneObject = oClass & " - " & Msg & "<br>" & vbCrLf
End Function
'************** Special utilities - end
</SCRIPT>
