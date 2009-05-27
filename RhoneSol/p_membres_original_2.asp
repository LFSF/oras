<!-- #include file="connexion.asp"-->

<%
if Request.Form("test")="oui" and session("vrf") = 0 then
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

'**************************************Login  t_login*********************************************'
		
		
	
	log_admin = "Provider=Microsoft.Jet.OLEDB.4.0; Data Source= " & Server.MapPath("bd/upload.mdb")

 

	 Set verif_login = Server.CreateObject("ADODB.Connection")
 

	verif_login.Open log_admin
	
	On Error Resume Next
		set rs_verif = verif_login.Execute("SELECT * FROM MEMBRE WHERE MailMembre = '" & lelogin & "' AND MdpMembre = '" & lepass & "' AND AdminMembre = " & 1 & "")
	If Err>0 Then
	session("vrf") = 1
	Response.Redirect("p_membres.asp?var=1")
	End If
 
	set rs_Rights = verif_login.Execute("SELECT * FROM ADMIN WHERE NumMembre = " & rs_verif("NumMembre") & "")

	If not rs_verif.EOF Then 
	Session("logadh")="oui"
	
	session("admin_securite")="ok"
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
	session("acces_off")=rs_rights("OffVisu")
	session("admin_id")=rs_rights("NumMembre")
	'session("admin_id")=rs_rights("NumAdmin")
	Response.Redirect("p_admin.asp")
	else
	
	
	
	
	
	session("admin_securite")="no"
	end if
	Response.Redirect("p_membres.asp?var=1")
	else

end if
%>

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







<script language="JavaScript" type="text/javascript">

function verifform()
{

// Vérifie si le nom est bien indiqué
 if(document.f.loga.value == "")
 {
  alert("\nMerci d'indiquer votre login.");
  document.f.loga.focus();
  return false;
 }

// Vérifie si le mot de passe est bien indiqué
 if(document.f.password.value == "")
 {
  alert("\nMerci d'indiquer votre mot de passe.");
  document.f.password.focus();
  return false;
 } 
 
}
 </script>
	 
<form action="p_membres.asp" method="post" id="f" name="f" onsubmit="return verifform()">
          <center>




		  
			<input type="hidden" name="test" value="oui">
<p>
            <font color="green">Login</font><br />
            <input name="loga" class="txt" id="loga" size="25" maxlength="100" /><br>
		  
            <font color="green">Mot de passe</font><br />
            <input type="password" name="password" class="txt" id="password" size="25" maxlength="20" /><br>
</p>		 

<input width="120" height="20" style="BACKGROUND-IMAGE: url(img\postit_gris_petit_penche2.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT: 24px" type="submit" value="Valider" id=submit1 name=submit1 size=36>
      
	  
	  </center>

      </form>
<% 
			If Request.QueryString("var")=1 then
%>
				
				<table align=center >
				<tr><td colspan="2" align="middle">
                        <P><font color="red"><b>ERREUR <br>inserer votre mail pour recevoir vos identifiants</b>
       </font></P>
            <P><FONT  color=#ff0000></FONT>&nbsp;</P> </td><tr><td colspan="2" align="middle">
			

 <form name="fff" action="p_envoi_identifiants.asp" method="post">
  Votre mail : <INPUT id="mail" name="mail" ><br>&nbsp;
      <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:   
       24px" value="Envoi identifiants" id=submit2 name=submit2 >
       </form>

</td>
</tr>
</table>
<%
		end if
%>
			
        
      
    <script>
document.f.loga.focus();
</script>    
	</td></tr>

</table>

 <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>



<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>