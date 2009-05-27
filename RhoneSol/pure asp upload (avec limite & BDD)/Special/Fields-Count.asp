<%
'Sample file Fields-Count.asp 
' Sample for Count property
Server.ScriptTimeout = 5000

Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

'was the Form successfully received?
if Form.State = 0 then
  Dim Field, Index

  Response.write "<br>Count of Check1:" & Form.Items.Count("Check1")
  Response.write "<br>Count of Check2:" & Form.Items.Count("Check2")
  Response.write "<br>Count of Check3:" & Form.Items.Count("Check3")
  Response.write "<br>Count of Select field:" & Form.Items.Count("Select field")

  Response.write "<br>"
  Response.write "<br>Count of file fields:" & Form.Files.Count
  Response.write "<br>Count of text fields:" & Form.Texts.Count

  Response.write "<br>"
  Response.write "<br>Count of field no.1:" & Form.Items.Count(1)
  Response.write "<br>Count of field no.28:" & Form.Items.Count(28)
End If'Form.State = 0 then

%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Sample for Count property
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<input Name=SourceFile2 Type=File><br>
<input Name=Description1><br>
<input Type=CheckBox Checked Name=Check1>Check 1<br>
<input Type=CheckBox Checked Name=Check1>Check 1<br>
<input Type=CheckBox Checked Name=Check2>Check 2<br>
<SELECT NAME="Select field" MULTIPLE>
  <OPTION VALUE="Option 1" SELECTED>Option 1
  <OPTION VALUE="Option 2" SELECTED>Option 2
  <OPTION VALUE="Option 3" SELECTED>Option 3
  <OPTION VALUE="Option 4">Option 4
</SELECT><br>
<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>
</Form>



Count of Check1:2
Count of Check2:1
Count of Check3:0
Count of Select field:3

Count of file fields:1
Count of text fields:8

Count of field no.1:1
Count of field no.28:0 