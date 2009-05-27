<%
'Sample file SimpleUpload.asp 
Server.ScriptTimeout = 1000
Dim DestPath: DestPath = Server.MapPath("UploadFolder")

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
If Form.State = 0 Then
  Form.Files.Save DestPath
  response.write "<br>Files was saved to " & DestPath & " folder."
Else 
  'Handle other form states.
End If
%>
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>This sample saves source files to '<%=DestPath%>' folder.

<Body>
<form method=post ENCTYPE="multipart/form-data">

<input type="submit" value="Upload the files >>"><br>
<Div ID=files>
 File 1 : <input type="file" name="File1"><br>
 File 2 : <input type="file" name="File2">
</Div>
<Input Type=Button Value="+Add a file" OnClick=Expand()>
<Script>
  var nfiles = 2;
  function Expand(){
    nfiles++;
    files.insertAdjacentHTML('BeforeEnd','<BR> File '+nfiles+' : <input type="file" name="File'+nfiles+'">');
  }
</Script>
</Body>