<%
Option Explicit
Dim ResultHTML

'Some value greater than default of 60s (According to upload size.)
'The maximum speed is about 100kB/s for IIS4, P200 and local upload, 4kB/s for modem users.
Server.ScriptTimeout = 200

Dim DestinationPath
DestinationPath = Server.MapPath(".")'Folder to store uploaded files
LogFolder = Server.MapPath(".")      'Folder to store log file with info about upload request.

if IncludeType=1 then'For ScriptUtilities
  'Enables upload limit according to memory (up to 100MB)
  UploadSizeLimit = 10000000
Else'For Pure-ASP upload
  'Set upload limit to 100k. PureASP uses  byte-to-char ASP conversion 
  '(BinaryToString() function) and it takes a lot of the processor time
  'You can change the value, but with some server performance leak.
  'Next are convert/save times for P200 :
  'Seze        16k   32k    64k   128k   256k   512k  1024k  2048k  4096k
  'Time (ms)   551  1182   2303   4597   9173  18827  36783  77221 177115 
  UploadSizeLimit = 100000
End If

If Request.ServerVariables("REQUEST_METHOD") = "POST" Then 'Request method must be "POST" for get the fields
'  BeginTimer 'Starts timer.
  '*************************************************   Main Upload - start
    Dim Upload
'    on error resume next

    'Gets uploaded fields
    Set Upload = GetUpload()
    'There are all of form fields in the Fields object. Example :
    'Upload("File1").ContentType - content type of File1 field
    'Upload("File1").Value.String - File1 field converted to a string
    'Upload("File1").Value.ByteArray - File1 field as safearray to store in binary RS field or file
    'Upload("Comments").Value.String - value of Comments field
    'See HTML documentation of FormFields class (ScriptUtilities, http://www.pstruh.cz)

    ResultHTML = ""
    If Err = 0 Then 'Upload was OK
      'Write statistics about upload. Optional.

      Dim Field
      For Each Field In Upload.Items
        ResultHTML = ResultHTML & "<br>Field : <b>" & LogF(Field.Name) & "</b>, Length : <b>" & LogFn(Field.Length) & "</b>, Content-Type : <b>" & LogF(Field.ContentType) & "</b>, SourceFileName : <b>" & LogF(Field.FileName) & "</b>"
      Next

      'Saves the fields to the disk, writes result to the client and writes log.
      'See utils.inc. You can change the function to save the files to another location.
      ResultHTML = ResultHTML & "<BR>" & SaveUpload(Upload, DestinationPath, LogFolder)
    Else 'Error in upload. Write the error
      'The error can be one of :
      'Upload size exceeds limit
      'Zero length request
      'No file sent
      'Bad request method - must be post
      ResultHTML = ResultHTML & "<br>Error : " & Err.Description
    End If
    On Error GoTo 0
    Upload = Empty 'Clear the variable
  '*************************************************   Main Upload - end
'  EndTimer 'Writes info about consumed time.
End If 'Request method must be "POST"

%>
<%'upload.inc, contains GetUpload function, Required for upload - only the one file%>
<!--#INCLUDE FILE="upload.inc"-->
<%'utils.inc, contains SaveUpload function%>
<!--#INCLUDE FILE="utils.inc"-->
<%'format.inc, contains head and Foot function, optional.%>
<!--#INCLUDE FILE="format.inc"-->
<%
response.write Head("Sample multiple binary files upload via ASP", "Demonstrates using of the ByteArray class for working with binary data from Request.BinaryRead.")
response.write upDescription
%>

<Table Width=600>
  <form method=post ENCTYPE="multipart/form-data">
    
    <TR BGColor=Silver><TD></TD><TD Align=Right><input type="submit" Name="Action" value="Upload the files >>"></TD></TR>
    <TR><TD ColSpan=2>
      <Table Width=100% Border=0 cellpadding=0 cellspacing=0><tr><TD>
      <Div ID=files>
         File 1 : <input type="file" name="File1"><br>
         File 2 : <input type="file" name="File2">
      </Div>
      <TD><TD Align=right VAlign=top>
        <Input Type=Button Value="Add a file" OnClick=return(Expand()) Style="border=0;background=white;cursor:hand">
      </TD></TR></Table>
    </TD></TR>
    <TR><TD>Checkbox</TD><TD><input type="CHECKBOX" name="Check1" Checked></TD></TR>
    <TR><TD>Password</TD><TD><input type="PASSWORD" name="PASSWORD"></TD></TR>
    <TR><TD>Comments</TD><TD><input size="60" name="Comments" value="Some comments."></TD></TR>
    <TR><TD>Description</TD><TD><textarea cols="60" rows="8" name="Description">Some long text of any size - without 80k limit of ASP Request.Form("...").</textarea></TD></TR>
  </form>
</Table>
<HR> <%=ResultHTML%>
<Script>
  var nfiles = 2;
  function Expand(){
    nfiles++
    files.insertAdjacentHTML('BeforeEnd','<BR> File '+nfiles+' : <input type="file" name="File'+nfiles+'">');
    return false
  }
</Script>
<%=Foot%>
