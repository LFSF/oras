<%
'Stores only files with size less than MaxFileSize

Const imageExts = ".gif,.jpg,.png,.jpeg,.bmp,.ico"


Server.ScriptTimeout = 2000

Dim DestinationPath
DestinationPath = Server.mapPath("UploadFolder")

'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 3600
Form.SizeLimit = &HA000000
response.write "SL:" & Form.SizeLimit 


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
		For Each Field in Form.Files.Items

			
      if len(Field.FileName)=0 then
				'empty file field.
			else'if len(Field.FileName)=0 then
				response.write "<br>File:" & Field.FileName & ", size :" & (Field.Length \ 1024 +1) & "kB"
				if instr(1, imageExts & ",", Field.FileExt & ",", 1)>0 Then 
					Field.Save DestinationPath
					response.write "<Font Color=green> was stored to a disk.</font>"
				else
					response.write "<Font Color=red> is not an image type (" & imageExts & ").</font>" 
				end if
			end if'if len(Field.FileName)=0 then

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
 <TITLE>ASP huge file upload - upload with image preview sample.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> -  upload with image preview sample.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates upload of images with preview (you can see the images before upload). 
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Client-side JavaScript shows preview of image when user choose some image. Server-side ASP accepts all source files, but stores only images (<%=imageExts%>).
<br>Form size limit is <%=Form.SizeLimit \ 1024 %>kB
<br>Destination folder is <%=DestinationPath%>


			</P>
  </TD></TR></TABLE>




<TABLE cellSpacing=1 cellPadding=3 bordercolor=silver bgcolor=GAINSBORO width="" border=1>
<form name="file_upload" method=post ENCTYPE="multipart/form-data" OnSubmit="return ProgressBar();" Action="<%=PostURL%>">
<TR>
 <TD>&nbsp;</TD>
 <TD Align=Right><input type="submit" Name="Action" value="Upload these images &gt;&gt;"></TD>
</TR>
<TR>
 <TD NoWrap>Images to upload<br><Input Type=Button Value="Add an image" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"></TD>
 <TD><Div ID=files>
   Image 1 : <input type="file" name="Image 1" onchange=preview(this) onfocus=preview(this)><br>
   Image 2 : <input type="file" name="Image 2" onchange=preview(this) onfocus=preview(this)><br>
   Image 3 : <input type="file" name="Image 3" onchange=preview(this) onfocus=preview(this)></Div>
</TD>
</TR>
<!--<TR>
 <TD>Description</TD>
 <TD><textarea cols="60" rows="3" name="Description">Type description of the image upload.</textarea></TD>
</TR>-->
<tr><td><Div ID=ImageName>Image preview :</Div></td><td>
<img border=1 ID="ipreview" src=res://shdoclc.dll/warning.gif>
</td></tr>
</form></Table>






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
  var adh = '<BR> Image '+nfiles+' : <input type="file" name="Image '+nfiles+'"  onchange=preview(this) onfocus=preview(this)>';
  files.insertAdjacentHTML('BeforeEnd',adh);
  return false;
}
</Script>


<Script>
//Huge-asp upload preview sample
//http://www.motobit.com

function isImage(file){
	//Get a file extension
	var ext = file.substr(file.lastIndexOf('.')).toLowerCase()

	//Check extension to image types.
	
	return '<%=imageExts%>,'.indexOf(ext+',') >= 0
};

var lastfieldname = ''
function preview(i) {
	//get current input preview
	var file = i.value

	if (file.length<=0) return;

	//or get get preview for one of form field
  //var file = file_upload.SourceFile1.value
  var ipreview = document.getElementById('ipreview');
  //var ipreview = document.all('ipreview')
	if (isImage(file)) {
		//Show preview for the image.
		ipreview.src = 'file://' + file

		ImageName.innerHTML = 'Image preview<br>(' + i.name + ')'
	} else {
		//some default image for preview
		ipreview.src = 'res://shdoclc.dll/warning.gif'
		
//		if (lastfieldname != i.name) alert('Please choose some image file (<%=imageExts%>)');
	};
	lastfieldname = i.name
}

window.onerror = donotmsgboxes;
function donotmsgboxes(msg,url,line)
{	// we do not need error messages
	return true
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
