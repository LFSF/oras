<%
'Sample file Form-ChunkSize.asp 
' 
'
Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

If Request.TotalBytes>0 and Request.TotalBytes<100000 then
  'Read short source data in one block {b}
  Form.ChunkReadSize = 0
  '{/b}
End If

'was the Form successfully received?
if Form.State = 0 then
  response.write "<br>n of Items:" & Form.Items.Count
  
  response.write "<br>n of Fields:" & Form.Fields.Count
  response.write "<br>n of Files:" & Form.Files.Count
  response.write "<br>" & vbCrLf
  
  response.Write "<br>Form.BlockLength:" & Form.ChunkReadSize
End If'Form.State = 0 then
  
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<br><input Name=SourceFile1 Type=File>
<br><input Name=SourceFile2 Type=File>
<br><input Name=Description1>
<br><input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit>
</Form>
