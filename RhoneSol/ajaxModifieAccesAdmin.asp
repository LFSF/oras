<!-- #include file="connexion.asp"-->

<%

if Request.Form("idMembre")<>"" then
    Dim sql

    sql = "UPDATE MEMBRE SET AdminMembre= 1 WHERE  NumMembre = "&Request.Form("idMembre")
    Conn.execute(sql)

    'sql="INSERT INTO `ADMIN` (`NumMembre` , `CvVisu`, `CvValid`, `ActuAdd`, `ActuVisu`, `ActuValid`, `ActuModif`" & _
    '    " ,`ItwAdd`,`ItwVisu`,`ItwValid`,`ItwModif`,`IdVisu`,`SuperAdmin`,`OffVisu`,`OffValid` )" & _
    '    "VALUES ("&Request.Form("idMembre")&" ,1,0,0,1,0,0,0,1,0,0,0,0,1,0);"

    'Conn.execute(sql)

end if


%>

<!-- #include file="deconnexion.asp"-->