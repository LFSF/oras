<%
'Sample file Field-SaveAs.asp 
'Store extra upload info to a database
' and file contents to the disk
Server.ScriptTimeout = 5000

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 


Server.ScriptTimeout = 1000
Form.SizeLimit = &HA00000'10MB

'was the Form successfully received?
Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted

  'Create destination path+filename for the source file.
  Dim DestinationPath, DestinationFileName
  DestinationPath = Server.mapPath("UploadFolder")
  DestinationFileName = DestinationPath & "\" & Form("SourceFile").FileName


  'Open recordset to store uploaded data
  Dim RS: Set RS = OpenUploadRS

  'Store extra info about upload to database
  RS.AddNew
   RS("UploadDT") = Now()
   RS("Description") = Form.Texts.Item("Description")
   RS("SourceFileName") = Form("SourceFile").FilePath
   RS("DestFileName") = DestinationFileName
   RS("DataSize") = Form("SourceFile").Length
   '...
  RS.Update

  Response.write "<br>Source file names:"
  Dim Field: For Each Field in Form.Files.Items
    Response.write "<br>&nbsp;" & Field.FileName
  Next
  '{b}Save file to the destination
  Form("SourceFile").SaveAs DestinationFileName
  '{/b}

  response.write "<Font color=green><br>SourceFile was saved as " & DestinationFileName
  response.write "<br>See ListFiles table in " & Server.MapPath("upload.mdb") & " database.</Font>"

ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then

Function OpenUploadRS()
  Dim RS  : Set RS = CreateObject("ADODB.Recordset")

  'Open dynamic recordset, table Upload
  RS.Open "ListFiles", GetConnection, 2, 2
  
  Set OpenUploadRS = RS
end Function 

Function GetConnection()
  dim Conn: Set Conn = CreateObject("ADODB.Connection")
  Conn.Provider = "Microsoft.Jet.OLEDB.4.0"
  Conn.open "Data Source=" & Server.MapPath("upload.mdb") 
	set GetConnection = Conn
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
      file upload</A> - upload to disk, store extra file upload info in a database&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demontrates using 
      of Huge-ASP file upload to upload files to server and store file path in server-side database. 
			The sample ASP file is running with Microsoft.Jet.OLEDB (MDB) connection, but you can use it 
			with any other SQL server or file drivers (MS SQL server, Oracle, MySQL, FoxPro driver, etc.).
			</P>
<P>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You can select source file and write some description of the file.
Source file is stored on server disk. Description, file name, file size and path to stored file are saved in server-side database along with current upload time.
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
