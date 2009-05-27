<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>



<%


				  dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath



strNoname = Request.Form("name")

strTekst = Request.Form("comment")
strTekst = Replace(strTekst, "'", "''")
BadWordArr = Split(BadWords, ",")

BadWord = ""

For BadWordNo=0 To UBound(BadWordArr)
    If instr(strTekst, BadWordArr(BadWordNo)) > 0 Then
        BadWord = BadWordArr(BadWordNo)
    End If
Next

If BadWord <> "" Then
    Response.write ("<b>" & BadWord & "</b>"& noBadword &"")
Else


strSQL = "INSERT INTO comments (name, mail, url, comment, [date], ip, blogID) values ('" & strNoname & "', '" & Request.Form("mail") & "', '" & Request.Form("url") & "', '" & strTekst & "', '" & Request.Form("date") & "', '" & Request.Form("ip") & "', '" & Request.Form("blogID") & "')"

Conn.Execute(strSQL)

 Conn.close

Response.Redirect("p_suggestion.asp")
End If
%>
