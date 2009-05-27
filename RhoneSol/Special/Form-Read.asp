<%
'Sample file Form-Read.asp
' Reads source binary data and writes it 'as is' to client
Server.ScriptTimeout = 5000


'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'Do not upload data greater than 4k. 
Form.SizeLimit = 4096

'Read source data {b}
Form.Read
'{/b}

If Form.State <> 4 Then 'POST method
  Response.Write "<br>Data was readed in:" & Form.ReadTime & "ms"

  Response.Write "<br>First 100B of Source data:<pre>" '{b}
  Response.Binarywrite Form.SourceData(, 100) '{/b}
  Response.Write "</pre>"

  Response.Write "<br>All source form data:<pre>"
  Response.Binarywrite Form.SourceData
  Response.Write "</pre>"
End if 

  
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br> Writes source multipart data to client.

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data">
<input Name=SourceFile1 Type=File>
<input Name=SourceFile2 Type=File>
<input Name=Description1>
<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit>
</Form>

