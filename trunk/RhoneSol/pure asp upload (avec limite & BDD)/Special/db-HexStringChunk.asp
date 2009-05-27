<%
'Sample file db-HexStringChunk.asp 
'Upload to MS SQL database, store file using HexString method and UPDATETEXT command
'Suitable for upload of big files (up to 2GB) 
'   and MS SQL databse (MS SQL 6.5 - MS SQL 2000)
'see article 'To database, or not to database?' in Huge-ASP file upload help

Server.ScriptTimeout = 36000

'Upload large files to MS SQL Server using HexString
Dim d: D="" & time: d=replace(d,":","")

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then
  dim Conn, SQL, RS, UploadID
  'Open connection to database
  Set Conn = GetConnection 

  'Create insert statement with empty Data field
  SQL = "SET NOCOUNT ON Insert into Upload(UploadDT, ContentType, SouceFileName, Title, [Description], Data) values("
  SQL = SQL & "GetDate()"
  SQL = SQL & ", '" & Form("DBFile").ContentType & "'"
  SQL = SQL & ",  '" & Form("DBFile").FileName & "'"
  SQL = SQL & ",  '" & Form("Title") & "'"
  SQL = SQL & ",  '" & Form("Description") & "'"
  SQL = SQL & ",0x)" & vbCrLf
  SQL = SQL & "Select @@IDENTITY as UploadID"
  

  Set RS = Conn.Execute(SQL)
    UploadID = RS("UploadID")
  RS.Close


  '{b}Set block size to 1MB
  Const BlockSize = &H100000

  'Process source data using blocks
  Dim BlockCounter, HexDataBlock
  For BlockCounter = 0 to Form("DBFile").Length step BlockSize

    'Get a part of source data as a Hex string
    HexDataBlock = Form("DBFile").HexString(BlockCounter, BlockSize)

    'Add a part of source data to the field
    SQL = "DECLARE @dataptr binary(16)" & vbCrLf
    SQL = SQL & "SELECT @dataptr = TEXTPTR(Data)"
    SQL = SQL & " FROM Upload WHERE UploadID=" & UploadID & vbCrLf
    SQL = SQL & "UPDATETEXT Upload.Data @dataptr " & BlockCounter & " NULL 0x" & HexDataBlock
    Conn.Execute SQL
  Next 'BlockCounter 
  '{/b}

  Conn.Close
End If'Form.State = 0 then

Function GetConnection1()
  'Open connection to MDB using Microsoft.Jet.OLEDB.4.0
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.CommandTimeout = 1800
  Conn.open "Data Source=" & Server.MapPath("upload.mdb") 
  set GetConnection = Conn
end function

Function GetConnection()
  'Open connection to MS SQL using SQLOLEDB
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "SQLOLEDB"
  Conn.open "Data Source=(local);Database=Upload", "sa", ""
  set GetConnection = Conn
end function

function CreateUploadTable(Conn)
  'This function creates upload table for MSSQL 6.5/7.0
  dim SQL
  SQL = SQL & "CREATE TABLE Upload ("
  SQL = SQL & "  UploadID int IDENTITY (1, 1) NOT NULL ,"
  SQL = SQL & "  UploadDT datetime NULL ,"
  SQL = SQL & "  RemoteIP char (15) NULL ,"
  SQL = SQL & "  ContentType char (64) NULL ,"
  SQL = SQL & "  SouceFileName varchar (255) NULL ,"
  SQL = SQL & "  Title varchar (255) NULL ,"
  SQL = SQL & "  Description text NULL ,"
  SQL = SQL & "  Data image NULL "
  SQL = SQL & ")"
  Conn.Execute SQL
end function

%>  
<br>Upload to MS SQL database, store file using HexString method and UPDATETEXT command
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Suitable for upload of big files (up to 2GB) and MS SQL databse (MS SQL 6.5 - MS SQL 2000)
<br>see article 'To database, or not to database?' in Huge-ASP file upload help

<Table><form method=post ENCTYPE="multipart/form-data">
<TR>
 <TD></TD>
 <TD Align=Right><input type="submit" Name="Action" value="Upload the file >>"></TD>
</TR>
<TR>
 <TD>File to upload</TD>
 <TD><input type="file" name="DBFile"></TD>
</TR>
<TR>
 <TD>Title</TD>
 <TD><input size="60" name="Title" value="Title of the file."></TD>
</TR>
<TR>
 <TD>Description</TD>
 <TD><textarea cols="60" rows="8" name="Description">Type description of the file.</textarea></TD>
</TR>

</form></Table>
