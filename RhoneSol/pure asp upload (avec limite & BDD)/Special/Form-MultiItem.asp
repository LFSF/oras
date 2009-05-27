<%
'Sample file Form-MultiItem.asp 
'Use MultiItem to enumerate MULTIPLE SELECT fields
  Option explicit

  Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")

  If Form.State = 0 then
    Dim Field

    'You can use MultiItem property to access collection of MULTIPLE SELECT form field
    Response.Write "<br>Number of 'NoSelect' fields in the source form:" & Form.Items.MultiItem("NoSelect").Count
    Response.Write "<br>Number of 'SelectOne' fields in the source form:" & Form.Items.MultiItem("SelectOne").Count
    Response.Write "<br>Number of 'SelectMore' fields in the source form:" & Form.Items.MultiItem("SelectMore").Count

    'You can use both MultiItem and Item property to access a value of MULTIPLE SELECT form field

    'Form.Items.MultiItem(...) returns Items collection, the collection values are converted to a string.
    Response.Write "<br>Value of 'NoSelect' field in the source form:" & Form.Items.MultiItem("NoSelect")
    Response.Write "<br>Value of 'SelectOne' field in the source form:" & Form.Items.MultiItem("SelectOne")
    Response.Write "<br>Value of 'SelectMore' field in the source form:" & Form.Items.MultiItem("SelectMore")

    'Form.Items("NoSelect") returns empty
    Response.Write "<br>Value of 'NoSelect' field in the source form:" & Form("NoSelect")
    'Form.Items("SelectOne") returns one field, which is evaluated to a string
    Response.Write "<br>Value of 'SelectOne' field in the source form:" & Form("SelectOne")
    'Form.Items("SelectMore") returns three fields, which are enumerated and evaluated to a string
    Response.Write "<br>Value of 'SelectMore' field in the source form:" & Form("SelectMore")

    'You cannot use Item property to enumerate MULTIPLE SELECT field. 
    'Return type of Item Collection depends on number of form fields with specified name in the source document.
    'Use MultiItem property to enumerate MULTIPLE SELECT fields.

    'Form.Items.MultiItem("NoSelect") contains no field
    For Each Field in Form.Items.MultiItem("NoSelect")
      Response.write "<br>&nbsp;" & Field.Name & ", Length:" & Field.Length & ", Value:" & Field
    Next

    'Form.Items.MultiItem("NoSelect") contains one field
    For Each Field in Form.Items.MultiItem("SelectOne")
      Response.write "<br>&nbsp;" & Field.Name & ", Length:" & Field.Length & ", Value:" & Field
    Next

    'Form.Items.MultiItem("NoSelect") contains three field
    For Each Field in Form.Items.MultiItem("SelectMore")
      Response.write "<br>&nbsp;" & Field.Name & ", Length:" & Field.Length & ", Value:" & Field
    Next
  End If 'Form.State = 0 then
%>  
<br>sample for <A Href=http://www.motobit.com>Huge-ASP file upload</A>
<br>Use MultiItem to enumerate MULTIPLE SELECT fields
<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" >
<input Name=SourceFile1 Type=File><br>
<input Name=SourceFile2 Type=File><br>
<SELECT NAME="NoSelect" SIZE="4" MULTIPLE>
  <OPTION VALUE="Option 1">Option 1
  <OPTION VALUE="Option 2">Option 2
  <OPTION VALUE="Option 3">Option 3
</SELECT><br>

<SELECT NAME="SelectOne" SIZE="4" MULTIPLE>
  <OPTION VALUE="Option 1" SELECTED>Option 1
  <OPTION VALUE="Option 2">Option 2
  <OPTION VALUE="Option 3">Option 3
</SELECT><br>

<SELECT NAME="SelectMore" SIZE="4" MULTIPLE>
  <OPTION VALUE="Option 1" SELECTED>Option 1
  <OPTION VALUE="Option 2" SELECTED>Option 2
  <OPTION VALUE="Option 3" SELECTED>Option 3
</SELECT><br>

<input Name=SubmitButton Value="Submit &gt;&gt;" Type=Submit><br>
</Form>