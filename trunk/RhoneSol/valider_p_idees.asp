<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<!-- #include file="grand_meta.txt"-->
	<!-- #include file="connexion.asp"-->
	<title>Rhône-solidarité</title>




	<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">Vérification Idées Suggestions avant enregistrement</div>


<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation idées suggestions__________________________________________________</font></td>
    </tr>
   


</table>






 <table background="img/haut_epingle.gif" style="background-repeat:no-repeat;" 
width="650" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">

<tr>

<td>


				  
				  <%
  	espace="&#034;"
	simplecot="&#039;"


SQL="SELECT * FROM IDEES"
Set RS = server.createobject("ADODB.Recordset")
RS.Open SQL,Conn , 3, 3

RS.addnew
'***********

 
 '--code de la structure----------------------
 'RS("numCV")=replace(REPLACE(num,"""",espace),"'",simplecot) 
 RS("DateIdee")=replace(REPLACE(date,"""",espace),"'",simplecot) 
 'RS("civilite")=replace(REPLACE(session("a_civilite"),"""",espace),"'",simplecot) 
 'RS("age")=replace(REPLACE(session("age"),"""",espace),"'",simplecot) 
 'RS("nom")=replace(REPLACE(session("a_nom"),"""",espace),"'",simplecot)
 'RS("prenom")=replace(REPLACE(session("a_prenom"),"""",espace),"'",simplecot)
 'RS("adresse")=replace(REPLACE(session("a_adresse"),"""",espace),"'",simplecot)
 'RS("cp")=replace(REPLACE(session("a_cp"),"""",espace),"'",simplecot)
 'RS("ville")=replace(REPLACE(session("a_ville"),"""",espace),"'",simplecot)
 'RS("email")=replace(REPLACE(session("a_email"),"""",espace),"'",simplecot)
 'RS("telephone")=replace(REPLACE(session("a_telephone"),"""",espace),"'",simplecot)
 'RS("fonction")=replace(REPLACE(session("a_fonction"),"""",espace),"'",simplecot)
 'RS("organisme")=replace(REPLACE(session("a_organisme"),"""",espace),"'",simplecot)
RS("MessageIdee")=replace(REPLACE(session("a_message"),"""",espace),"'",simplecot)
RS("Civilite")=replace(REPLACE(session("a_civilite"),"""",espace),"'",simplecot)
RS("Nom")=replace(REPLACE(session("a_nom"),"""",espace),"'",simplecot)
RS("Prenom")=replace(REPLACE(session("a_prenom"),"""",espace),"'",simplecot)
RS("Fonction")=replace(REPLACE(session("a_fonction"),"""",espace),"'",simplecot)
RS("Association")=replace(REPLACE(session("a_organisme"),"""",espace),"'",simplecot)
RS("MailReponse")=replace(REPLACE(session("a_email"),"""",espace),"'",simplecot)
RS("Telephone")=replace(REPLACE(session("a_telephone"),"""",espace),"'",simplecot)
RS("Visible")=0
 'RS("pays")=replace(REPLACE(session("a_pays"),"""",espace),"'",simplecot)
'RS("NumMembre")=session("numMembre")
 
  
  'RS("confirmation_par_mail")="non"
  
 RS.update

response.redirect("valid_p_idees.asp")
%>


				  </td>
				  </tr>

</table>
	



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>
<!-- #include file="deconnexion.asp"-->
</body>
</html>