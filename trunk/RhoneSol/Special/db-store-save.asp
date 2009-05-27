<%
'Sample file Field-SaveAs.asp 
'Store extra upload info to a database
' and file contents to the disk
Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then

  'Create destination path+filename for the source file.
  Dim DestinationPath, DestinationFileName
  DestinationPath = Server.mapPath("UploadFolder")
  DestinationFileName = DestinationPath & "\" & Form("SourceFile").FileName


  'Open recordset to store uploaded data
  Dim RS: Set RS = OpenUploadRS

  'Store extra info about upload to database
  RS.AddNew
   RS("UploadDT") = Now()
   RS("Description") = Form.Texts("Description")
   RS("SourceFileName") = Form("SourceFile").FilePath
   RS("DestFileName") = DestinationFileName
   RS("DataSize") = Form("SourceFile").Length
   '...
  RS.Update

  Response.write "<br>Source file names:"
  Dim Field: For Each Field in Form.Files
    Response.write "<br>&nbsp;" & Field.FileName
  Next

  '{b}Save file to the destination
  Form("SourceFile").SaveAs DestinationFileName
  '{/b}
  response.write "<br>SourceFile was saved as " & DestinationFileName
  response.write "<br>See ListFiles table in " & Server.MapPath("upload.mdb") & " database."

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
<br><br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Store extra upload info to a database
<br> and file contents to the disk
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data">
<br>File1: <input Name=SourceFile Type=File>
<br>Description: <input Name=Description value="some description to write to database.">
<br><input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>
</Form>