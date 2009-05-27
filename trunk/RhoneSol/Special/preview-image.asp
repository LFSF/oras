<%
'..... ASP handling code
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - simple upload with progress bar indicator.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> -  simple upload with progress bar indicator..&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates work of Huge-ASP file upload with progress bar. 
<br>Form size limit is <%=Form.SizeLimit \ 1024 %>kB
<br>Destination folder is <%=DestinationPath%>


			</P>
  </TD></TR></TABLE>


<form name="file_upload" method="POST" ENCTYPE="multipart/form-data">
<br><input Name=SourceFile1 Type=File onchange=preview(this)>
<br><input Name=SourceFile2 Type=File onchange=preview(this)>
</Form>
Image preview:<br>
<img border=1 ID=ipreview src=res://shdoclc.dll/warning.gif>

<Script>
//Huge-asp upload preview sample
//http://www.motobit.com

function preview(i) {
	//get current input preview
	var file = i.value

	//or get get preview for one of form field
  //var file = file_upload.SourceFile1.value

	//Get a file extension
	var ext = file.substr(file.lastIndexOf('.')).toLowerCase()

	//Check extension to image types.
	var isImage = '.gif,.jpg,.png,.jpeg,'.indexOf(ext+',') >= 0

	if (isImage) {
		//Show preview for the image.
		ipreview.src = 'file://' + file
	} else {
		//some default image for preview
		ipreview.src = 'res://shdoclc.dll/warning.gif'
	};
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
