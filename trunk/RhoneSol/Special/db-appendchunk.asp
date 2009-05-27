<%
'Sample file db-appendchunk.asp
'Upload to database, store file using AppendChunk method of RecordSet
'Suitable for upload of big files and MDB database
'see article 'To database, or not to database?' in Huge-ASP file upload help
'This sample works with well with MDB files and JetOLEDB provider
'AppendChunk method does not work correctly with SQLOLEDB provider 
'See HexString property to upload big files to MSSQL.

Server.ScriptTimeout = 3600
'Simple upload to database

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Form.TempPath = "h:\temp"
'was the Form successfully received?
if Form.State = 0 then
  dim Conn, RS
  'Open connection to database
  Set Conn = GetConnection 
  Set RS = Server.CreateObject("ADODB.Recordset")

  'Open dynamic recordset, table Upload
  RS.Open "Upload", Conn, 2, 2
  RS.AddNew

    'Store extra form info.
    RS("Description") = Form("Description")
    RS("Title") = Form("Title")

    '{b}Set block size to 64kB
    Const BlockSize = &H10000
  
    'Process source data using blocks
    Dim BlockCounter, DataBlock
    For BlockCounter = 0 to Form("DBFile").Length step BlockSize
      'Get a part of source data
      DataBlock = Form("DBFile").ByteArray(BlockCounter, BlockSize)

      'Add a part of source data to the field
      RS("Data").AppendChunk DataBlock
    Next 'BlockCounter 
    '{/b}

    'Store technical informations
    RS("ContentType") = Form("DBFile").ContentType
    RS("SourceFileName") = Form("DBFile").FileName

    RS("UploadDT") = Now()
  RS.Update
  RS.Close
  Conn.Close
End If'Form.State = 0 then

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.CommandTimeout = 1800
  Conn.open "Data Source=" & Server.MapPath("upload.mdb") 
  set GetConnection = Conn
end function

Function GetConnectionSQL()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "SQLOLEDB"
  Conn.open "Data Source=Muj;Database=Upload", "sa", ""
  set GetConnection = Conn
end function

function CreateUploadTable(Conn)
  'This function creates upload table for MSSQL 6.5/7.0
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

%>  

<br>Upload to database, store file using AppendChunk method of RecordSet.
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Suitable for upload of big files and MDB database

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
