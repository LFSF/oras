<?xml version="1.0" encoding="iso-8859-1"?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
<script language="JavaScript">
<!--
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>

<SCRIPT language=JavaScript> 
function fonctest()
{
window.location.href="espaceadh.asp"
}
function fonc100()
{
window.location.href='testd.asp'
}
function fonc1()
{
window.location.href='ndambog.asp'
}
<!--Hide JavaScript from Java-Impaired Browsers 
//--> 


</SCRIPT>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>


<!-- #include file="connexion.asp"-->


<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_orange">Envoi Identifiants </div>


<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Envoi Identifiants____________________________________________________________________</font></td>
    </tr>
	
<tr>
				<td width=82%>
					 
	  
	  
	  <div align="justify">
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS
		-->
		
		<A href="p_membres.asp"><font size=1><b>
                         << Retour à l'espace membres &nbsp;</b></font>
                          </a></td></tr>


						  
						  
						  
						  
						  <%
						  
						    Dim rsED
		  
			compteur=0	  
		  
			   Set rsED = Conn.Execute("SELECT * FROM MEMBRE where   MailMembre='" & request.form("mail") & "'" )
		 
		  
		 
		  IF rsED.EOF Then
		  
		  %>
		  
		  
		  <table width="400" border="0" valign="center" align="center">
<tr>
<td>Bonjour
<br>
<br>Nous sommes désolé mais le mail &nbsp;<%=request.form("mail")%> &nbsp;n'existe pas!
<br><font color="blue">
</td>
</tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>				  
				
</table>


		  
		 
		  
		<% 
	 
		  Else
		  While Not rsED.EOF
		
		  'Response.Write("<font color='blue'></br>OK Le mail existe!!     " & rsED("MailMembre") & "<br/>" & rsED("NomMembre") & "<br/>" & rsED("MdpMembre")  )
		
			  compteur = compteur + 1
			

			if(rsED("AdhesionMembre")="oui") then
			
			
			
			
			var_message= "Bonjour  " & rsED("NomMembre") & " " & rsED("PrenomMembre")
			var_message =var_message & "<br/><br/>Voici vos identifiants de connexion : <br/><br/>"
			var_message =var_message & "Login : " & rsED("MailMembre")
			var_message =var_message &  "<br/> Mot de passe : " & rsED("MdpMembre")
			var_message =var_message & "<br/><br/><br/>Cordialement!<br/><br/><br/>L'équipe de www.rhone-solidarite.com"
			end if		
			
			if(rsED("AdhesionMembre")="non") then
			
			envoi_lien ="<a href=http://www.rhone-solidarite.com/p_confirmation.asp?confirmation=" & rsED("MailMembre") & "&mdp=" & rsED("MdpMembre") & " >Lien confirmation adhesion</a>." 

			
			var_message= "Bonjour  " & rsED("NomMembre") & " " & rsED("PrenomMembre")
			var_message =var_message & "<font color='red'><br/><br/>IMPORTANT vous êtes bien enregistré mais vous n'avez pas validé votre inscription!</font><br/>Cliquez ici pour la validation : <br/>" & envoi_lien & "<br/><br/>"
			var_message =var_message & "<br/><br/>Une fois la validation effective , vous pourrez vous connecter avec les identifiants suivants : <br/><br/>"
			var_message =var_message & "Login : " & rsED("MailMembre")
			var_message =var_message &  "<br/> Mot de passe : " & rsED("MdpMembre")
			var_message =var_message & "<br/><br/><br/>Cordialement!<br/><br/><br/>L'équipe de www.rhone-solidarite.com"
			end if			
		
		
			Dim ObjSendMail
			Set ObjSendMail = CreateObject("CDO.Message") 

			'Configuration des information pour le serveur SMTP à distance
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
			ObjSendMail.Configuration.Fields.Update

			ObjSendMail.To =  rsED("MailMembre")
			ObjSendMail.Subject = "Envoi Identifiants de connexion"
			ObjSendMail.From = "contact@rhone-solidarite.com"
			     
			' Ecriture du mail
			
		
			ObjSendMail.HTMLBody = var_message  
			ObjSendMail.Send

			Set ObjSendMail = Nothing  
		
		%>
		
	<table width="400" border="0" valign="center" align="center">
<tr>
<td>Bonjour
<br>
<br>Vos identifiants vous ont été envoyé à l'adresse suivante :
<br><font color="blue"><%=rsED("MailMembre")%></font>
</td>
</tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>
				  <tr> 
                    <td>&nbsp;</td>
                  </tr>				  
				
</table>	
		
		
		
		<%
		
		
		rsED.MoveNext
			Wend
			rsED.Close 
			Set rsED = Nothing
			End If
						  
						  
						  %>
						  
						  
						  
						  
						  

<br><br><br><br><br>
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
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>


  <!--remise a zero des sessions du formulaire
  -->
  
<%
session("email")=""
session("civilite")=""
session("age")=""
session("nom")=""
session("prenom")=""
session("adresse")=""
request.form("adresse")
session("cp")=""
session("ville")=""
session("email")=""
session("tel")=""
session("niveau_formation")=""
session("diplome_en_cour")=""
session("diplome_obtenu")=""
session("autre_diplome")=""
session("profil")=""
session("intitule_poste")=""
session("experience_pro")=""
session("commentaire")=""
session("joindre_fichier")=""
session("lien_http")=""
%>

  <!------------------------------------------fin remise a zero----------------------------------------------------------->
  
  <!-- #include file="deconnexion.asp"-->
 </body>
</html>