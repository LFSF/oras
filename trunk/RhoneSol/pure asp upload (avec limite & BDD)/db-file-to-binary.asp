<%
'Simple upload to database.
'Suitable for small files - up to 20% of physical server memory
'This sample works with any connection - MDB (JetOLEDB, ODBC)
' MS SQL (MSDASQL/ODBC) etc.

Server.ScriptTimeout = 240
'Simple upload to database

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 1000
Form.SizeLimit = 1024*1024'1MB

'was the Form successfully received?
Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted
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

    'Add file from source field 'SourceFile' to table field 'Data'
    RS("Data") = Form("SourceFile").ByteArray

		'Some OLEDB drivers (Oracle) requires AppendChunk method
		'Please use next line instead of 'RS("Data") = Form("SourceFile").ByteArray'
    'RS("Data").AppendChunk Form("SourceFile").ByteArray

		'One-block assigning/AppendChunk is suitable for small files 
		'(<20% physical server memory). Plese see documentation to store
		'10th megabytes or more in database.

    'Store technical informations
    RS("ContentType") = Form("SourceFile").ContentType
    RS("SourceFileName") = Form("SourceFile").FileName
    RS("DataSize") = Form("SourceFile").Length

    RS("UploadDT") = Now()
  RS.Update
  RS.Close
  Conn.Close
	response.write "<Font color=green><br>File " & Form("SourceFile").FileName & " (" & Form("SourceFile").Length & "B) was stored to a database"
  response.write "<br>See Upload table in " & Server.MapPath("upload.mdb") & " database.<br><br></Font>"
ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
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

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload sample.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - upload to database, store file to binary data field&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demontrates using 
      of Huge-ASP file upload to store files in server-side database. 
			The sample ASP file is running with Microsoft.Jet.OLEDB (MDB) connection, but you can use it 
			with any other SQL server or file drivers (MS SQL server, Oracle, MySQL, FoxPro driver, etc.).

			</P>
<P>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You can select source file, write some title and description of the file.
Title, description, file name, file size and file contents are stored in server-side database along with current upload time.
</P>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Form size limit is <%=Form.SizeLimit%>B (<%=Form.SizeLimit \ 1024 %>kB - you can change it, see source) .
  </TD></TR></TABLE>

<TABLE cellSpacing=1 cellPadding=3 bordercolor=silver bgcolor=GAINSBORO width="" border=1>
<form method=post ENCTYPE="multipart/form-data">
<TR>
 <TD>&nbsp;</TD>
 <TD Align=Right><input type="submit" Name="Action" value="Upload the file &gt;&gt;"></TD>
</TR>
<TR>
 <TD>File to upload</TD>
 <TD><input type="file" name="SourceFile"></TD>
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

<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>© 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.motobit.com">Motobit Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.motobit.com/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>
</Div>
</BODY></HTML>
