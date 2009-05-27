<%
'Sample file Form-Email.asp 
' Let's you send one an email with one or more attachments.

'Global declarations.
'Get temporary folder
Dim ResultHTML

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 1000
'Do not upload data greater than 10MB. 
Form.SizeLimit = &HA00000

'Progress bar window will receive the same ID.
Form.UploadID = Request.QueryString("UploadID")'{/b}

Const fsCompletted  = 0

If Form.State = fsCompletted Then 'Completted
  ResultHTML = ProcessForm
ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: ResultHTML = "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else ResultHTML = "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If 
if request.QueryString("Action") = "Cancel" then
	ResultHTML = "<br><b>Upload was cancelled</b>"
end if

Function TempFolder()
	Dim FS
  Set FS = CreateObject("Scripting.FileSystemObject")
  'Get temporary folder
  TempFolder = FS.GetSpecialFolder(2) & "\emailtemp"
End Function

Sub DeleteFile(FileName)
	Dim FS
  Set FS = CreateObject("Scripting.FileSystemObject")
	FS.DeleteFile FileName
End Sub




Function ProcessForm
  Dim eFrom, eTo, Subject, Message

  'get source form fields - From, To, Subject and Message
  eFrom = Form("From")
  eTo = Form("To")
  Subject = Form("Subject")
  Message = Form("Message")
  
  Dim HTML
  HTML = "<br><Font Color=red>     Server-side ASP script accepted source form with fields and files and email object was created. "
  HTML = HTML & "<br>From: <b>" & eFrom & "</b>"
  HTML = HTML & "<br>To: <b>" & eTo & "</b>"
  HTML = HTML & "<br>Subject: <b>" & Subject & "</b>"
  HTML = HTML & "<br>Message: <b>" & Message & "</b>"

  Dim objNewMail, File, FileName

  'Create a new email message
  Set objNewMail = CreateObject("CDONTS.NewMail")
  Const CdoMailFormatMime = 0
  objNewMail.MailFormat = CdoMailFormatMime
  'Save source files to temporary folder
  'Add these files to the new e-mail
	HTML = HTML & "<br>Attachments:"
  For Each File In Form.Files.Items

    'If source file is specified.
    If Len(File.FileName) > 0 Then

		  HTML = HTML & "<br>&nbsp;" & File.Name & ": <b>" & File.FileName & ", " & File.Length \ 1024 & "kB</b>"
      FileName = TempFolder & "\" & File.FileName 
    
      File.SaveAs FileName
      
      objNewMail.AttachFile FileName
    End If
  Next
  
  'Send the new email
  objNewMail.Send eFrom, eTo, Subject, Message

  'delete temporary files
  For Each File In Form.Files.Items
    If Len(File.FileName) > 0 Then
      FileName = TempFolder & "\" & File.FileName
      on error resume next
      DeleteFile FileName
    End If
  Next
  HTML = HTML & "</Font><br>"
  ProcessForm = HTML
End Function



'{b}get an unique upload ID for this upload script and progress bar.
Dim UploadID, PostURL
UploadID = Form.NewUploadID

'Send this ID as a UploadID QueryString parameter to this script.
PostURL = Request.ServerVariables("SCRIPT_NAME") & "?UploadID=" & UploadID'{/b}
%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload with progress bar indicator sample.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload with progressbar live sample</A>&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demontrates&nbsp;using 
      of Huge-ASP upload&nbsp;with a&nbsp;simple email html form&nbsp;and 
      file&nbsp;attachments. The form contains usual email fields (From, To, 
      Subject, Message) and one form field for file attachement. Number of file 
      fields can be extended using 'Add a file' button (The button uses 
      client-side Javascript and insertAdjacentHTML 
      method).<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Server-side ASP script 
      accepts source form fields and files using Huge-ASP upload and 
      then&nbsp;creates an email using CDONTS.NewMail.</P>
			<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This is only short sample, does not contain from/to emails validation or other fields validation.</p>
<br>      Temporary folder for e-mail file attachments is <%=TempFolder%>
  </TD></TR></TABLE>
<%=ResultHTML%>

<TABLE cellSpacing=1 cellPadding=3 bordercolor=silver bgcolor=GAINSBORO width="100%" border=1>
<form method="post" ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar();" Action="<%=PostURL%>">
  <TBODY>
  <tr><td> From : </td><td><input Name=From Size=50 value="<%=Form("From")%>"></td></tr>

  <tr><td> To : </td><td><input Name=To Size=50 value="<%=Form("To")%>"></td></tr>

  <tr><td> Subject : </td><td><input Name=Subject Size=80  value="<%=Form("Subject")%>"></td></tr>

  <tr><td ColSpan=2> Message:
    <br><TEXTAREA name=Message rows=6 cols=76><%=Form("Message")%></TEXTAREA>
  </td></tr>

  <tr><td ColSpan=2>File attachments:
     Form size limit is <%=Form.SizeLimit%>B (<%=Form.SizeLimit \ 1024 %>kB).<br>
    <DIV ID=files>
       Attachment 1 : <input type="file" name="File 1">
    </DIV>
    <INPUT Type=button Value="Add a file" OnClick=return(Expand()) 
     Style="BORDER-RIGHT: 0px; BORDER-TOP: 0px; BACKGROUND: yellow; BORDER-LEFT: 0px; CURSOR: hand; BORDER-BOTTOM: 0px">
  </td></tr>

  <tr><td ColSpan=2 Align=right>
    <input Name=SubmitButton Value="Send email &gt;&gt;" Type=submit>
    </td></tr>
  </form></TBODY>
</TABLE>

<br>

<SCRIPT>
//Script to add an attachment file field 
var nfiles = 1;
function Expand(){
  nfiles++
  var adh = '<BR> Attachment '+nfiles+' : <input type="file" name="File '+nfiles+'">';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
};

//Open a window with progress bar indicator.
function ProgressBar(){
  var ProgressURL
  ProgressURL = 'progress.asp?UploadID=<%=UploadID%>'

  var v = window.open(ProgressURL,'_blank','toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=350,height=200')
  
  return true;
}
</SCRIPT>

<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>© 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.motobit.com">Motobit Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.motobit.com/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>
</Div>
</BODY></HTML>
