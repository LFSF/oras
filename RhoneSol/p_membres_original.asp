<%

if Request.Form("test")="oui" then
'===================================
session("admin_securite")=""
Session("logadh")=""
	session("page precedente")="" 
	session("lenumeroadh")=""
	session("lenomadh")="" 
	session("leprenomadh")="" 
	session("lestatusadh")="" 
	session("leloginadh")="" 
    session("lemailadh")=""
    session("leloginlogin")=""
    session("leadresse")=""
    session("leville")=""
    session("lecp")=""
    session("letelephone")=""
    session("leportable")=""
    session("lecommentaire")=""
    session("lenaissance")=""
    session("lemoisdenaissance")=""
    session("lejourdenaissance")=""
    session("leanneedenaissance")=""
    session("ledateadhesion")=""

'============== Verification des  identifiants ==================

	espace="&#034;"
	simplecot="&#039;"
lelelog=Request.Form("loga")
lelogin = replace(REPLACE( lelelog,"""",espace),"'",simplecot)
lelepass=Request.Form("password")
lepass = replace(REPLACE( lelepass,"""",espace),"'",simplecot)
'===============redirection vers page administrateur
	

	
		'if (lelogin="tristan" and lepass="tristan") then 
			'Session("logadh")="oui"
			'session("nom_admin")="Ndjock"
			'session("prenom_admin")="tristan"
			'session("admin_securite")="ok"
			'Response.Redirect("p_admin.asp")
		'else
			'session("admin_securite")="no"
		'end if
		
		
		'**************************************Login  t_login*********************************************'
		
	
	log_admin = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= " & Server.MapPath("bd/upload.mdb")

 
	'Set connverif0 = Server.CreateObject("ADODB.Connection")
	 Set verif_login = Server.CreateObject("ADODB.Connection")
 
	'connverif0.Open Verifid0
	verif_login.Open log_admin
	'Set rs_verif = Server.CreateObject("ADODB.RecordSet")
	'SQLverif = "Select * from Tadhesion WHERE (login = '" &  lelogin & " ' and passe = '" &  lepass & " ');"
	
	'
	set rs_verif = verif_login.Execute("SELECT * FROM MEMBRE WHERE MailMembre = '" & lelogin & "' AND MdpMembre = '" & lepass & "' AND AdminMembre = " & 1 & "")
	
	' 1/ On verifie dans un premier temps que la personne est inscrite en tant que membre
	'set rs_verif = verif_login.Execute("SELECT * FROM MEMBRE WHERE MailMembre = '" & lelogin & "' AND MdpMembre = '" & lepass & "'")
	
	
	'Set rsRights = Server.CreateObject("ADODB.RecordSet")
	set rs_Rights = verif_login.Execute("SELECT * FROM ADMIN WHERE NumMembre = " & rs_verif("NumMembre") & "")


	'rs_rights.open SQL_rights, verif_login 
	If not rs_verif.EOF Then 
	Session("logadh")="oui"
	
	session("admin_securite")="ok"
	session("admin_id") = rs_verif("NumMembre") 
	session("admin_nom")= rs_verif("NomMembre") 
	session("admin_prenom")=rs_verif("PrenomMembre") 
	session("admin_adresse")=rs_verif("AdrMembre") 
	session("admin_cp")=rs_verif("CPMembre") 
	session("admin_ville")=rs_verif("VilleMembre") 
	session("admin_tel")=rs_verif("TelMembre") 
	session("admin_email")=rs_verif("MailMembre") 
	session("admin_password")=rs_verif("MdpMembre") 
	session("admin_acces_admin")=rs_rights("SuperAdmin") 
	session("acces_actu")=rs_rights("ActuVisu") 
	session("acces_itw")=rs_rights("ItwVisu") 
	session("acces_cv")=rs_rights("CVVisu") 
	session("acces_id")=rs_rights("IDVisu") 

	
	
	
'response.Redirect("espaceadhpartenaires.asp")
	Response.Redirect("p_admin.asp")
	else
	session("admin_securite")="no"
	end if
		
		
		
		'********************************************************************************************
		
		
		
		
		
		
		
	'========fin redirection vers page administrateur

'********************** Tadhesion****************************************

'********************* fin Tadhesion************************************

'end if
	'Response.Redirect("accueil.asp?loga=no")
	Response.Redirect("p_membres.asp?loga=no")
	
else%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>




<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">Espace Membres</div>

<!--
<div id="post-it"><b><i>Sommaire</i></b><br />
_________________________________________________________<br /><br />

   ><em onclick="return fonc1()" onMouseOver="this.style.cursor='hand'; "> Historique</em><br />
   > <em onclick="return fonc2()" onMouseOver="this.style.cursor='hand'; ">Définition et principe</em><br />
   > <em onclick="return fonc3()" onMouseOver="this.style.cursor='hand'; ">Cadre législatif et réglementaire</em><br />
   > <em onclick="return fonc4()" onMouseOver="this.style.cursor='hand'; ">Où trouver des financements ?</em><br /></div>
-->
<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
	
	
    
	
	
	<tr><td>
	
	         
<center>
  <TABLE bordercolor=green align=center style="WIDTH: 100%; HEIGHT: 100%" border="1" cellSpacing=1  cellPadding=1 border=0>
   <!-- <TR bordercolor="#0033ff"> -->
	<TR bordercolor=green> 
     <TD valign="top"  width="8%" height="17">

           
			  <form name="f" action="p_membres.asp" method="post">
			<input type="hidden" name="test" value="oui">
            <P>
            <font color="green">Login</font><br>
            <INPUT name="loga" style="WIDTH: 96px; HEIGHT: 20px"  size=12>
			<br>
            
            <font color="green">Mot de passe</font><br>
            <INPUT name="password" style="WIDTH: 96px; HEIGHT: 20px" type=password size=12>

			
            </P>
			
			
            <center>

        <input type="submit" value="Valider" id="submit1" name="submit1" width="109" height="16" border="0">
      
      <%if Request.QueryString("loga")="no" then
      
      'Response.Write(SQLverif)
      
      %>
				<table align=center >
				<tr><td colspan="2" align="middle">
                        <P><font color="red"><b>ERREUR <br>inserer votre mail pour recevoir vos identifiants</b>
       </font></P>
            <P><FONT  color=#ff0000></FONT>&nbsp;</P> </td><tr><td colspan="2" align="middle">
			


</FORM>
 <form name="fff" action="p_envoi_identifiants.asp" method="post">
  Votre mail : <INPUT id=mail name=mail ><br>&nbsp;
      <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:   
       24px" value="Envoi identifiants" id=submit2 name=submit2 >
       </form>

</td>
</tr>
</table>
				<%end if%>
      
      
      <!---
       </FORM>
      --->
    <script>
document.f.loga.focus();
</script></center>
    
	</td></tr>

</table>

 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>
<%end if%> 