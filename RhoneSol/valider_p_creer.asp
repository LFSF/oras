<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<%

Session.Timeout =30


espace="&#034;"
simplecot="&#039;"


   a=Request.Form("status") 



 b = replace(REPLACE( Request.Form("nom"),"""",espace),"'",simplecot)
       c = replace(REPLACE( Request.Form("prenom"),"""",espace),"'",simplecot)
       d = replace(REPLACE( Request.Form("adresse"),"""",espace),"'",simplecot)
       e = replace(REPLACE( Request.Form("cp"),"""",espace),"'",simplecot)
       f = replace(REPLACE( Request.Form("ville"),"""",espace),"'",simplecot)
       g = replace(REPLACE( Request.Form("email"),"""",espace),"'",simplecot)

       h = replace(REPLACE( Request.Form("telephone"),"""",espace),"'",simplecot)
       i = replace(REPLACE( Request.Form("portable"),"""",espace),"'",simplecot)
       
       j = replace(REPLACE( Request.Form("message"),"""",espace),"'",simplecot)
       
                
          
            
            '**********enregistrement dans la BD****************************
            
   	
dbPath = Server.MapPath("bd/bd_rs.mdb")

Set Conn = Server.CreateObject("ADODB.Connection")

Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
  & " DBQ=" & dbPath
 

SQL="SELECT * FROM [creation_site]"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3



RS.addnew
'***********
 RS("status")=replace(REPLACE(Request.form("status"),"""",espace),"'",simplecot)
 RS("nom")=replace(REPLACE(Request.form("nom"),"""",espace),"'",simplecot)

 RS("prenom")=replace(REPLACE(Request.form("prenom"),"""",espace),"'",simplecot) 

RS("fonction")=replace(REPLACE(Request.form("fonction"),"""",espace),"'",simplecot) 
RS("societe")=replace(REPLACE(Request.form("societe"),"""",espace),"'",simplecot) 





 RS("adresse")=replace(REPLACE(Request.form("adresse"),"""",espace),"'",simplecot)
RS("cp")=replace(REPLACE(Request.form("cp"),"""",espace),"'",simplecot)
RS("ville")=replace(REPLACE(Request.form("ville"),"""",espace),"'",simplecot)
 

 RS("email")=replace(REPLACE(Request.form("email"),"""",espace),"'",simplecot) 
 RS("telephone")=replace(REPLACE(Request.form("telephone"),"""",espace),"'",simplecot)
 RS("portable")=replace(REPLACE(Request.form("portable"),"""",espace),"'",simplecot) 
 
RS("projet")=replace(REPLACE(Request.form("projet"),"""",espace),"'",simplecot)

RS("precisions")=replace(REPLACE(Request.form("precisions"),"""",espace),"'",simplecot) 
 
 RS("budget")=replace(REPLACE(Request.form("budget"),"""",espace),"'",simplecot)

RS("delais")=replace(REPLACE(Request.form("delais"),"""",espace),"'",simplecot) 


RS("mess")=replace(REPLACE( Request.Form("message"),"""",espace),"'",simplecot)
RS("date_inscription")=Date
 RS("vu")="non" 
'***********
RS.update
rs.Close
set rs = Nothing
conn.Close
set conn= Nothing	
            
   
    
            
            Response.Write("<font size=4>" & "ERREUR DU SERVEUR !!" & chr(10)&  " VOTRE DEMANDE  A BIEN ETE PRISE EN COMPTE APPUYEZ SUR LA TOUCHE F5 OU PRECEDENTE." & "<br><br></font>")  
          
            
            '*********** fin de l'enregistrement dans la BD*****************
            
            
            
            
            
            session("mail")= g
            session("sonstatus")= a
            session("sonnom")=b
            session("sonprenom")=c
            
            
            
            
            Response.Redirect("valid_p_creer_debut.asp")
              
       
            %>
            				


<P>&nbsp;</P>

</BODY>
</HTML>
