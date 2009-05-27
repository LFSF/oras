<%
'Sample file Form-MaxMemory.asp 
' 
'

Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'Set maximum memory storage to 1MB {b}
Form.MaxMemoryStorage = &H100000
'{/b}

'was the Form successfully received?
if Form.State = 0 then
  Form.Files.Save "c:\upload"
  
  response.write "<br>n of Items:" & Form.Items.Count
  
  response.write "<br>n of Fields:" & Form.Fields.Count
  response.write "<br>n of Files:" & Form.Files.Count
  response.write "<br>" & vbCrLf
  
  response.Write "<br>Form.MaxMemoryStorage:" & Form.MaxMemoryStorage
End If'Form.State = 0 then

%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<br><input Name=SourceFile1 Type=File>
<br><input Name=Description1>
<br><input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit>
</Form>
