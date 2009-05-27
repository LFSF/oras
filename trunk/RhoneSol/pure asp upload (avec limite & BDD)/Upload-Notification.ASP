<%
'Stores only files with size less than MaxFileSize

'notification address 
Const NotifyAddress = "admin@myweb.com"


Dim DestinationPath, rHTML
DestinationPath = Server.mapPath("UploadFolder")

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 2000
Form.SizeLimit = &HA00000

'********************** Form processing

'{b}Set the upload ID for this form.
'Progress bar window will receive the same ID.
if len(Request.QueryString("UploadID"))>0 then
	Form.UploadID = Request.QueryString("UploadID")'{/b}
end if


'was the Form successfully received?
Const fsCompletted  = 0
If Form.State = fsCompletted Then 'Completted
  'was the Form successfully received?
  if Form.State = 0 then
    'Do something with upload - save, enumerate, ...
    rHTML = rHTML &  "<br><b>Upload result: Form was accepted.</b>" 
    rHTML = rHTML &  "<br>Number of file fields:" & Form.Files.Count
    rHTML = rHTML &  "<br>Request total bytes:" & Request.TotalBytes
		Form.Files.Save DestinationPath 
		rHTML = rHTML &  "<br>Files was saved to " & DestinationPath & " folder."
  End If
ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: rHTML = rHTML &   "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else rHTML = rHTML &  "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then

response.write rHTML

'********************** Notification

if Request.ServerVariables("REQUEST_METHOD") = "POST" then
	'Create a report email

  Set objNewMail = CreateObject("CDONTS.NewMail")
  Const CdoMailFormatMime = 0
  objNewMail.MailFormat = CdoMailFormatMime
	objNewMail.BodyFormat = 0 ' HTML
	Subject = "Upload of files - user '" & request.servervariables("REMOTE_USER") & "'"
	Message = rHTML
	Message = Message & "<br><br>Time: " & Now
	Message = Message & "<br>Total size:" & Form.TotalBytes & "B (" & Form.TotalBytes \1024 + 1 &  "kB)"
	Message = Message & "<br>Fields:" 

	Dim Field
	For each Field In Form.Items.Items
		Message = Message  & "<br>" & Field.Name & ":" 
		if Field.isFile then
			if len(Field.FileName)>0 then
				Message = Message  & " file " & Field.FileName & "," & Field.Length \1024 + 1 & "kB"
			else'if len(Field.FileName)>0 then
				Message = Message  & " empty file field."
			end if'if len(Field.FileName)>0 then
		else'if Field.isFile then
			Message = Message  & " text '" & Field.String & "'"
		end if 'if Field.isFile then
	Next
  
  'Send the new email
  objNewMail.Send "Huge-ASP upload", NotifyAddress, Subject, Message
End If



'********************** HTML Form prepare
'{b}get an unique upload ID for this upload script and progress bar.
Dim UploadID, PostURL
UploadID = Form.NewUploadID

'Send this ID as a UploadID QueryString parameter to this script.
PostURL = Request.ServerVariables("SCRIPT_NAME") & "?UploadID=" & UploadID'{/b}

%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - upload with administrator email notification.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - upload with administrator email notification.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample accepts uploaded file, creates an report for site administrator and the report is sent to administrator email using CDONTS. 
<br>Form size limit is <%=Form.SizeLimit \ 1024 %>kB
<br>Destination folder is <%=DestinationPath%>
<br>Administrator email address <%=NotifyAddress%>


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

Description: <input Name=Description1 Size=60><br>
<input Name=SubmitButton Value="Submit »" Type=Submit><br>
</Form>

<SCRIPT>
//Open window with progress bar.
function ProgressBar(){
  var ProgressURL
  ProgressURL = 'progress.asp?UploadID=<%=UploadID%>'

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
