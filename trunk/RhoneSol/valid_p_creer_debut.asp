<%@ Language=VBScript %>
<HTML>
<HEAD>
<!-- #include file="grand_meta.txt"-->
<title>Rh�ne-solidarit�</title>




<link href="styles.css" rel="stylesheet" type="text/css" />
</HEAD>
<BODY>
 


<!--<'%

Session.Timeout =30


espace="&#034;"
simplecot="&#039;"



            
            
            Response.Write("<font size=10>" & "ERREUR DU SERVEUR !!" & chr(10)& " VOTRE DEMANDE A BIEN ETE PRISE EN COMPTE APPUYER SUR LA TOUCHE F5 OU PRECEDENTE." & "<br><br></font>")  
          
            
            '*********** fin de l'enregistrement dans la BD*****************
            
            
            
				Set Mail=Server.createObject("Persits.Mailsender") 
				Mail.Host = "mail.exilens.com"
				Mail.Port = 25 
				Mail.From = "contact@exilens.com"
				Mail.FromName = "Projet E-web" 
				Mail.AddAddress session("mail")
				Mail.AddAddress  "webmaster@exilens.com"
				Mail.Subject = "Votre projet E-web"
				Mail.Body = "Bonjour " &  session("sonstatus") & " " &  session("sonnom") & " " & session("sonprenom") &   chr(10) & chr(10) & "Nous vous remer�ions pour votre demande de projet E-web;" & chr(10)& "Nous vous r�pondrons dans les plus brefs d�lais. " & chr(10) & chr(10) &  "Cordialement."  & chr(10) & chr(10) & "Le service commercial"
				Mail.Send
            
            
         '  Set Mail=Server.createObject("Persits.Mailsender") 
		'		Mail.Host = "mail.exilens.com"
		'		Mail.Port = 25 
		'		Mail.From = "contact@exilens.com"
		'		Mail.FromName = "Projet E-web" 
		'		Mail.AddAddress ="webmaster@exilens.com"
		'		Mail.Subject = "Projet E-web"
		'		Mail.Body = "Projet de " &  session("sonstatus") & " " &  session("sonnom") & " " & session("sonprenom") &   chr(10) & chr(10) & "Nous vous remer�ions pour votre demande de projet E-web;" & chr(10)& "Nous vous r�pondrons dans les plus brefs d�lais. " & chr(10) & chr(10) &  "Cordialement."  & chr(10) & chr(10) & "Le service commercial"
		'		Mail.Send
            
            
            
            
                'Set Mail=Server.createObject("Persits.Mailsender") 
                
				'mail.Host = "mail.exilens.com"
				'Mail.Port = 25 ' Vous n'�tes pas oblig�s de sp�cifier cette valeur 25 est la valeur par d�faut'D�finition de l'exp�diteur
				'Mail.From = "contact@exilens.com"
				'Mail.FromName = "CV en ligne" ' Optional'D�finition du destinataire
				'Mail.AddAddress "exilens@free.fr"
				'Mail.Subject = "CV en ligne"
				'Mail.Body = "Bonjour " & Request.form("status") & " " &  a & " " &  b &   chr(10) & chr(10) & "Nous vous remer�ions pour votre inscription; " & chr(10) & chr(10) &  "Cordialement."  & chr(10) & chr(10) & "Le service CV en ligne"
				'Mail.Send
          
            
           
            
              ' Response.Write("<font color=red size=8>" & j & "<br><br></font>")  
       
            %> -->
            				
<%Response.Redirect("valid_p_creer_fin.asp")%>

<P>&nbsp;</P>

</BODY>
</HTML>
