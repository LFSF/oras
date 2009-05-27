<%
  'Sample file Field-SaveAs-I.asp 
  'Save source files with special file names
Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then

  'Get an destination path
  Dim DestPath: DestPath = Server.MapPath(".")

  'File counter
  Dim I: I=1
  For Each File In Form.Files
    Response.Write "<br>File" & I & " was saved as "
    Response.Write DestPath & "\UploadFolder\SourceFile" & I & ".bin"
    '{b}Save file with a new name
    File.SaveAs DestPath & "\UploadFolder\SourceFile" & I & ".bin"
    '{/b}
    I = I+1
  Next
End If'Form.State = 0 then

%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Save source files with special file names
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
