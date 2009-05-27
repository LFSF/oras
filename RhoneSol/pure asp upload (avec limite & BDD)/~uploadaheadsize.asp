<%
  Dim WebServer, UploadReadAheadSize, INSTANCE_ID
'  Set WebServer = GetObject("IIS://localhost/W3SVC[/sitenum[/folder[/uploadscript.asp]]]")
	INSTANCE_ID = request.ServerVariables("INSTANCE_ID")
	on error resume next
  Set WebServer = GetObject("IIS://localhost/W3SVC/" & INSTANCE_ID)

	if err <> 0 then
	  response.status = "401 access denied"
		response.write "Please log on as an IIS administrator to manage IIS properties"
		response.write replace(space(1000), " ", "&nbsp;") ' why MS means friendly error messages are friendly??!!
		response.end
	end if
  on error goto 0
  
	if request("iUploadReadAheadSize")<>"" and isnumeric(request("iUploadReadAheadSize")) then
		WebServer.UploadReadAheadSize = request("iUploadReadAheadSize")
		WebServer.SetInfo 
	end if
  'Set another size
  '
  'wscript.echo WebServer.UploadReadAheadSize

  '

  'Get UploadReadAheadSize property
  UploadReadAheadSize = WebServer.UploadReadAheadSize
  
%>
Please see notes at <A Href=http://www.motobit.com/help/scptutl/pa35.htm>Upload - Monitor and handle upload state/result</A> page.
<br>UploadReadAheadSize for this instance (no. <%=INSTANCE_ID%>  & ") is <%=UploadReadAheadSize%>B.
<form>
<Input Name=iUploadReadAheadSize value=<%=UploadReadAheadSize%>><Input type=submit Value="Set UploadReadAheadSize for Instance <%=INSTANCE_ID%> &gt;&gt;">
</form>

<%
response.end
  Dim ScriptName, ScriptPath, Pos
	ScriptName = request.ServerVariables("SCRIPT_NAME")
	Pos = instr(1,ScriptName , "/")
	Do while Pos>0 
	  ScriptPath = left(ScriptName , Pos-1)
		response.write "<br>" & "IIS://localhost/W3SVC/" & INSTANCE_ID & "/Root" & ScriptPath
    Set WebServer = GetObject("IIS://localhost/W3SVC/" & INSTANCE_ID & "/Root" & ScriptPath  )

%>
<br>UploadReadAheadSize for this instance (no. <%=INSTANCE_ID%>  & "), folder <%=ScriptPath%> is <%=UploadReadAheadSize%>B.
<form>
<Input Name=iUploadReadAheadSize value=<%=UploadReadAheadSize%>><Input type=submit Value="Set UploadReadAheadSize for Instance <%=INSTANCE_ID%> &gt;&gt;">
</form>

<%

	Pos = instr(Pos+1,ScriptName , "/")
	Loop

%>