<%@LANGUAGE="VBSCRIPT"%>

<!-- #include file="admin_securite.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp" -->
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


<%
	
	espace="&#034;"
	simplecot="&#039;"
	
	
	if (request.form("cb_actu")="on") then
		session("RedacteurMembre1")="oui"
	else
		session("RedacteurMembre1")="non"
	end if
	
	
	if(request.form("cb_demandeitw")="on") then
	cb_demandeitw="oui"
	else
	cb_demandeitw="non"
	end if
	
	
	if(request.form("cb_creationsite")="on") then
	cb_creationsite="oui"
	else
	cb_creationsite="non"
	end if
	
	if(request.form("cb_news")="on") then
	cb_news="oui"
	else
	cb_news="non"
	end if
	
	if(request.form("cb_autredemande")="on") then
	cb_autredemande="oui"
	else
	cb_autredemande="non"
	end if
	
	
	
	if (request.form("cb_ecriture")="on") then
		session("EcrireItwMembre")="oui"
	else
		session("EcrireItwMembre")="non"
	end if
	
	
	
	
	
	
		  Dim rsED
		  
			compteur=0	  
		  
			   Set rsED = Conn.Execute("SELECT * FROM ADMIN where   NumMembre=" & session ("num"))
		 
		  IF rsED.EOF Then
		  Response.Write("<font color='blue'></br>Le NO existe PAS!! ")
		  
		  response.write("</br></br>" & session("RedacteurMembre1") & "</br></br>" )
		  
		
		  
		  
			'SQL="SELECT * FROM ADMIN where NumMembre=" & session ("num")
			SQL="SELECT * FROM ADMIN"
		
			Set rsED0 = server.createobject("ADODB.Recordset")
			rsED0.Open SQL, Conn, 3, 3

			rsED0.addnew
			
			rsED0("CvVisu")=0
			rsED0("CvValid")=0
			
			if(session("RedacteurMembre1")="oui") then
			rsED0("ActuAdd")=1
			rsED0("ActuVisu")=1
			rsED0("ActuValid")=0
			rsED0("ActuModif")=1
			else
			rsED0("ActuAdd")=0
			rsED0("ActuVisu")=0
			rsED0("ActuValid")=0
			rsED0("ActuModif")=0
			end if
			
			if(session("InterviewMembre1")="oui") then
			rsED0("ItwAdd")=1
			rsED0("ItwVisu")=1
			rsED0("ItwValid")=0
			rsED0("ItwModif")=1
			else
			rsED0("ItwAdd")=0
			rsED0("ItwVisu")=0
			rsED0("ItwValid")=0
			rsED0("ItwModif")=0
			end if
			
			
			rsED0("IdVisu")=0
			rsED0("NumMembre")=session ("num")
			rsED0("SuperAdmin")=0
			rsED0("OffVisu")=0
			rsED0("OffValid")=0
				
		
			rsED0.update
			rsED0.Close
		  
		  
		   '  SQLbis = "UPDATE MEMBRE SET AdminMembre=1 WHERE  NumMembre = " & session ("num") & ""
		   	'SQLbis = "UPDATE MEMBRE SET AdminMembre=1, EcrireItwMembre='" & session("EcrireItwMembre") & "', RedacteurMembre ='" & session("RedacteurMembre1") & "' WHERE NumMembre = " & session ("num") & ""
			
			SQLbis = "UPDATE MEMBRE SET AdminMembre=1, EcrireItwMembre='" & session("EcrireItwMembre") & "', RedacteurMembre ='" & session("RedacteurMembre1") & "', InterviewMembre='" & cb_demandeitw & "', CreationsiteMembre ='" & cb_creationsite & "' , News ='" & cb_news & "' WHERE NumMembre = " & session ("num") & ""
			
			
			conn.Execute(SQLbis)
		   
	   response.Write("<br><br> req SQL "  & SQLbis)
		conn.Execute(SQLbis)
		  
		  
		  
		  Else
		  While Not rsED.EOF
		
		  Response.Write("<font color='blue'></br>OK Le n° existe!! ")
		
			  compteur = compteur + 1
			  
		SQL="SELECT * FROM ADMIN where NumMembre=" & session ("num")

			Set rsED1 = server.createobject("ADODB.Recordset")
			rsED1.Open SQL, Conn, 3, 3

			rsED1.MoveFirst
			
			rsED1("CvVisu")=0
			rsED1("CvValid")=0
			
			if(session("RedacteurMembre1")="oui") then
				rsED1("ActuAdd")=1
				rsED1("ActuVisu")=1
				rsED1("ActuValid")=0
				rsED1("ActuModif")=1
			else
				rsED1("ActuAdd")=0
				rsED1("ActuVisu")=0
				rsED1("ActuValid")=0
				rsED1("ActuModif")=0
			end if
			
			if(session("EcrireItwMembre")="oui") then
				rsED1("ItwAdd")=1
				rsED1("ItwVisu")=1
				rsED1("ItwValid")=0
				rsED1("ItwModif")=1
			else
				rsED1("ItwAdd")=0
				rsED1("ItwVisu")=0
				rsED1("ItwValid")=0
				rsED1("ItwModif")=0
			end if

			rsED1("IdVisu")=0
			rsED1("SuperAdmin")=0
			rsED1("OffVisu")=0
			rsED1("OffValid")=0

			rsED1.update
			rsED1.Close

			'SQLbis = "UPDATE MEMBRE SET AdminMembre=1, EcrireItwMembre='" & session("EcrireItwMembre") & "', RedacteurMembre ='" & session("RedacteurMembre1") & "' WHERE NumMembre = " & session ("num") & ""
			
			SQLbis = "UPDATE MEMBRE SET AdminMembre=1, EcrireItwMembre='" & session("EcrireItwMembre") & "', RedacteurMembre ='" & session("RedacteurMembre1") & "', InterviewMembre='" & cb_demandeitw & "', CreationsiteMembre='" & cb_creationsite & "' , News='" & cb_news & "' WHERE NumMembre = " & session ("num") & ""
		
			
			
			response.write("<br/><br/>" & SQLbis & "<br/><br/>")
			conn.Execute(SQLbis)

		
		rsED.MoveNext
			Wend
			rsED.Close 
			Set rsED = Nothing
			End If
		

	
	'*********************ENVOI MAIL POUR SIGNALER LA PRISE EN COMPTE DES DEMANDES DE L'ADHERENT**********************
	
	
		' -----------------envoi information au destinataire ------------------------           
			var_compteur_check=0
			
			Dim ObjSendMail
			Set ObjSendMail = CreateObject("CDO.Message") 

			'Configuration des information pour le serveur SMTP à distance
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Envoi du message en utilisant le réseau (SMTP sur le reseau).
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") ="localhost"
			ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
			ObjSendMail.Configuration.Fields.Update

			if(session("RedacteurMembre1")="oui") then
			var_redaction ="-  Etre rédacteur et écrire des articles (Voir dans votre espace Membre). <br/>"
			var_compteur_check = var_compteur_check + 1
			var_demande_seule=var_redaction
			else
			var_redaction=""
			end if

		    if(session("EcrireItwMembre")="oui") then
			var_demandes_ecritureItw ="- Pouvoir faire des interviws.<br/>"
			var_compteur_check = var_compteur_check + 1
			var_demande_seule=var_demandes_ecritureItw
			else
			var_demandes_ecritureItw =""
			end if
			
			if(cb_demandeitw="oui") then
			var_etre_itwe="- Etre interviwé.<br/>"
			var_compteur_check = var_compteur_check + 1
			var_demande_seule=var_etre_itwe
			else
			var_etre_itwe=""
			end if
			
			
			if(cb_creationsite="oui") then
			var_creationsite="- Créer un  site un internet.<br/>"
			var_compteur_check = var_compteur_check + 1
			var_demande_seule=var_creationsite
			else
			var_creationsite=""
			end if
			
			
			
			if(cb_news="oui")then
			var_news="- Recevoir la newsletter  de  www.Rhône-Solidarite.com<br/>"
			var_compteur_check = var_compteur_check + 1
			var_demande_seule=var_news
			else
			var_news=""
			end if
	
			
			if(cb_autredemande="oui" or session("MessageMembre1")<>"")then
			var_autre_mess="- Votre message posté<br/>"
			var_compteur_check = var_compteur_check + 1
			var_demande_seule=var_autre_mess
			end if
			
			if(cb_autredemande="non" and session("MessageMembre1")="")then
			var_autre_mess=""
			end if	
			
			
			
			'*****************************************************
			
			if(session("CooperationMembre1")="oui")then
			var_cooperation="- La Coopération Décentralisée<br/>"
			else
			var_cooperation=""
			end if
			
			
			if(session("SolidaireMembre1")="oui") then
			var_solidarite="- Le Commerce Solidaire<br/>"
			else
			var_solidarite=""
			end if
			
			if(session("FormationMembre1")="oui") then
			var_formation="- La Formation<br/>"
			else
			var_formation=""
			end if
			
			
			if(session("AutreMembre1")="oui") then
			var_domaine_autre="- Un autre domaine de partenariat<br/>"
			else
			var_domaine_autre=""
			end if
			
			
			if(session("AutreMembre1")="non" and session("FormationMembre1")="non" and session("SolidaireMembre1")="non" and session("CooperationMembre1")="non") then
			var_demande_partenariat=""
			else			
			var_demande_partenariat=" Nous avons bien noté que vous souhaitez être notre partenaire dans les domaines suivants : <br/>" & var_cooperation & var_solidarite & var_formation & var_domaine_autre
			end if
			
			
			var_message_final= "Bonjour "& session("NomMembre1") & " " & session("PrenomMembre1") & "<br/><br/><br/>" 
			var_message_final=var_message_final & "  " &  var_demande_partenariat & "<br/><br/>" 
			
			
			
			if(var_compteur_check=1)then
			
				'if(var_domaine_autre="") then
				'var_message_final=var_message_final & "<br/><br/> Nous vous remerçions de votre confiance.<br/><br/> L'équipe de www.rhone-solidarite.com"
				'else	
				var_message_final=var_message_final & "De plus votre demande pour :<br/>" & var_demande_seule 
				var_message_final=var_message_final & "<br/>A  bien été prise en compte.<br/><br/>"
				'end if
				
			end if
			
			
			
			if(var_compteur_check>=2)then
			
				if(var_demande_partenariat="") then
				'var_message_final=var_message_final & "Vos demandes pour :<br/>" & var_redaction & 	var_demandes_ecritureItw & var_creationsite & var_news 
			
					var_message_final=var_message_final & "Vos  demandes  ont bien été prise en compte<br/>" 
			

			else
				'var_message_final=var_message_final & "De plus vos demandes pour :<br/>" & var_redaction & 	var_demandes_ecritureItw & var_creationsite & var_news 
				var_message_final=var_message_final & "De plus vos autres demandes  ont bien été prise en compte<br/>" 
				
				
				end if
			
			
			'var_message_final=var_message_final & " Ont bien été prises en compte.<br/><br/>"
			end if
			
			
			
			
			
			
				var_message_final=var_message_final & "Nous vous remerçions de votre confiance.<br/><br/> L'équipe de www.rhone-solidarite.com"
		
			
			'End remote SMTP server configuration section==

			ObjSendMail.To = session("MailMembre1")
			ObjSendMail.Subject = "Réponse concernant votre adhésion  "
			ObjSendMail.From = "contact@rhone-solidarite.com"
			     
			' Ecriture du mail
			
			response.write("<br/><br/>" & var_message_final & " <br/><br/>compteur : " & 	var_compteur_check & "<br/><br/>")
		
			ObjSendMail.HTMLBody = var_message_final  
			ObjSendMail.Send

			Set ObjSendMail = Nothing  
	
	
	
	'**************************************************FIN ENVOI MAIL*******************************************************
	
	
	

response.redirect("p_admin_adhesion_validation.asp")
%>
</body>
<!-- #include file="deconnexion.asp"-->
</html>