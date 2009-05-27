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
Form.SizeLimit = &HA00000

If Form.State = 0 Then 'Completted
  Dim File, DestFileName
  For Each File In Form.Files.Items
		If Len(File.FileName) > 0 Then
        DestFileName = GetUniqueFileName(File.FileName, DestinationPath)

        File.SaveAs DestinationPath & "\" & DestFileName
        Response.Write "<br><Font Color=green>File " & File.FileName & _
					" was saved to " & DestinationPath & " as " & DestFileName & "</Font>"
	  End If
  Next
ElseIf Form.State > 10 then
  Const fsSizeLimit = &HD
  Select case Form.State
		case fsSizeLimit: response.write  "<br><Font Color=red>Source form size (" & Form.TotalBytes & "B) exceeds form limit (" & Form.SizeLimit & "B)</Font><br>"
		case else response.write "<br><Font Color=red>Some form error.</Font><br>"
  end Select
End If'Form.State = 0 then

Dim gFS
Function GetUniqueFileName(FileName, DestPath)
  if isempty(gFS) then Set gFS = CreateObject("Scripting.FileSystemObject")
  Dim Counter, FullPath, NewFileName
  Counter = 1
  NewFileName = FileName
  
  if gFS.FileExists(DestPath & "\" & NewFileName) then
		Do 
			Counter = Counter + 1
			NewFileName = Counter & "-" & FileName
		Loop while gFS.FileExists(DestPath & "\" & NewFileName)
  end if
  GetUniqueFileName = NewFileName
End Function


%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
 <TITLE>ASP huge file upload - upload with unique server-side file names.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - upload with unique server-side file names.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates upload of files to server-side. Each file is stored with unique file name. 
      <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If you upload file with same name as a file existing on server-side (filename.ext), the new file is stored with modified file name (1-filename.ext, 2-filename.ext, ...)
			

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
