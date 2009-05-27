<%
'Sample file Form-Texts.asp
' Enumerates all text (non-file) source fields.
'
Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then
  'Number of text fields {b}
  response.write "<br>n of text fields:" & Form.Texts.Count
  '{/b}
  response.write "<br>" & vbCrLf

  Response.write "Text field names and length:"
  'Enumerate texts {b}
  Dim Field: For Each Field in Form.Texts
    '{/b}
    Response.write "<br>&nbsp;" & Field.Name & " - " & Field.Length
  Next

End If'Form.State = 0 then

%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Enumerates all text (non-file) source fields.

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
File1:<input Name=SourceFile1 Type=File><br>
File2:<input Name=SourceFile2 Type=File><br>
Description:<input Name=Description1><br>
<input Type=CheckBox Name=Save>Also save<br>
<TextArea Name=LongText Cols=60 Rows=10></TextArea><br>
<input Type=HIDDEN Name=HIDDENField Value="Some hidden data">
<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>

</Form>

