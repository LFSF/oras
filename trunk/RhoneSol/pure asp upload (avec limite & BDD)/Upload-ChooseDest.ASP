<%
'Stores files to the clients specified destination folder
'Client can choose folder from a dropdown
'Remember that ther is NO good idea to let clients store files in ANY folder!


Dim DestinationsToChoose, cDest
DestinationsToChoose = Array("c:\upload", "d:\inetpub\data1", "f:\store")


'Create upload form
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 

Server.ScriptTimeout = 2000
Form.SizeLimit = &HA00000

If Form.State = 0 Then 'Completted
	Dim DestinationPath, fDestination

	'read destination index
	fDestination = Form("fDestination")

	if len(fDestination)>0 then
		'Destination is specified. check its validity.
		fDestination = clng(fDestination)
		if fDestination>=0 and fDestination<=ubound(DestinationsToChoose) then
			DestinationPath = DestinationsToChoose(fDestination)
		end if
	end if'if len(fDestination)>0 then
	if len(DestinationPath) > 0 then
		Form.Files.Save DestinationPath 
		response.write "<br><Font Color=green>Files (" & Form.TotalBytes \1024 & "kB) was saved to " & DestinationPath & " folder.</Font>"
	else
		response.write "<br><Font Color=red>Bad destination path.</Font>"
	end if
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
 <TITLE>ASP huge file upload - upload to a specified destination.</TITLE>
 <STYLE TYPE="text/css"><!--TD	{font-family:Arial,Helvetica,sans-serif }TH	{font-family:Arial,Helvetica,sans-serif }TABLE	{font-size:10pt;font-family:Arial,Helvetica,sans-serif }--></STYLE>
 <meta name="robots" content="noindex,nofollow">
</HEAD>
<BODY BGColor=white>


<Div style=width:600>
<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
  
  <TR>
    <TH noWrap align=left width="20%" bgColor=khaki>&nbsp;<A 
      href="http://asp-upload.borec.net">Power ASP 
      file upload</A> - upload to a specified destination.&nbsp;</TH>
    <TD>&nbsp;</TD></TR></TABLE>
<TABLE cellSpacing=2 cellPadding=1 width="100%" bgColor=white border=0>
  
  <TR>
    <TD colSpan=2>
      <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;This sample demonstrates upload to a specified destination. Remember that ther is NO good idea to let clients store files in ANY server folder!
			

<br>Upload timeout is <%=Server.ScriptTimeout%>s
<br>Form size limit is <%=Form.SizeLimit \ 1024 %>kB


			</P>
  </TD></TR></TABLE>





<TABLE cellSpacing=1 cellPadding=3 bordercolor=silver bgcolor=GAINSBORO width="" border=1>
<form method="POST" ENCTYPE="multipart/form-data">

<tr><td ColSpan=2 Align=Right>
	<input Name=SubmitButton Value="Upload files &gt;&gt;" Type=submit><br>
</td></tr>

<tr><td>
	Destination
</td><td>
<Select Name=fDestination>
<%

Dim lDestinationsToChoose
For lDestinationsToChoose=0 to ubound(DestinationsToChoose)
	response.write "<OPTION VALUE=" & lDestinationsToChoose & ">" & DestinationsToChoose(lDestinationsToChoose)
next
%>
</Select>
</td></tr>

<tr><td ColSpan=2>
<Div ID=files>
   File 1 : <input type="file" name="File1"><br>
   File 2 : <input type="file" name="File2"><br>
   File 3 : <input type="file" name="File3"></Div>
<Input Type=Button Value="Add a file" OnClick=return(Expand()) 
 Style="border=0;background=yellow;cursor:hand"><br>

</td></tr>
</form></Table>



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
