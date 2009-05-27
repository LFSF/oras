<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<!-- #include file="connexion.asp"-->
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">CONSULTATION CV</div>

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><a class=lien href="p_annonces.asp">
                           <font size=1><b><< Retour </b></font>
                        </a>
        </td>
    </tr>
    <tr>
        <td colspan="2"><font color="#6faa06">CV Emplois____________________________________________________________________</font></td>
    </tr>
    </table>

    <!--       INSERTION -->

<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
                    <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                    <tr>
                        <th>N°</th>
                        <th>Date</th>
                        <th>Intitulé</th>
                        <th>Lieu du poste</th>
                        <th>Durée espérée</th>
                        <th>Disponible à partir du</th>
                    </tr>
<%
Dim Place
Place = 0

' Set rsEDcv1 = Conn.Execute("SELECT * FROM CV where Visible=1")
' Set rsED1= Conn.Execute("SELECT * FROM ANNONCES where ProfilAnn=3 ORDER BY DateAnn DESC")
Set rsED1 = Conn.Execute("SELECT * FROM ANNONCES A, CV C where A.NumCV=C.NumCV and A.ProfilAnn=1 and C.Visible=1 ORDER BY DateAnn DESC")

While Not rsED1.EOF
  where=""
  if rsED1("NumMembre")<>"" then
        where="WHERE NumMembre=" & rsED1("NumMembre")
  end if

  Set rsED0 = Conn.Execute("SELECT * FROM MEMBRE "&where&" ;")

  sDate = date
  sDiffDate = DateDiff("d", sDate, rsED1("FinCV"))
  if sDiffDate > 0 Then

    If strBgcolor = "#F1F1F1" Then
        strBgcolor = "#FFFFFF"
    Else
        strBgcolor = "#F1F1F1"
    End If
%>
              <tr bgcolor="<%=strBgcolor%>">
                <td width="15"> 
                  <% Place = Place+1 %>
                  <b><%=Place%></b>
                  </td>
                <td width="110"><%=mid(rsED1("DateAnn"),1,10)%>
                </td>
                <td><%=rsED1("IntituleAnn")%>
                </td>
                 <td><%=rsED1("LieuAnn")%>  <%session("recup_pieces_jointes")= rsED1("LieuAnn")%>
                 </td>
              <td>
<%
if rsED1("DureeEspereeAnn")="1000" then
   Response.Write("C.D.I")
end if

if rsED1("DureeEspereeAnn")="15" then
   Response.Write("15 jours")
end if

if rsED1("DureeEspereeAnn")="30" then
   Response.Write("1 mois")
end if

if rsED1("DureeEspereeAnn")="60" then
   Response.Write("2 mois")
end if

if rsED1("DureeEspereeAnn")="90" then
   Response.Write("3 mois")
end if

if rsED1("DureeEspereeAnn")="120" then
   Response.Write("4 mois")
end if

if rsED1("DureeEspereeAnn")="150" then
   Response.Write("5 mois")
end if

if rsED1("DureeEspereeAnn")="180" then
   Response.Write("6 mois")
end if

if rsED1("DureeEspereeAnn")="270" then
   Response.Write("9 mois")
end if

if rsED1("DureeEspereeAnn")="360" then
   Response.Write("1 an minimum")
end if
%>
                </td>
                <td><%=rsED1("DispoJourAnn")%>&nbsp;<%=rsED1("DispoMoisAnn")%>&nbsp;<%=rsED1("DispoAnneeAnn")%>
                </td>
              <td width="20"></td>
               <td width="20"><a href="pa_consulter_cvbis.asp?num=<%=rsED1("NumCV")%>">
               <img src="img racine/picto_cv.gif" border="0"></a></td>
              </tr>
<%
End if
' rsEDcv1.MoveNext 
rsED1.MoveNext
Wend
rsED1.Close
%>
            </table>
            <tr>
        <td colspan="2"><font color="#6faa06">CV Stage____________________________________________________________________</font></td>
    </tr>
    
    </table>

    <!--       INSERTION -->

<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
                    <td>
          
    
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                  
                  <tr>
        <th>N°</th>
   
        <th>Date</th>
   
        <th>Intitulé</th>
  
        <th>Lieu du poste</th>
   
        <th>Durée espérée</th>
    
        <th>Disponible à partir du</th>
    </tr>
<%
Dim Place1
Place1 = 0

' Set rsEDcv2 = Conn.Execute("SELECT * FROM CV where Visible=1")
' Set rsED2 = Conn.Execute("SELECT * FROM ANNONCES where ProfilAnn=2 ORDER BY DateAnn DESC")
Set rsED2 = Conn.Execute("SELECT * FROM ANNONCES A, CV C where A.NumCV=C.NumCV and A.ProfilAnn=2 and C.Visible=1 ORDER BY DateAnn DESC")

While Not rsED2.EOF
where=""
  if rsED2("NumMembre")<>"" then
        where="WHERE NumMembre=" & rsED2("NumMembre")
  end if
Set rsED5 = Conn.Execute("SELECT * FROM MEMBRE "&where&" ;")

sDate = date
sDiffDate = DateDiff("d", sDate, rsED2("FinCV"))
    if sDiffDate > 0 Then

If strBgcolor = "#F1F1F1" Then
    strBgcolor = "#FFFFFF"
Else
    strBgcolor = "#F1F1F1"
End If
%>
              <tr bgcolor="<%=strBgcolor%>"> 
                <td width="15"> 
                  <% Place1 = Place1+1 %>
                  <b><%=Place1%></b> 
                  </td>
<%
Session.LCID = 1036
%>
                <td width="110"><%=mid(rsED2("DateAnn"),1,10)%>
                </td>
                <td><%=rsED2("IntituleAnn")%>
                </td>
                 <td><%=rsED2("LieuAnn")%>  <%session("recup_pieces_jointes")= rsED2("LieuAnn")%>
                 </td>
              <td>
<%
if rsED2("DureeEspereeAnn")="1000" then
   Response.Write("C.D.I")
end if

if rsED2("DureeEspereeAnn")="15" then
   Response.Write("15 jours")
end if

if rsED2("DureeEspereeAnn")="30" then
   Response.Write("1 mois")
end if

if rsED2("DureeEspereeAnn")="60" then
   Response.Write("2 mois")
end if

if rsED2("DureeEspereeAnn")="90" then
   Response.Write("3 mois")
end if

if rsED2("DureeEspereeAnn")="120" then
   Response.Write("4 mois")
end if

if rsED2("DureeEspereeAnn")="150" then
   Response.Write("5 mois")
end if

if rsED2("DureeEspereeAnn")="180" then
   Response.Write("6 mois")
end if

if rsED2("DureeEspereeAnn")="270" then
   Response.Write("9 mois")
end if

if rsED2("DureeEspereeAnn")="360" then
   Response.Write("1 an minimum")
end if
%>
                </td>
                <td><%=rsED2("DispoJourAnn")%>&nbsp;<%=rsED2("DispoMoisAnn")%>&nbsp;<%=rsED2("DispoAnneeAnn")%>
                </td>
              <td width="20"></td>
               
               <td width="20"><a href="pa_consulter_cvbis.asp?num=<%=rsED2("NumCV")%>">
               <img src="img racine/picto_cv.gif" border="0"></a></td>
              </tr>
<%
End if
rsED2.MoveNext
Wend
rsED2.Close
%>
            </table>
            <tr>
        <td colspan="2"><font color="#6faa06">CV Autre____________________________________________________________________</font></td>
    </tr>
    
    </table>
    
  
    
    <!--       INSERTION -->
    
                              
<table width="100%" height="100%" border="0" cellpadding="12" cellspacing="0">
        <tr valign="top"> 
         
                    <td>
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                  
                  <tr>
        <th>N°</th>
        <th>Date</th>
        <th>Intitulé</th>
        <th>Lieu du poste</th>
        <th>Durée espérée</th>
        <th>Disponible à partir du</th>
    </tr>
<%
Dim Place2
Place2 = 0

' Set rsEDcv3 = Conn.Execute("SELECT * FROM CV where Visible=1")
' Set rsED3 = Conn.Execute("SELECT * FROM ANNONCES where ProfilAnn=1 ORDER BY DateAnn DESC")
Set rsED3 = Conn.Execute("SELECT * FROM ANNONCES A, CV C where A.NumCV=C.NumCV and A.ProfilAnn=3 and C.Visible=1 ORDER BY DateAnn DESC")

While Not rsED3.EOF
where=""
  if rsED3("NumMembre")<>"" then
        where="WHERE NumMembre=" & rsED3("NumMembre")
  end if
Set rsED4 = Conn.Execute("SELECT * FROM MEMBRE "& where & " ;")

sDate = date
sDiffDate = DateDiff("d", sDate, rsED3("FinCV"))
    if sDiffDate > 0 Then

If strBgcolor = "#F1F1F1" Then
strBgcolor = "#FFFFFF"
Else
strBgcolor = "#F1F1F1"
End If
%>
              <tr bgcolor="<%=strBgcolor%>"> 
                <td width="15"> 
                  <% Place2 = Place2+1 %>
                  <b><%=Place2%></b>
  
                  </td>
                <td width="110"><%=mid(rsED3("DateAnn"),1,10)%>
                </td>
                <td><%=rsED3("IntituleAnn")%>
                </td>
                 <td><%=rsED3("LieuAnn")%>  <%session("recup_pieces_jointes")= rsED3("LieuAnn")%>
                 </td>
                 <td>
<%
if rsED3("DureeEspereeAnn")="1000" then
   Response.Write("C.D.I")
end if

if rsED3("DureeEspereeAnn")="15" then
   Response.Write("15 jours")
end if

if rsED3("DureeEspereeAnn")="30" then
   Response.Write("1 mois")
end if

if rsED3("DureeEspereeAnn")="60" then
   Response.Write("2 mois")
end if

if rsED3("DureeEspereeAnn")="90" then
   Response.Write("3 mois")
end if

if rsED3("DureeEspereeAnn")="120" then
   Response.Write("4 mois")
end if

if rsED3("DureeEspereeAnn")="150" then
   Response.Write("5 mois")
end if

if rsED3("DureeEspereeAnn")="180" then
   Response.Write("6 mois")
end if

if rsED3("DureeEspereeAnn")="270" then
   Response.Write("9 mois")
end if

if rsED3("DureeEspereeAnn")="360" then
   Response.Write("1 an minimum")
end if
%>
                </td>
                <td><%=rsED3("DispoJourAnn")%>&nbsp;<%=rsED3("DispoMoisAnn")%>&nbsp;<%=rsED3("DispoAnneeAnn")%>
                </td>
                
              
              <td width="20"></td>
               
               <td width="20"><a href="pa_consulter_cvbis.asp?num=<%=rsED3("NumCV")%>">
               <img src="img racine/picto_cv.gif" border="0"></a></td>
              </tr>
<%
End if
rsED3.MoveNext
Wend
rsED3.Close
%>
        </table>
                    </td>
            </tr>
    </table>
        
        
        
        <!--           fin insertion  -->
        


 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>