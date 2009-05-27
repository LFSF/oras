<%
Option Explicit
'Stores only files with size less than MaxFileSize


Dim DestinationPath
DestinationPath = Server.mapPath("UploadFolder")

'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 


Server.ScriptTimeout = 2000
Form.SizeLimit = &H100000

If Form.State = 0 Then 'Completted
	Form.Files.Save DestinationPath 
	response.write "<br><Font Color=green>Files (" & Form.TotalBytes \1024 & "kB) was saved to " & DestinationPath & " folder.</Font>"
ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then


%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - base upload.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - base upload.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates shortes possible server-side code.
			ASP code specifies only Form.SizeLimit (maximum size of upload), Server.ScriptTimeout (maximum time to do upload) and DestinationPath (folder to store uploaded files).

<br>Upload timeout is <%=Server.ScriptTimeout%>s
<br>Form size limit is <%=Form.SizeLimit \ 1024 %>kB
<br>Destination folder is <%=DestinationPath%>


			</P>
  </TD></TR></TABLE>





<form method="POST" ENCTYPE="multipart/form-data">

   File 1 : <input type="file" name="File1"><br>
   File 2 : <input type="file" name="File2"><br>
   File 3 : <input type="file" name="File3">
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<input Name=SubmitButton Value="Upload files &gt;&gt;" Type=submit><br>

</Form>






<HR COLOR=silver Size=1>
<CENTER>
<FONT SIZE=1>© 1996 – <%=year(date)%> Antonin Foller, <a href="http://www.motobit.com">Motobit Software</a>, e-mail <A href="mailto:help@pstruh.cz" >help@pstruh.cz</A>
<br>To monitor current running uploads/downloads, see <A Href="http://www.motobit.com/help/iistrace/iis-monitor.asp">IISTracer - IIS real-time monitor</A>.
</FONT>

</CENTER>
</Div>
</BODY></HTML>
