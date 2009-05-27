<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.rg/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	<div id="bandeau_orange">Vérification Adhesion avant enregistrement</div>

<table border="0px" width="100%" cellpadding="10px">
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation adhesion _____________________________________________________</font> 
		</td>
    </tr>
</table>

<table background="img/haut_epingle.gif" style="background-repeat:no-repeat;" width="650" border="0" cellspacing="0" cellpadding="0" align="center" valign="center" class="txt2">

<tr>
	<td>



<%
	espace="&#034;"
	simplecot="&#039;"

	Set RS = server.createobject("ADODB.Recordset")
SQL= "SELECT * FROM MEMBRE"

	RS.Open SQL,Conn , 3, 3

RS.addnew

 RS("NomMembre")=replace(REPLACE(session("NomMembre"),"""",espace),"'",simplecot)
 RS("TelMembre")=replace(REPLACE(session("TelMembre"),"""",espace),"'",simplecot)
 RS("MailMembre")=replace(REPLACE(session("MailMembre"),"""",espace),"'",simplecot)
 RS("AdrMembre")=replace(REPLACE(session("AdrMembre"),"""",espace),"'",simplecot)
 RS("MdpMembre")=replace(REPLACE(session("MdpMembre"),"""",espace),"'",simplecot)
 RS("News")=replace(REPLACE(session("News"),"""",espace),"'",simplecot)
 RS("VilleMembre")=replace(REPLACE(session("VilleMembre"),"""",espace),"'",simplecot)
 RS("CPMembre")=replace(REPLACE(session("CPMembre"),"""",espace),"'",simplecot)
 RS("OrganismeMembre")=replace(REPLACE(session("OrganismeMembre"),"""",espace),"'",simplecot)
 RS("PaysMembre")=replace(REPLACE(session("PaysMembre"),"""",espace),"'",simplecot)
 RS("PartenaireMembre")=replace(REPLACE(session("PartenaireMembre"),"""",espace),"'",simplecot)
 RS("CooperationMembre")=replace(REPLACE(session("CooperationMembre"),"""",espace),"'",simplecot)
 RS("SolidaireMembre")=replace(REPLACE(session("SolidaireMembre"),"""",espace),"'",simplecot)
 RS("FormationMembre")=replace(REPLACE(session("FormationMembre"),"""",espace),"'",simplecot)
 RS("AutreMembre")=replace(REPLACE(session("AutreMembre"),"""",espace),"'",simplecot)
 RS("RedacteurMembre")=replace(REPLACE(session("RedacteurMembre"),"""",espace),"'",simplecot)
 RS("InterviewMembre")=replace(REPLACE(session("InterviewMembre"),"""",espace),"'",simplecot)
 RS("EcrireItwMembre")=replace(REPLACE(session("EcrireItwMembre"),"""",espace),"'",simplecot)
 RS("CreationsiteMembre")=replace(REPLACE(session("CreationsiteMembre"),"""",espace),"'",simplecot)
 RS("AutresMembre")=replace(REPLACE(session("AutresMembre"),"""",espace),"'",simplecot)
 RS("MessageMembre")=replace(REPLACE(session("MessageMembre"),"""",espace),"'",simplecot)
 RS("DateMembre")=replace(REPLACE(date,"""",espace),"'",simplecot) 
 RS("AdhesionMembre")="non"
 RS("Entreprise")=1
 RS("AdminMembre")=0
 
 
 RS.update
 RS.Close
set rs = Nothing

%>

<%
	espace="&#034;"
	simplecot="&#039;"

	Set RS2 = server.createobject("ADODB.Recordset")
	SQL2= "SELECT * From Membre Where NomMembre = '" & session("NomMembre") & "' AND MailMembre = '" & session("MailMembre") & "'"
	
	
	RS2.Open SQL2,Conn , 3, 3

%>

<%
	espace="&#034;"
	simplecot="&#039;"

	Set RS1 = server.createobject("ADODB.Recordset")
SQL1= "SELECT * FROM ADMIN"

	RS1.Open SQL1,Conn , 3, 3

RS1.addnew

 RS1("CvVisu")=0
 RS1("CvValid")=0
 RS1("ActuAdd")=0
 RS1("ActuVisu")=0
 RS1("ActuValid")=0
 RS1("ActuModif")=0
 RS1("ItwAdd")=0
 RS1("ItwVisu")=0
 RS1("ItwValid")=0
 RS1("ItwModif")=0
 RS1("IdVisu")=0
 RS1("NumMembre")=RS2("NumMembre")
 RS1("SuperAdmin")=0
 RS1("OffVisu")=0
 RS1("OffValid")=0
  
 RS1.update

response.redirect("valid_p_adhesionO.asp")
%>
 

				  
	</td>
</tr>
			  
                </table>  <!-- #include file="grand_footer.txt"-->  
				
<!-- #include file="deconnexion.asp"-->
</div>

</body>
</html>