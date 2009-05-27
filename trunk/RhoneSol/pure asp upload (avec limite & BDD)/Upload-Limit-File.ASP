<%
'Stores only files with size less than MaxFileSize

Const MaxFileSize = &H100000
Server.ScriptTimeout = 2000

Dim DestinationPath
DestinationPath = Server.mapPath("UploadFolder")

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 1000
Form.SizeLimit = &HA00000

'{b}Set the upload ID for this form.
'Progress bar window will receive the same ID.
if len(Request.QueryString("UploadID"))>0 then
	Form.UploadID = Request.QueryString("UploadID")'{/b}
end if
'was the Form successfully received?
Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted

'  Form.TempPath = "Z:\Temp"
  

  'was the Form successfully received?
  if Form.State = 0 then
    'Do something with upload - save, enumerate, ...
    response.write "<br><b>Upload result: Form was accepted.</b>" 
    response.write "<br>Number of file fields:" & Form.Files.Count
    response.write "<br>Request total bytes:" & Request.TotalBytes
    Dim Field
    For each Field in Form.Files.Items
			response.write "<br>File:" & Field.FileName & ", size :" & (Field.Length \ 1024 +1) & "kB"
      if Field.Length<=MaxFileSize Then 
				Field.Save DestinationPath
				response.write "<Font Color=green> was stored to a disk.</font>"
			else
				response.write "<Font Color=red> exceeds file limit (" & (MaxFileSize \ 1024 +1) & "kB).</font>"
			end if

    Next
    
  End If
ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then


'{b}get an unique upload ID for this upload script and progress bar.
Dim UploadID, PostURL
UploadID = Form.NewUploadID

'Send this ID as a UploadID QueryString parameter to this script.
PostURL = Request.ServerVariables("SCRIPT_NAME") & "?UploadID=" & UploadID'{/b}

%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - file size limit with progress bar.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - file size limit with progress bar.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates work of HugeASP upload with progress bar and file size limit. 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;The usual upload limit is a limit for whole upload. You can define this limit using Form.SizeLimit property. This property has a great performance and security impact - if you set this limit, HugeASP upload will not accept/read any data exceeding this limit. 
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;You can specify more with this sample script - limit per file in a source form. This sample has a limit of <%=Form.SizeLimit \ 1024 %>kB for whole form size (sum of all files size + size of text fields) and <%=MaxFileSize \ 1024 %>kB per file.
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Progress bar for this file (progress-limit.asp) also contains per file limit, so client can see file size validity during upload.


			</P>
  </TD></TR></TABLE>

<form name="file_upload" method="POST" ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar();" Action="<%=PostURL%>">

<Div ID=files>
   File 1 : <input type="file" name="File1"><br>
   File 2 : <input type="file" name="File2"><br>
   File 3 : <input type="file" name="File3">
</Div>

<Input Type=Button Value="Add a file" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"><br>

Description:<input Name=Description1 Size=60><br>
<input Name=SubmitButton Value="Submit »" Type=Submit><br>
</Form>

<SCRIPT>
//Open window with progress bar.
function ProgressBar(){
  var ProgressURL
  ProgressURL = 'progress-limit.asp?UploadID=<%=UploadID%>'

  var v = window.open(ProgressURL,'_blank','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=350,height=200')
  
  return true;
}
</SCRIPT> 

<Script>
//Expand form with a new File fields if needed.
var nfiles = 3;
function Expand(){
  nfiles++
  var adh = '<BR> File '+nfiles+' : <input type="file" name="File'+nfiles+'">';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
}
</Script>





<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>© 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.motobit.com">Motobit Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.motobit.com/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>
</Div>
</BODY></HTML>
