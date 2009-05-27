<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>
Const IncludeType = 2 'ScriptUtilities has two types of the include. This (2) is free. Include (1) is in the registered version.
'True PureASP upload - FREE upload include
'Please (if you want) include link to PSTRUH Software home page if you are using the free script
'c1997-1999 Antonin Foller, PSTRUH Software, http://www.pstruh.cz
'The file is part of ScriptUtilities library
'The file enables http upload to ASP without any components.
'But there is a small problem - ASP does not allow save binary data to the disk.
' So you can use the upload for :
' 1. Upload small files to server-side disk (PureASP upload saves the data by FileSystem object)
' 2. Upload binary/text files of any size to server-side database (RS("BinField") = Upload("FormField").Value)
'The file also simulates part of ByteArray object to convert binary data to a string and save binary data to the disk


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
    Dim HeaderContent, FieldContent, bFieldContent
    'Header fields
    Dim Content_Disposition, FormFieldName, SourceFileName, Content_Type
    'Helping variables
    Dim Field, TwoCharsAfterEndBoundary
    'Get end of header
    PosEndOfHeader = InStrB(PosOpenBoundary + Len(Boundary), Binary, StringToBinary(vbCrLf + vbCrLf))

    'Separates field header
    HeaderContent = MidB(Binary, PosOpenBoundary + LenB(Boundary) + 2, PosEndOfHeader - PosOpenBoundary - LenB(Boundary) - 2)
    
    'Separates field content
    bFieldContent = MidB(Binary, (PosEndOfHeader + 4), PosCloseBoundary - (PosEndOfHeader + 4) - 2)

    'Separates header fields from header
    GetHeadFields BinaryToString(HeaderContent), Content_Disposition, FormFieldName, SourceFileName, Content_Type

    'Create one field and assign parameters
    Set Field = CreateUploadField()'See the JS function bellow
    Set FieldContent = CreateBinaryData(bFieldContent,LenB(bFieldContent))'See the JS function bellow
'    FieldContent.ByteArray = bFieldContent
'    FieldContent.Length = LenB(bFieldContent)

    Field.Name = FormFieldName
    Field.ContentDisposition = Content_Disposition
    Field.FilePath = SourceFileName
    Field.FileName = GetFileName(SourceFileName)
    Field.ContentType = Content_Type
    Field.Length = FieldContent.Length
    Set Field.Value = FieldContent

'	response.write "<br>:" & FormFieldName
    Fields.Add FormFieldName, Field

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


'Simulate ByteArray class by JS/VBS
Function BinaryToStringSimple(Binary)
  Dim I, S
  For I = 1 To LenB(Binary)
    S = S & Chr(AscB(MidB(Binary, I, 1)))
  Next
  BinaryToStringSimple = S
End Function

Function BinaryToString(Binary)
'	BinaryToString = RSBinaryToString(Binary)
'	Exit Function

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
  BinaryToString = pl1 & pl2 & pl3
End Function


Function RSBinaryToString(xBinary)
  'This function converts binary data (VT_UI1 | VT_ARRAY or MultiByte string)
	'to string (BSTR) using ADO recordset
	'The fastest way - requires ADODB.Recordset
	'Use this function instead of BinaryToString if you have ADODB.Recordset installed
	'to eliminate problem with PureASP performance

	Dim Binary
	'MultiByte data must be converted to VT_UI1 | VT_ARRAY first.
	if vartype(xBinary)=8 then Binary = MultiByteToBinary(xBinary) else Binary = xBinary
	
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

'The function simulates save binary data using conversion to string and filesystemobject
Function vbsSaveAs(FileName, ByteArray)
  Dim FS, TextStream
  Set FS = CreateObject("Scripting.FileSystemObject")

  Set TextStream = FS.CreateTextFile(FileName)
    'And this is the problem why only short files - BinaryToString uses byte-to-char VBS conversion. It takes a lot of computer time.
    TextStream.Write BinaryToString(ByteArray) ' BinaryToString is in upload.inc.
  TextStream.Close
End Function

'Simulate ByteArray class by JS/VBS - end
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

//Simulate ByteArray class by JS/VBS
function CreateBinaryData(Binary, mLength){ return new bin_Init(Binary, mLength) }
function bin_Init(Binary, mLength){
  this.ByteArray = Binary
  this.Length = mLength
  this.String = BinaryToString(Binary)
  this.SaveAs = jsSaveAs
}
//function jsBinaryToString(){
//  return BinaryToString(this.ByteArray)
//};
function jsSaveAs(FileName){
  return vbsSaveAs(FileName, this.ByteArray)
}
//Simulate ByteArray class by JS/VBS - end

</SCRIPT>
