<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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





<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>
<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

<table border="0px" width="100%" cellpadding="10px">
	
	
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Espace membres_______________________________________________________________</font></td>
    </tr>
				<tr>
				<td width=82%>
					  
	  
	  
	  <div align="justify">
        
        
        <%
       ' if 	 session("prenom_admin")="invité"  then
        
        %>
         <DIV class=txt align=justify>&nbsp;
		 
		 
		 
		 
		  <%
               
               
               
               
               
               
               	espace="&#034;"
			simplecot="&#039;"
               
     
     
     dbPath = Server.MapPath("bd/bd_rs.mdb")
	 Set Conn = Server.CreateObject("ADODB.Connection")
	 Conn.Open "DRIVER={Microsoft Access Driver (*.mdb)};" _
	 & " DBQ=" & dbPath      
         
                                    
  for i=1 to session("lecompteur")
	
	 j0=Request.Form("checkbox" & i)
	j1= Request.Form("checkbox1" & i)
	j2= Request.Form("checkbox2" & i)	
	j3= Request.Form("checkbox3" & i)
	j4= Request.Form("checkbox4" & i)
	j5= Request.Form("checkbox5" & i)
	j6= Request.Form("checkbox6" & i)
	
	
	if j0="on" then
	jj0="oui"
	else
	jj0="non"
	end if
	
	if j1="on" then
	jj1="oui"
	else
	jj1="non"
	end if
	
	if j2="on" then
	jj2="oui"
	else
	jj2="non"
	end if
	
	
	if j3="on" then
	jj3="oui"
	else
	jj3="non"
	end if
	
	if j4="on" then
	jj4="oui"
	else
	jj4="non"
	end if
	
	
	if j5="on" then
	jj5="oui"
	else
	jj5="non"
	end if
	
	
	if j6="on" then
	jj6="oui"
	else
	jj6="non"
	end if
	
	
	
	
	
	
	a=replace(REPLACE( Request.Form("nom" & i),"""",espace),"'",simplecot)
	
	
	b=replace(REPLACE( Request.Form("prenom" & i),"""",espace),"'",simplecot)
	c=replace(REPLACE( Request.Form("email" & i),"""",espace),"'",simplecot)
	'd=replace(REPLACE( Request.Form("fonction" & i),"""",espace),"'",simplecot)
	'e=replace(REPLACE( Request.Form("organisme" & i),"""",espace),"'",simplecot)
	f=replace(REPLACE( Request.Form("adresse" & i),"""",espace),"'",simplecot)
	g=replace(REPLACE( Request.Form("cp" & i),"""",espace),"'",simplecot)
	h=replace(REPLACE( Request.Form("ville" & i),"""",espace),"'",simplecot)
	'k=replace(REPLACE( Request.Form("civilite" & i),"""",espace),"'",simplecot)
	'l=replace(REPLACE( Request.Form("yourFieldNameHere2"),"""",espace),"'",simplecot)
	
	m=replace(REPLACE( Request.Form("lenum" & i),"""",espace),"'",simplecot)
	
	
	
	'Response.Write( Request.Form("compteur" & i)& " ")
	'Response.Write( Request.Form("civilite" & i)& " ")
	'Response.Write( Request.Form("nom" & i)& " ")
	'Response.Write( Request.Form("prenom" & i)& "<br>")
	'Response.Write( Request.Form("email" & i)& "  ")
	'Response.Write( Request.Form("fonction" & i)& "  ")
	'Response.Write( Request.Form("organisme" & i)& "<br>")
	'Response.Write( Request.Form("adresse" & i)& "<br>")
	'Response.Write( Request.Form("cp" & i)& "<br>")
	'Response.Write( Request.Form("ville" & i)& "<br>")
	'Response.Write( Request.Form("checkbox" & i)& "<br>")
	'Response.Write( Request.Form("lenum" & i)& "<br><br>")
	
	
	
				
	
				''envoi accuse de reception au demandeur d 'information
                'Set Mail=Server.createObject("Persits.Mailsender") 
				''Mail.Host = "smtp.free.fr"
				'Mail.Host = "mail.oras-conseil.com"
				'Mail.Port = 25 
				'Mail.From = "contact@oras-conseil.com"
				'Mail.FromName = "Oras-conseil" 
				'Mail.AddAddress c
				'Mail.Subject = "Journée d'information du 12 mai 2005"
				'Mail.Body = "Bonjour "  & " " & k & " " &  a & "   " &   b &   chr(10) & chr(10) &  l &   chr(10) & chr(10) & "Cordialement." &  chr(10) & chr(10) & "L'Equipe ORAS"  
				'Mail.Send
				
				
				
			
				
		
		'********* mise a jour table contact_organisme		
		
		
		
		'IMPORTANT  M est une donnee ALPHANUMERIQUE DONC BIENPENSE A FERME LA COTE
		'SQL = "UPDATE t_login SET acces_cv='oui'WHERE  N° ='" & m  & "'"
		
	
	
			
		'SQL = "UPDATE t_login SET acces_cv='non' WHERE  nom = '" & a & " '"
	
		
		'SQL = "UPDATE t_login SET acces_forum='" & jj4 & "' , acces_cv='"  & jj  & " '  WHERE  nom = '" & a & " '"
	
		
		
		SQL = "UPDATE t_login SET acces_admin='" & jj0 & "' , acces_actualites='" & jj1 & "' , acces_interview='" & jj2 & "' , validation_actualites='" & jj3 & "' , validation_interviews='" & jj4 & "' , validation_cv='"  & jj5  & "'  , validation_offres_emplois='" & jj6 & "' WHERE  nom = '" & a & " '"
	
		
		
		' IMPORTANT DANS CET EXEMPLE  MM EST NUMERIQUE DONC  ON NE FERME PAS AVEC DES COTE
		'SQL ="UPDATE t_depotcv SET ok_parution='oui'WHERE num =" & mm 
		
		
		
			                       
		Response.Write("<br><br>" & a & " " & b & "  " & c & "  " & f & "  <font color=red> jj = "&  jj &"</font>  "& sql)
		conn.Execute(SQL)
				
		'**** fin de la mise a jour*****************		
				
				
				
			'	end if
				
				
				
	
	 
next
 
	'l=Request.Form("yourFieldNameHere2")
'Response.Write("<br> corp du message :" & l  )
 Response.Redirect("p_admin.asp")

               %>   
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 </DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
     
                        <DIV class=txt align=justify>&nbsp;</DIV>
         <br>
                         <!--
                          <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="promote_envoi_dossier.asp">
                        Envoi  de dossier Salon promote 2005
                        &nbsp;
                          </a>
                          
                         </DIV>
                          <br>
                         
                          <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="promote_dossier_voir.asp">
                        Entreprises/organismes ayant demandé un dossier
                        
                        &nbsp;
                          </a>
                          
                         </DIV>
						 -->
                         
                         <%
                        ' else
                         
                         %>
        <DIV class=txt align=justify>&nbsp;
        
       
        
        </DIV>
                        <DIV class=txt align=justify>&nbsp;
                        
                        
                        
                        <!--
                        <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="http://lwserv4.com/webmail2/">
                         Accès Mail &nbsp;
                          </a>                         
                          </DIV>
						  
						  
                          <br>
                          
                          <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="p_admin_derniers_post.asp">
                        Visualisation et validation des derniers posts &nbsp;
                          </a>
                          
                          </DIV>
                          <br>
                           <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_contact_visualiser.asp">
                        Voir le fichier Entreprises/Organismes &nbsp;
                          </a>
                          
                          </DIV>
                          <br>
                           <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_contact_a_contacter_12mai.asp">
                        Envoyer un mailing pour la journée du 12 mai 2005 &nbsp;
                          </a>
                          
                          </DIV>
                          <br>
                          
                          
                          
                           <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_contact_a_contacter_12mai_infos_incompletes.asp">
                        Envoyer mailing pour le 12 mai (dossiers incomplets) &nbsp;
                          </a>
                          
                          </DIV>
                          <br>
                           <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_contact_visualiser_journee12mai.asp">
                        Voir E/O contactés pour journée du 12 mai 2005&nbsp;
                          </a>
                          
                          </DIV>
                          <br>
                            <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_contact_visualiser_journee12mai_fichiers_incomplets.asp">
                        Voir E/O contactés 12 mai 2005 (incomplets)&nbsp;
                          </a>
                          
                          </DIV>
                          <br>
                            <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_organisme_inscrite_journee12mai.asp">
                        Voir E/O inscrits pour la journée du 12 mai 2005&nbsp;
                          </a>
                          
                         </DIV>
                         -->
						 <!--
                         <br>
                         
                          <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="promote_envoi_dossier.asp">
                        Envoi  de dossier Salon promote 2005
                        &nbsp;
                          </a>
                          
                         </DIV>
                         
                           <br>
                         
                          <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="promote_dossier_voir.asp">
                        Entreprises/organismes ayant fait une demande de dossier
                        
                        &nbsp;
                          </a>
                          
                         </DIV>
                         
                         <br>
                         
                         <br>
                         
                            <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="fiche_formation.asp">
                         Inscription formation &nbsp;
                          </a>                         
                          </DIV>
                          <br>
                         
                        
                         <DIV class=paragraphe1  > 
                           
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         <IMG height=9 src="img/communs/puceflch.gif" width=7>
                         &nbsp; <A class=lien href="accueil.asp">
                       
                         <A class=lien href="archives.asp">
                         Accès pages archivées &nbsp;
                          </a>                         
                          </DIV>
                          <br>
						  
						  -->
                         
                         <%                 
						 ' end if
                         %>
                         </DIV>
                         <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                       
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
     
                        <DIV class=txt align=justify>&nbsp;</DIV>
                       
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
                        <DIV class=txt align=justify>&nbsp;</DIV>
						<!------ fin corps de texte-------------------->
					</td>
					</tr>
					</table>

<table width="670" border="0" align="center" valign="center" class="txt">
	<tr>
		<td width="670" valign="bottom">_______________________________________________________________________________________________________________</td>
	</tr>
	
</table>

 <!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>