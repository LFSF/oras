<%
'Sample file Fields-Item.asp 
'Enumerate and access source form fields using For-Each
' and using Item(Index)
Option explicit
Server.ScriptTimeout = 5000

'Create upload form
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then
  Dim Field, Index

  Response.write "<br>Enumerate source fields using For Each"
  For Each Field in Form
    Response.write "<br>&nbsp;" & Field.Name & ",Length:" & Field.Length & ", Value:" & Field
  Next

  Response.write "<br>Enumerate source fields using index"
  For Index = 1 To Form.Items.Count
    Set Field = Form.Items(Index)
    Response.write "<br>&nbsp;" & Field.Name & ",Length:" & Field.Length & ", Value:" & Field
  Next
Else 
  Response.write "<br>Form.State:" & Form.State
  
End If'Form.State = 0 then
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<input Name=SourceFile1 Type=File><br>
<input Name=SourceFile2 Type=File><br>
<input Name=Description1><br>
<input Type=CheckBox Checked Name=Check1>Check 1<br>
<input Type=CheckBox Checked Name=Check1>Check 1<br>
<input Type=CheckBox Checked Name=Check2>Check 2<br>
<SELECT NAME="Select field" SIZE="1">
  <OPTION VALUE="Option 1">Option 1
  <OPTION VALUE="Option 1">Option 2
  <OPTION VALUE="Option 1" SELECTED>Option 3
</SELECT><br>
<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>
</Form>





