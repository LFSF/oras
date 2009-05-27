<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>

function Foot()
  DIM HTML
	HTML = "<hr><Table Border=0 Width=100%><TR><TD><font size=1> Sample upload/download via ASP from <a href=http://www.pstruh.cz>PSTRUH Software</a>.</font>"
	HTML = HTML & "</td><td Align=right><Font Size=1><A HRef=http://www.pstruh.cz/help/ScptUtl/upload.asp>Pure asp file upload</A> <A HRef=http://www.pstruh.cz/help/usrmgr/library.htm>ActiveX UserManager</A> <A HRef=http://www.pstruh.cz/help/RSConv/library.htm>DBF on-the-fly</A> <A HRef=http://www.pstruh.cz/help/tcpip/library.htm>ActiveX DNS+TraceRoute</A> <A HRef=http://www.pstruh.cz/help/urlrepl/library.htm>URL Replacer</A> </Font>"
	HTML = HTML & "</td></tr></table></Body></HTML>"
	Foot = HTML 
end function

function Head(Title, Description)
  DIM HTML
	HTML = "<HTML><Head>"
  HTML = HTML & "<Title>" & Title & "</Title>"
  HTML = HTML & "<Meta Content=""" & Description & """ Name=""Description"">"
	HTML = HTML & Style()
	HTML = HTML & "</Head>"
	HTML = HTML & Body()
	Head = HTML 
end function

function Body()
  DIM HTML
  HTML = "<body ALINK=YELLOW bgcolor=White LeftMargin=0 TopMargin=0>" &vbCrLf
	HTML = HTML & ClHead() & vbCrLf
'	HTML = HTML & hDescription() & vbCrLf

	HTML = HTML & Source()
	Body = HTML
  '<LeftMargin=0 TopMargin=0 Style="margin-right:0pt; margin-top:0pt; margin-left:0pt;">
end function

function Style()
  Style = "<STYLE TYPE=""text/css""><--BODY{font-size:10pt;font-family:Arial,Arial CE,Helvetica,sans-serif }--></STYLE>"
  '<LeftMargin=0 TopMargin=0 Style="margin-right:0pt; margin-top:0pt; margin-left:0pt;">
end function


function ClHead()
  DIM HTML
  HTML = HTML & "<TABLE width=100% border=1 cellpadding=1 cellspacing=0 BORDERCOLOR=WHITE><tr bgcolor=SILVER>"
  HTML = HTML & "<th><a href=upload.asp>Multiple files upload</a></th>"
  HTML = HTML & "<th><a href=download.asp>Multiple files download</a></th>"
  HTML = HTML & "<th><a href=dbupl.asp>Upload to database</a></th>"
  HTML = HTML & "<th><a href=dbdown.asp>Download from database</a></th>"
  HTML = HTML & "<th><a href=" & request.servervariables("script_name") & "?S=1>View source</a></th>"
  HTML = HTML & "</tr></table>"
  ClHead = HTML
end function

function Source()
  DIM HTML
  if request.querystring("S")<>"" then
    HTML = HTML & "<pre>" & server.htmlencode(CreateObject("Scripting.FileSystemObject").OpenTextFile _
    (server.mappath(request.servervariables("script_name")), 1, False, False).readall) & "</pre>"
  end if
	Source = BasicEncode(HTML)
end function


Function BasicEncode(ByVal VBCode)
'  Dim Pom, PosStart, PosEnd
'  PosStart = InStr(VBCode, "'")
'  Do While PosStart > 0
'    PosEnd = InStr(PosStart + 1, VBCode, vbCrLf)
'    If PosEnd = 0 Then PosEnd = Len(VBCode)
'    Pom = Left(VBCode, PosStart - 1) & "<font color=green>"
'    Pom = Pom & Mid(VBCode, PosStart, PosEnd - PosStart - 0) & "</font>"
'    Pom = Pom & Mid(VBCode, PosEnd)
'    VBCode = Pom
'    PosStart = InStr(PosEnd + 1, VBCode, "'")
'  Loop
  VBCode = FilterBeginEnd(VBCode, "'", vbCrLf, "green")
  VBCode = FilterBeginEnd(VBCode, "&quot;", "&quot;", "brown")
  VBCode = FilterWord(VBCode, "Set ", "blue")
  VBCode = FilterWord(VBCode, "If ", "blue")
  VBCode = FilterWord(VBCode, "For ", "blue")
  VBCode = FilterWord(VBCode, " Then", "blue")
  VBCode = FilterWord(VBCode, " In ", "blue")
  VBCode = FilterWord(VBCode, "Each ", "blue")
  VBCode = FilterWord(VBCode, "Function ", "blue")
  VBCode = FilterWord(VBCode, "End Function", "blue")
  VBCode = FilterWord(VBCode, "MsgBox ", "blue")
  VBCode = FilterWord(VBCode, "OutPut ", "blue")
  VBCode = FilterWord(VBCode, "Empty", "blue")
  VBCode = FilterWord(VBCode, "Debug.Print ", "darkblue")
  VBCode = FilterWord(VBCode, "Print ", "blue")
  VBCode = FilterWord(VBCode, " And ", "blue")
  VBCode = FilterWord(VBCode, " Or ", "blue")
  VBCode = FilterWord(VBCode, "Next" & vbcrlf, "blue")
  VBCode = FilterWord(VBCode, "Next " , "blue")

  VBCode = FilterWord(VBCode, "Response.Write", "darkblue")
  VBCode = FilterWord(VBCode, "Response.BinaryWrite" , "darkblue")
  VBCode = FilterWord(VBCode, "Response.ContentType" , "darkblue")
  VBCode = FilterWord(VBCode, "Response.AddHeader" , "darkblue")
    
  VBCode = FilterWord(VBCode, "Server.CreateObject" , "darkblue")
  VBCode = FilterWord(VBCode, "CreateObject" , "darkblue")
   
'  VBCode = FilterWord(VBCode," = ","red")
  BasicEncode = VBCode
End Function

Function FilterBeginEnd(ByVal VBCode, ByVal sBegin, ByVal sEnd, ByVal Color)
  Dim Pom, PosStart, PosEnd, FontColor
  FontColor = "<font color=" & Color & ">"
  PosStart = InStr(ucase(VBCode), ucase(sBegin))
  Do While PosStart > 0
    PosEnd = InStr(PosStart + Len(sBegin), ucase(VBCode), ucase(sEnd))
    If PosEnd = 0 Then PosEnd = Len(VBCode)
    Pom = Left(VBCode, PosStart - 1) & FontColor
    Pom = Pom & Mid(VBCode, PosStart, PosEnd - PosStart + Len(sEnd)) & "</font>"
    Pom = Pom & Mid(VBCode, PosEnd + Len(sEnd))
    VBCode = Pom
    PosStart = InStr(PosEnd + Len(FontColor) + Len("</font>") + Len(sEnd), ucase(VBCode), ucase(sBegin))
  Loop
  FilterBeginEnd = VBCode
End Function

Function FilterWord(ByVal VBCode, ByVal Word, ByVal Color)
  Dim Pom, PosStart, PosEnd, FontWord
  FontWord = "<font color=" & Color & ">" & Word & "</font>"
  PosStart = InStr(ucase(VBCode), ucase(Word))
  Do While PosStart > 0
    Pom = Left(VBCode, PosStart - 1) & FontWord
    Pom = Pom & Mid(VBCode, PosStart + Len(Word))
    VBCode = Pom
    PosStart = InStr(PosStart + Len(FontWord), ucase(VBCode), ucase(Word))
  Loop
  FilterWord = VBCode
End Function

Function dbDescription()
	Dim LibName, HTML
	Select case IncludeType
		case 1 : LibName = "The file is sample of using <b><A Href=http://www.pstruh.cz/help/ScptUtl/upload.asp>Pure asp file upload</A></b> to upload binary files to IIS server with ASP. <br>"
		case 2 : LibName = "The file is sample of using <b><A Href=http://www.pstruh.cz/help/ScptUtl/upload.asp>Pure asp file upload</a></b> to upload binary files to IIS server by ASP. No additional components required.<br>"
	End Select

	HTML = HTML & "<Table Width=600><tr><td>"
	HTML = HTML & "    " & LibName
	HTML = HTML & "    Upload size limit is <b>" & UploadSizeLimit & "B</b>.<br>"
	HTML = HTML & "    You can change the folder, limit and other script parameters, see source of this script."
	HTML = HTML & "</td></tr></Table>"
	dbDescription = HTML
End Function

Function upDescription()
	Dim LibName, HTML
	Select case IncludeType
		case 1 : LibName = "The file is sample of using <b><A Href=http://www.pstruh.cz/help/ScptUtl/upload.asp>Pure asp file upload</A></b> to upload binary files to IIS server with ASP. <br>"
		case 2 : LibName = "The file is sample of using <b><A Href=http://www.pstruh.cz/help/ScptUtl/upload.asp>Pure asp file upload</a></b> to upload binary files to IIS server by ASP. No additional components required.<br>"
	End Select

	HTML = HTML & "<Table Width=600><tr><td>"
	HTML = HTML & "    " & LibName
	HTML = HTML & "    Destination folder for upload is <b>'" & DestinationPath & "'</b>, upload size limit is <b>" & UploadSizeLimit & "B</b>.<br>"
	HTML = HTML & "    You can change the folder, limit and other script parameters, see source of this script."
	HTML = HTML & "</td></tr></Table>"
	upDescription = HTML
End Function

</SCRIPT>

