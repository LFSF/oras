<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rh&ocirc;ne-solidarit&eacute;</title>




<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<!-- #include file="connexion.asp"-->
<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Espace Membres</div>

<table border="0px" width="100%" cellpadding="10px">
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation Id&eacute;es Suggestions________________________________________________</font></td>
    </tr>
   <tr>
				<td width=82%>
	  <div align="justify">
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
		
		<A href="p_accueil.asp"><font size=1><b>
                         << Retour &agrave; l'Accueil &nbsp;</b></font>
                          </a></td></tr>
						  </table>
	<table width="400" border="0" valign="center" align="center">
	<tr><td>
 <%
'Requete SQL pour selectionner tout les membres
Set rsED = Conn.Execute("SELECT * FROM MEMBRE")
'...........Where News=oui

Set rsActu = Conn.Execute("SELECT * FROM ACTUALITE WHERE Visible=1 ORDER BY DateActu DESC")

ActuMail=""
i=0
Do While Not rsActu.EOF
	if DatePart("m", rsActu("DateActu")) = Month(Date) Then
		i=i+1
		ActuMail = ActuMail & "<a href=http://www.rhone-solidarite.com/p_actualitesbis.asp?num=" & rsActu("NumActu") & ">" & rsActu("TitreActu") & "</a><br/>"
		if i=5 Then
			Exit do
		End if
	End if
	rsActu.Movenext
Loop

compteurmail=0

' Tant que la bdd n'a pas fini d'etre lue ...
while not rsED.EOF

	'...on retient les membres qui d&eacute;sirent recevoir la newsletter
	if rsED("news") ="oui" then

		on error resume next
		
			compteurmail = compteurmail + 1

			' -----------------envoi information au destinataire ------------------------           
			Dim ObjSendMail
			Set ObjSendMail = CreateObject("CDO.Message") 

			

			'Configuration des information pour le serveur SMTP &agrave; distance
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le r&eacute;seau (SMTP sur le reseau).
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
			ObjSendMail.Configuration.Fields.Update

			
			
			'End remote SMTP server configuration section==
			     
			 
				 
			ObjSendMail.To = rsED("MailMembre")
			ObjSendMail.Subject = "Newsletter de Rhone Solidarite du " & session("date")
			ObjSendMail.From = "contact@rhone-solidarite.com"
			     
			' Ecriture du mail
			ContenuMail= "Bonjour " & rsED("NomMembre") & " " & rsED("PrenomMembre")
			ContenuMail= ContenuMail & "<br/><br/><br/>" & session("FCKeditor1") & "<br/><br/><br/><br/><br/><br/>"
			ContenuMail= ContenuMail & "Voici les derni&egrave;res actualit&eacute;s sur notre site : <br/>"
			ContenuMail= ContenuMail & ActuMail & "<br/><br/><br/><br/>"
			ContenuMail= ContenuMail & "P.S : Ce mail a &eacute;t&eacute; envoy&eacute; suite &agrave; votre demande sur Rhone-solidarit&eacute;."
			ContenuMail= ContenuMail & "Si vous ne souhaitez plus recevoir cette lettre d'info, vous <a href=""http://www.rhone-solidarite.com/desabonnement_newsletter.asp"">Modifier votre compte pour d&eacute;sactiver la newsletter</a>. "
			
			ObjSendMail.HTMLBody = ContenuMail
			'ObjSendMail.HTMLBody = "Bonjour " & rsED("NomMembre") & " " & rsED("PrenomMembre") & "<br/><br/><br/>" & session("FCKeditor1") & "<br/><br/><br/><br/><br/><br/>" &	" P.S : Ce mail a &eacute;t&eacute; envoy&eacute; suite &agrave; votre demande sur Rhone-solidarit&eacute;. Si vous ne souhaitez plus recevoir cette lettre d'info, vous <a href=""http://www.rhone-solidarite.com/desabonnement_newsletter.asp"">Modifier votre compte pour d&eacute;sactiver la newsletter</a>. "  
			
			'Si vous recevez ce mail donc la newsletter fonctionne correctement .<br/>Merci pour la confiance que vous nous accordez. <br/><br/> Le service des annonces de  Rhone-solidarite.com"
			ObjSendMail.Send

			Set ObjSendMail = Nothing  

		If Err.Number<>0 then	
			'response.write "Un erreur est survenue : " & err.description
		end if
	end if

	'Passage au membre suivant
	rsED.MoveNext
Wend

'fermeture de la connexion
rsED.Close 
Set rsED = Nothing

%> 



Newsletter envoy&eacute;e &agrave; <%=compteurmail%> membres.

<a href="p_admin.asp">Retourner &agrave; l'espace membre</a>

</td></tr>

</table>

 

<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
<!-- Ne pas toucher &agrave; ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
<!-- #include file="deconnexion.asp"-->
</html>