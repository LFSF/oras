<%Option Explicit%>
<%'format.inc, contains head and Foot function, optional.%>
<!--#INCLUDE FILE="format.inc"-->
<%
  dim Conn, RS, ID
  Set Conn = GetConnection 
  Response.Buffer=True
  if "" & Request.QueryString("ID") <> "" and isnumeric(Request.QueryString("ID")) then
    'If there is an ID in QUERY_STRING
    'Write file from db to the client
    ID = Clng(Request.QueryString("ID"))

    if ucase(Request.QueryString("A"))="D" then'Delete
      Conn.execute("delete from Upload where UploadID=" & ID)
    Else'Download
      'file record
      Set RS = Conn.execute("select * from Upload where UploadID=" & ID)
      if ucase(Request.QueryString("A"))<>"P" then
        response.contenttype = RS("ContentType")'set Content-Type
        Response.AddHeader "Content-Disposition", "attachment;filename=""" & RS("SouceFileName") & """"
      End If
    
'      Response.BinaryWrite RS("Data").Value 'Write the file from db field to the client
      Response.BinaryWrite RS("Data").GetChunk(RS("DataSize")) 'Write the file from db field to the client
    
      RS.Close
      Conn.Close
      Response.End
    End If'Download
  End If

  response.write Head("Sample download from database via ASP", "Demonstrates using of the MDB database to store binary and large text data uploaded from clients.")
  response.write DBList(Conn)
  response.write Foot
  Conn.Close

function DBList(Conn)
  dim HTML, RS, ContentType
    'Open recordset with the files
    Set RS = Conn.execute("select UploadID, UploadDT, SouceFileName, Description, ContentType from Upload order by UploadDT desc")
    HTML = HTML & "<Table><tr><th ColSpan=3>Files stored in database : </th></tr>" & vbcrlf 
    HTML = HTML & "<tr><th>Date/Time</th><th>File</th><th>Description</th></tr>" & vbcrlf 
    do while not RS.Eof
      ContentType = lcase("" & RS("ContentType"))
      HTML = HTML & "<tr><td>" & RS("UploadDT") & "</td><td> <A HREF=" & Request.ServerVariables("SCRIPT_NAME") & "?ID=" & RS("UploadID") 
      if left(ContentType,6)="image/" or left(ContentType,5)="text/"  then
        HTML = HTML & " onmouseover=""ShowFile('" & RS("UploadID") & "')"" onmouseout=""HideFile()"""
      end if
      HTML = HTML & ">" & RS("SouceFileName") & "</A>"
      HTML = HTML & " <Font Size=1><A Style=Cursor:hand OnClick=""DoDel(" & RS("UploadID") & ",'" & replace("" & RS("SouceFileName"),"'","\'") & "')"">Delete</A></Font>"
      HTML = HTML & " </td><td>" & RS("Description") & "</td></tr>" & vbcrlf 
      RS.MoveNext
    loop
    HTML = HTML & "</Table>" & vbcrlf 
    DBList = HTML
  RS.Close
end function

function GetConnection()
  dim Conn, AuthConnectionString 
'  AuthConnectionString = "DBQ=" & Server.MapPath("upload.mdb") & ";DefaultDir=" & Server.MapPath("/") & ";" & _
'      "Driver={Microsoft Access Driver (*.mdb)}; DriverId=25;FIL=MS Access;MaxBufferSize=512;PageTimeout=5;UID=;"
  AuthConnectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("upload.mdb") 
  Set Conn = Server.CreateObject("ADODB.Connection")
  Conn.open AuthConnectionString
	set GetConnection = Conn
end function

%>
<Table id=ishow style=visibility:hidden;position:absolute BGColor=silver><tr><th>Preview</th></tr>
<tr><td>
<IFrame Width=600 Height=300 SCROLLING=no FRAMEBORDER=0 Id=ifrshow>
</IFrame>
</td></tr></table>
<Script>
function HideFile(){
  if (document.all.ishow) {
    document.all.ishow.style.visibility='hidden';
  }
};

function ShowFile(id){
  if (document.all.ishow) {
    document.all.ishow.style.visibility=''
    document.all.ishow.style.left=event.clientX;
    document.all.ishow.style.top=event.clientY;
  //alert('<%=Request.ServerVariables("SCRIPT_NAME")%>?'+id)
    document.all.ifrshow.src = '<%=Request.ServerVariables("SCRIPT_NAME")%>?ID='+id+'&A=p'
  }
};
function DoDel(id, name){

  if (confirm('Delete the file "'+name+'" from database ?')) document.location.href='<%=Request.ServerVariables("SCRIPT_NAME")%>?ID='+id+'&A=d';
}
</Script>
