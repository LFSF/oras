<%
'Sample file db-bytearay.asp 
'Simple upload to database.
'Suitable for small files - up to 20% of physical server memory
'This sample works with any connection - MDB (JetOLEDB, ODBC)
' MS SQL (MSDASQL/ODBC) etc.

Server.ScriptTimeout = 240
'Simple upload to database

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

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

    'Add file from source field 'DBFile' to table field 'Data'
    RS("Data") = Form("DBFile").ByteArray

    'Store technical informations
    RS("ContentType") = Form("DBFile").ContentType
    RS("SourceFileName") = Form("DBFile").FileName
    RS("DataSize") = Form("DBFile").Length

    RS("UploadDT") = Now()
  RS.Update
  RS.Close
  Conn.Close
	response.write "<br>File " & Form("DBFile").FileName & " was stored to database"
  response.write "<br>See Upload table in " & Server.MapPath("upload.mdb") & " database.<br><br>"
End If'Form.State = 0 then

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.open "Data Source=" & Server.MapPath("upload.mdb") 
	set GetConnection = Conn
end function

function CreateUploadTable(Conn)
  'This function creates upload table for MSSQL 6.5/7.0/2000
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
Simple upload to database, sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>.<br>
Suitable for small files - up to 20% of physical server memory<br>

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
