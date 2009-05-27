<%@EnableSessionState=False%>
<%
'Session must be off to work correctly.

	Const RefreshTime = 1'Seconds

  'Upload ID must be defined.
  'Redirect to base script without the parameter.
  if Request.QueryString("UploadID") = "" then 
    response.redirect "Upload.ASP"
  end if

  Server.ScriptTimeout = 10
'Using Huge-ASP file upload
'Dim Form: Set Form = Server.CreateObject("ScriptUtils.ASPForm")
'Using Pure-ASP file upload
Dim Form: Set Form = New ASPForm %><!--#INCLUDE FILE="_upload.asp"--><% 
  
  '{b}Get current uploading form with UploadID.
  on error resume next
  Set Form = Form.getForm(Request.QueryString("UploadID"))'{/b}
  
  if Err = 0 then '?Completted 0 = in progress
    on error goto 0
    if Form.BytesRead>0 then'Upload was started.
      Dim UpStateHTML
			'Get currently uploadded filenames and sizes
			UpStateHTML = FileStateInfo(Form)
    end if

  'Do not cache output data of this script.
  response.cachecontrol = "no-cache"
  response.AddHeader "Pragma","no-cache"
  
  'This script is progress bar.
  'There is a good idea to refresh it to show progress more than once :-).
  'Refresh time is in second
  response.addheader "Refresh", RefreshTime

  'Count progress indicators
  ' - percent and total read, total bytes, etc.
  Dim PercBytesRead, PercentRest, BytesRead, TotalBytes
  Dim UploadTime, RestTime, TransferRate
  BytesRead = Form.BytesRead
  TotalBytes = Form.TotalBytes

  if TotalBytes>0 then 
    'upload started.
    PercBytesRead = int(100*BytesRead/TotalBytes)
    PercentRest = 100-PercBytesRead
    
    if Form.ReadTime>0 then TransferRate = BytesRead / Form.ReadTime
    if TransferRate>0 then RestTime = FormatTime((TotalBytes-BytesRead) / TransferRate) 
    TransferRate = FormatSize(1000 * TransferRate)
  else
    'upload not started.
    RestTime = "?"
    PercBytesRead = 0
    PercentRest = 100
    TransferRate = "?"
  end if

  'Create graphics progress bar.
  'The bar is created with blue (TDsread, completted) / blank (TDsRemain, remaining) TD cells.
  Dim TDsread, TDsRemain
  if PercentRest>0 then TDsread = "<Tr><TD Width=100% height=""" & PercentRest & "%"" style=font-size:0px></TD></Tr>"
  TDsRemain = "<Tr><TH Width=100% BGColor=yellow height=""" & PercBytesRead & "%"" style=color:white;font-size:" & cint(PercBytesRead * 1.8) & "px"+">" & PercBytesRead & "%</TH></Tr>"

  'Format output values.
  UploadTime = FormatTime(Form.ReadTime)
  TotalBytes = FormatSize(TotalBytes)
  BytesRead = FormatSize(BytesRead)

'Simple utilities.
'Formats milisedond to m:ss format.
Function FormatTime(byval ms)
  ms = 0.001 * ms 'get second
  FormatTime = (ms \ 60) & ":" & right("0" & (ms mod 60),2) & "s"
End Function 

'Format bytes to a string
Function FormatSize(byval Number)
  if isnumeric(Number) then
    if Number > &H100000 then'1M
      Number = FormatNumber (Number/&H100000,1) & "MB"
    elseif Number > 1024 then'1k
      Number = FormatNumber (Number/1024,1) & "kB"
    else
      Number = FormatNumber (Number,0) & "B"
    end if
  end if
  FormatSize = Number
End Function

Function FileStateInfo(Form)
  'enumerate uploaded fields.
  'and build report about its current state.
	On Error Resume Next
  Dim UpStateHTML, Field
  for each Field in Form.Files
    'Get field name
    UpStateHTML = UpStateHTML & "FieldName:" & Field.Name
    
    if Field.InProgress then
      'this field is in progress now.
      UpStateHTML = UpStateHTML & ", uploading: " & Field.FileName
    elseif Field.Length>0 then
      'This field was succefully uploaded.
      UpStateHTML = UpStateHTML & ", received: " & Field.FileName & ", " & FormatSize(Field.Length)
    end if
    
    UpStateHTML = UpStateHTML & "<br>"
  Next
	FileStateInfo = UpStateHTML
End Function


'Some comments for HTML
'Page-Enter and revealTrans is for Flicker-Free progress.

%>
<HTML>
<Head>
 <style type='text/css'>
  BODY{font-size:10pt}
  TD{font-size:9pt;font-family:arial} 
  TH{font-size:9pt;font-family:arial} 
 </style>
 <meta http-equiv="Page-Enter" content="revealTrans(Duration=0,Transition=6)"> 
 <META HTTP-EQUIV="Refresh" CONTENT="<%=RefreshTime%>">
 <Title><%=PercBytesRead%>% completted - upload to <%=Request.ServerVariables("HTTP_HOST")%> in progress </Title>
</Head>

<Body BGcolor=Silver LeftMargin=1 TopMargin=1 RIGHTMARGIN=1 BOTTOMMARGIN=1>

<Table cellpadding=0 cellspacing=0 border=0 width=100% Height=100% style="border:1px inset white;z-index: -1;position:absolute;left:1;top:1">
 <%=TDsread%><%=TDsRemain%>
</table>


<Table cellpadding=0 cellspacing=3 border=0  width=100% >
<tr>
 <Td><Table cellpadding=0 cellspacing=0 border=0 width=100% >
<tr>
<td>Uploading:<br> <%=TotalBytes%> to <%=Request.ServerVariables("HTTP_HOST")%> ...<br></td>
<td Align=Right VAlign=Top><A Target=_blank Href=http://www.motobit.com>Huge ASP file upload progress bar</A></td>
</tr>
</Table></Td>
</tr>

<tr><td><Table cellpadding=0 cellspacing=0 border=0  width=100% >
<tr>
 <Td>Progress</td>
 <Td>: <%=BytesRead%> of <%=TotalBytes%> (<%=PercBytesRead%>%) </Td>
</tr>
<tr>
 <Td>Time </td>
 <Td>: <%=UploadTime%> (<%=TransferRate%>/s) </Td>
</tr>
<tr>
 <Td>Time left</td>
 <Td>: <%=RestTime%> </Td>
</tr>
</table></Td></tr>

<tr>
 <Th><Input Type=Button Value="Cancel upload" OnClick="Cancel()" 
 Style="background-color:red;color:white;cursor:hand;font-weight:bold"></Th>
</tr>
<tr>
 <Td><%=UpStateHTML%></Td>
</tr>
</table>

<Script>
//I'm sorry. IE enables switch-off refresh header. You can use script to do the same action
//to be sure that progress window will refresh.
window.setTimeout('refresh()', <%=RefreshTime%>*2000);

function refresh(){
	window.location.href = window.location.href;
	window.setTimeout('refresh()', <%=RefreshTime%>*2000);
}
function Cancel(){
	//get opener location - this is URL of the main upload script.
	var l = ''+opener.document.location;
	
	//Add Action=Cancel querystring parameter
	if (l.indexOf('Action=Cancel')<0) {
		l += (l.indexOf('?')<0 ? '?' : '&') + 'Action=Cancel'
	};

	//Set the new URL to opener (upload is cancelled)	
	opener.document.location = l;

	//Close this window.
	window.close();
}
</Script>

</Body>
</HTML>

<%
else 'if Err = 0 then upload finished
%>
<HTML>
 <HEAD>
 <TITLE>Upload Finished</TITLE>
 <Script>window.close();</Script>
 </HEAD>
</HTML>
<%
End If'if Err = 0 then 
%>