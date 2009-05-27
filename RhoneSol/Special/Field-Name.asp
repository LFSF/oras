<%
'Sample file Field-Name.asp 
Server.ScriptTimeout = 5000
'Enumerate all source fields and write its names 
Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'was the Form successfully received?
if Form.State = 0 then

  response.write "<br>Form.Items.Count:" & Form.Items.Count

  For each Item in Form
    Dim I:I = I + 1
    response.write "<br><br>Item no.:" & I
    response.write "<br>Length:" & Item.Length
    '{b}Write name of the source field
    response.write "<br>Name:" & Item.Name
    '{/b}
  Next
End If'Form.State = 0 then
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<input Name=SourceFile1 Type=File><br>
<input Name=SourceFile2 Type=File><br>
<input Name=Description1 Value="Some description"><br>
<input Type=CheckBox Checked Name=Check1 Value="abcdefgh">Check 1<br>
<input Type=CheckBox Checked Name=Check1>Check 1<br>
<input Type=CheckBox Checked Name=Check2>Check 2<br>
<SELECT NAME="Select field" SIZE="1">
  <OPTION VALUE="Option 1">Option 1
  <OPTION VALUE="Option 1">Option 2
  <OPTION VALUE="Option 1" SELECTED>Option 3
</SELECT><br>
<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>
</Form>
