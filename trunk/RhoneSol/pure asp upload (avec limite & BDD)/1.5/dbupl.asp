<%Option Explicit%>
<%'upload.inc, contains GetUpload function, Required for upload - only the one file%>
<!--#INCLUDE FILE="upload.inc"-->
<%'format.inc, contains head and Foot function, optional.%>
<!--#INCLUDE FILE="format.inc"-->
<%
  UploadSizeLimit = 1000000
  response.write Head("Sample database upload via ASP", "Demonstrates using of the ByteArray class for working with binary data from Request.BinaryRead.")
  response.write dbDescription
  response.write CheckRequirements
%>

<Table>
  <form method=post ENCTYPE="multipart/form-data">
    <TR><TD></TD><TD Align=Right><input type="submit" Name="Action" value="Upload the file >>"></TD></TR>
    <TR><TD>File to upload</TD><TD><input type="file" name="DBFile"></TD></TR>
    <TR><TD>Title</TD><TD><input size="60" name="Title" value="Title of the file."></TD></TR>
    <TR><TD>Description</TD><TD><textarea cols="60" rows="8" name="Description">Type description of the file.</textarea></TD></TR>
  </form>
</Table>

<%=Foot%>

<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>
'Some value greater than default of 60s (According to upload size.)
'The maximum speed is about 100kB/s for IIS4, P200 and local upload, 4kB/s for modem users.
Server.ScriptTimeout = 200


If Request.ServerVariables("REQUEST_METHOD") = "POST" Then 'Request method must be "POST" for get the fields
  '*************************************************   Main Upload - start
    Dim Fields
    'on error resume next
    'Gets uploaded fields
    Set Fields = GetUpload()
    'There are all of form fields in the Fields object. Example :
    'Fields("File1").ContentType - content type of File1 field
    'Fields("File1").Value.String - File1 field converted to a string
    'Fields("File1").Value.ByteArray - File1 field as safearray to store in binary RS field or file
    'Fields("Comments").Value.String - value of Comments field

    If Err = 0 Then 'Upload was OK
      'Saves fields to the database and returns result to the client.
      Response.Write DBSaveUpload(Fields)
    Else 'Error in upload. Write the error
      Response.Write Err.Description
    End If
    On Error GoTo 0
    Fields = Empty 'Clear the variable
  '*************************************************   Main Upload - end
End If 'Request method must be "POST"


function DBSaveUpload(Fields)
  dim Conn, RS
  Set Conn = GetConnection 
  Set RS = Server.CreateObject("ADODB.Recordset")
  RS.Open "Upload", Conn, 2, 2
  RS.AddNew
    RS("UploadDT") = Now()

    RS("RemoteIP") = Request.ServerVariables("REMOTE_ADDR")
    RS("ContentType") = Fields("DBFile").ContentType
    RS("SouceFileName") = Fields("DBFile").FileName
    RS("DataSize") = Fields("DBFile").Value.Length

    RS("Description") = Fields("Description").Value.String
    RS("Title") = Fields("Title").Value.String
    if IncludeType=1 then'For ScriptUtilities
      RS("Data").AppendChunk Fields("DBFile").Value.ByteArray
    Else'For PureASP upload - String is implemented as method.
      RS("Data").AppendChunk MultiByteToBinary(Fields("DBFile").Value.ByteArray)
    End If

  RS.Update
  RS.Close
  Conn.Close
  DBSaveUpload = "<br>File <b>" & Fields("DBFile").FileName & "</b>, length : <b>" & Fields("DBFile").Length & " B</b> was saved to the database. "
end function

Function MultiByteToBinary(MultiByte)
  ' This function converts multibyte string to real binary data (VT_UI1 | VT_ARRAY)
  ' Using recordset
  Dim RS, LMultiByte, Binary
  Const adLongVarBinary = 205
  Set RS = CreateObject("ADODB.Recordset")
  LMultiByte = LenB(MultiByte)
  RS.Fields.Append "mBinary", adLongVarBinary, LMultiByte
  RS.Open
  RS.AddNew
    RS("mBinary").AppendChunk MultiByte & ChrB(0)
  RS.Update
  Binary = RS("mBinary").GetChunk(LMultiByte)
  MultiByteToBinary = Binary
End Function


function GetConnection()
  dim Conn, AuthConnectionString 
  Set Conn = Server.CreateObject("ADODB.Connection")
  'MDB connection
'  AuthConnectionString = "DBQ=" & Server.MapPath(".") & "\upload.mdb;DefaultDir=" & Server.MapPath("/") & ";" & _
'      "Driver={Microsoft Access Driver (*.mdb)}; DriverId=25;FIL=MS Access;MaxBufferSize=512;PageTimeout=5;UID=;"
  AuthConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("upload.mdb") 
  Conn.open AuthConnectionString
  'SQL connection
  'Simply change connection and create table to upload to MS SQL
'  Conn.Provider = "SQLOLEDB"
'  Conn.Open "Server=(Local);Database=Auth", "sa", "password"
	set GetConnection = Conn
end function

function CreateUploadTable(Conn)
'The function creates upload table for MSSQL 6.5/7.0
dim SQL
 SQL = SQL & "CREATE TABLE Upload ("
 SQL = SQL & "	UploadID int IDENTITY (1, 1) NOT NULL ,"
 SQL = SQL & "	UploadDT datetime NULL ,"
 SQL = SQL & "	RemoteIP char (15) NULL ,"
 SQL = SQL & "	ContentType char (64) NULL ,"
 SQL = SQL & "	SouceFileName varchar (255) NULL ,"
 SQL = SQL & "	Title varchar (255) NULL ,"
 SQL = SQL & "	Description text NULL ,"
 SQL = SQL & "	Data image NULL "
 SQL = SQL & ")"
 Conn.Execute SQL
end function
</SCRIPT>
