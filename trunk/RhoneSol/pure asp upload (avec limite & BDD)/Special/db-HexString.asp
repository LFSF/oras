<%
'Sample file db-HexString.asp 
'Upload to MS SQL database, store file using HexString method and Insert statement
'Suitable for upload of small files (up to 20% of memory) 
'   and MS SQL databse (MS SQL 6.5 - MS SQL 2000)

Server.ScriptTimeout = 36000

'Upload large files to MS SQL Server using HexString
Dim d: D="" & time: d=replace(d,":","")

'CreateUploadTable GetConnection

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Form.TempPath = "h:\temp"
'was the Form successfully received?
if Form.State = 0 then
  dim Conn, SQL, RS, UploadID
  'Open connection to database
  Set Conn = GetConnection 

  'Create template of insert statement 
  SQL = "SET NOCOUNT ON Insert into Upload(UploadDT, ContentType, SouceFileName, Title, [Description], Data) values("
  SQL = SQL & "GetDate()"
  SQL = SQL & ", '" & Form("DBFile").ContentType & "'"
  SQL = SQL & ",  '" & Form("DBFile").FileName & "'"
  SQL = SQL & ",  '" & Form("Title") & "'"
  SQL = SQL & ",  '" & Form("Description") & "'"
  SQL = SQL & ",0x%s)" & vbCrLf
  SQL = SQL & "Select @@IDENTITY as UploadID"
  
  '{b}Write source file to the Insert statement as a HexString
  SQL = replace(SQL, "%s", Form("DBFile").HexString)
  '{/b}

  Set RS = Conn.Execute(SQL)
    UploadID = RS("UploadID")
  RS.Close

  Conn.Close
Else
  Response.Write "<br>Form.State:" & Form.State
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
<br>Upload to MS SQL database, store file using HexString method and Insert statement
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Suitable for upload of small files (up to 20% of memory) and MS SQL databse (MS SQL 6.5 - MS SQL 2000)

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
