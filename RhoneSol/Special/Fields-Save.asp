<%
'Sample file Fields-Save.asp 
' Save all source files to one destination folder.
'
Option explicit
Server.ScriptTimeout = 5000
'Get an destination path
Dim DestPath: DestPath = Server.MapPath("UploadFolder")

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then


  '{b}Save all source files to the path
  Form.Files.Save DestPath
  '{/b}

  response.write "<br>Files was saved to " & DestPath & " folder."

End If'Form.State = 0 then
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>This sample saves source files to '<%=DestPath%>' folder.

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<Div ID=files>
   File 1 : <input type="file" name="File1"><br>
   File 2 : <input type="file" name="File2">
</Div>
<Input Type=Button Value="Add a file" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"><br>

Description:<input Name=Description1><br>
<input Name=SubmitButton Value="Submit >>" Type=Submit><br>
</Form>

<Script>
var nfiles = 2;
function Expand(){
  nfiles++
  var adh = '<BR> File '+nfiles+' : <input type="file" name="File'+nfiles+'">';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
}
</Script>
