<!-- #include file="connexion.asp"-->
<!-- #include file="admin_securite.asp"-->
<%
               
 espace="&#034;"
 simplecot="&#039;"
               
     
       
                                    
  for i=1 to session("lecompteur")
    
    j1= Request.Form("checkbox1" & i)
    j2= Request.Form("checkbox2" & i)   
    j3= Request.Form("checkbox3" & i)
    j4= Request.Form("checkbox4" & i)
    j5= Request.Form("checkbox5" & i)
    j6= Request.Form("checkbox6" & i)
    
    
'       if j1="on" then
'   jj1="oui"
'   else
'   jj1="non"
'   end if
    
'   if j2="on" then
'   jj2="oui"
'   else
'   jj2="non"
'   end if
    
    
'   if j3="on" then
'   jj3="oui"
'   else
'   jj3="non"
'   end if
    
'   if j4="on" then
'   jj4="oui"
'   else
'   jj4="non"
'   end if
    
    
'   if j5="on" then
'   jj5="oui"
'   else
'   jj5="non"
'   end if
    
    
'   if j6="on" then
'   jj6="oui"
'   else
'   jj6="non"
'   end if



    if j1="on" then
    jj1=1
    else
    jj1=0
    end if
    
    if j2="on" then
    jj2=1
    else
    jj2=0
    end if
    
    
    if j3="on" then
    jj3=1
    else
    jj3=0
    end if
    
    if j4="on" then
    jj4=1
    else
    jj4=0
    end if
    
    
    if j5="on" then
    jj5=1
    else
    jj5=0
    end if
    

    a=replace(REPLACE( Request.Form("nom" & i),"""",espace),"'",simplecot)
    
    
    b=replace(REPLACE( Request.Form("prenom" & i),"""",espace),"'",simplecot)
    c=replace(REPLACE( Request.Form("email" & i),"""",espace),"'",simplecot)
    'd=replace(REPLACE( Request.Form("fonction" & i),"""",espace),"'",simplecot)
    'e=replace(REPLACE( Request.Form("organisme" & i),"""",espace),"'",simplecot)
    f=replace(REPLACE( Request.Form("adresse" & i),"""",espace),"'",simplecot)
    g=replace(REPLACE( Request.Form("cp" & i),"""",espace),"'",simplecot)
    h=replace(REPLACE( Request.Form("ville" & i),"""",espace),"'",simplecot)
    'k=replace(REPLACE( Request.Form("civilite" & i),"""",espace),"'",simplecot)
    'l=replace(REPLACE( Request.Form("yourFieldNameHere2"),"""",espace),"'",simplecot)
    
    m=replace(REPLACE( Request.Form("lenum" & i),"""",espace),"'",simplecot)
    
    
    'Response.Write( Request.Form("compteur" & i)& " ")
    'Response.Write( Request.Form("civilite" & i)& " ")
    'Response.Write( Request.Form("nom" & i)& " ")
    'Response.Write( Request.Form("prenom" & i)& "<br>")
    'Response.Write( Request.Form("email" & i)& "  ")
    'Response.Write( Request.Form("fonction" & i)& "  ")
    'Response.Write( Request.Form("organisme" & i)& "<br>")
    'Response.Write( Request.Form("adresse" & i)& "<br>")
    'Response.Write( Request.Form("cp" & i)& "<br>")
    'Response.Write( Request.Form("ville" & i)& "<br>")
    'Response.Write( Request.Form("checkbox" & i)& "<br>")
    'Response.Write( Request.Form("lenum" & i)& "<br><br>")
    
     Set rs2 = Server.CreateObject("ADODB.RecordSet")

 
  SQL2 = "Select * from MEMBRE WHERE NomMembre ='" & a & "'"
 
 response.write(" req SQL2 : " & SQL2 & "</br>")
 

  rs2.open SQL2,conn,3,3 
        
    
    
SQL = "UPDATE ADMIN SET ActuVisu=" & jj1 & " , ItwVisu=" & jj2 & " , OffVisu=" & jj3 & " , CVVisu=" & jj4 & " , IdVisu=" & jj5 & " WHERE  NumMembre = " & rs2("NumMembre") & ""
                                   
        'Response.Write("<br><br> req SQL "  & sql)
        conn.Execute(SQL)
                
        '**** fin de la mise a jour*****************        

     
next
 
response.redirect "gesadmin.asp"
%>
<!-- #include file="deconnexion.asp"-->

