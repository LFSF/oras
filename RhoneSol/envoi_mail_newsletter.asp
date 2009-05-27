
<!-- #include file="connexion.asp"-->



 <%
'Requete SQL pour selectionner tout les membres
Set rsED = Conn.Execute("SELECT * FROM MEMBRE ")    
'...........Where News=oui

compteurmail=0

' Tant que la bdd n'a pas fini d'etre lue ...
while not rsED.EOF

	'...on retient les membres qui désirent recevoir la newsletter
	if rsED("news")  ="oui"   then

	
	
		on error resume next
		
			compteurmail = compteurmail + 1

			' -----------------envoi information au destinataire ------------------------           
			Dim ObjSendMail
			Set ObjSendMail = CreateObject("CDO.Message") 

			

			'Configuration des information pour le serveur SMTP à distance
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
			ObjSendMail.Configuration.Fields.Update

			
			
			'End remote SMTP server configuration section==
			     
			 
				 
			ObjSendMail.To = rsED("MailMembre")
			ObjSendMail.Subject = "Newsletter de Rhone Solidarite du " & session("date")
			ObjSendMail.From = "contact@rhone-solidarite.com"
			     
			' Ecriture du mail
			'ObjSendMail.HTMLBody = "Bonjour " &  rs("NomMembre") & " " &  rs("PrenomMembre") & " " &   "<br><br>
			
			ObjSendMail.HTMLBody = "Bonjour " & rsED("NomMembre") & " " & rsED("PrenomMembre") & "<br/><br/><br/>" & session("FCKeditor1") & "<br/><br/><br/><br/><br/><br/>" &	" P.S : Ce mail a été envoyé suite à votre demande sur Rhone-solidarité. Si vous ne souhaitez plus recevoir cette lettre d'info, vous <a href=""http://www.rhone-solidarite.com/desabonnement_newsletter.asp"">Modifier votre compte pour désactiver la newsletter</a>. "  
			
			'Si vous recevez ce mail donc la newsletter fonctionne correctement .<br>Merci pour la confiance que vous nous accordez. <br><br> Le service des annonces de  Rhone-solidarite.com"
			 


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



Newsletter envoyée à <%=compteurmail%> membres.

<a href="p_admin.asp">Retourner à l'espace membre</a>
