<%
'Sample file Field-Save.asp
'Upload - Save source fields to different loactions
Server.ScriptTimeout = 5000

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'was the Form successfully received?
if Form.State = 0 then

  'Get an destination path
  Dim DestPath: DestPath = Server.MapPath(".")


  '{b}Save SourceFile1 to folder folder1
  Form.Files("SourceFile1").Save DestPath & "\folder1"
  response.write "<br>SourceFile1 was saved to " & DestPath & "\folder1"

  'Save SourceFile2 to folder folder2
  Form.Files("SourceFile2").Save DestPath & "\folder2"
  response.write "<br>SourceFile2 was saved to " & DestPath & "\folder2"
  '{/b}
End If'Form.State = 0 then

%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >

File1:<input Name=SourceFile1 Type=File><br>
File2:<input Name=SourceFile2 Type=File><br>
Description:<input Name=Description1><br>
<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>
</Form>