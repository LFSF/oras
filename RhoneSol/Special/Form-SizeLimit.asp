<%
'Sample file Form-SizeLimit.asp
' Lets you specify maximum amount od data which will ASPForm accept.
'
Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'Do not upload data greater than 1MB. {b}
Form.SizeLimit = &H100000
'{/b}


Const fsCompletted  = 0
Const fsSizeLimit   = &HD

response.write "<br>State:" & Form.State
If Form.State = fsSizeLimit Then 'Data exceeds limit. 
  Response.Write "<br>Form data exceeds limit (" & Form.SizeLimit/1024 & "kB)."
ElseIf Form.State = fsCompletted Then 'Completted
  'Process form fields
  response.write "<br>n of Items:" & Form.Items.Count
  response.write "<br>n of Text fields:" & Form.Texts.Count
  response.write "<br>n of Files:" & Form.Files.Count
Else 
  Response.Write "<br>Form.State:" & Form.State
  'Another upload error - client is not connected, partial data, ....
End if 

  
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br> Lets you specify maximum amount od data which will ASPForm accept.
<br> Form.SizeLimit is <%=Form.SizeLimit%> B (<%=Form.SizeLimit \ &H100000 %>MB).
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data">
<br><input Name=SourceFile1 Type=File>
<br><input Name=SourceFile2 Type=File>
<br><input Name=Description1>
<br><input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit>
</Form>

