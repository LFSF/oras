<!-- #include file="admin_securite.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
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
               
    
                                    
  for i=1 to session("lecompteur")
	
	 j0=Request.Form("checkbox" & i)
	
	if j0="on" then
	jj0=1
	else
	jj0=0
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
	
	
	

	
	
				
	
				
				
			
				
		
		'********* mise a jour table contact_organisme		
		
		
		
		'IMPORTANT  M est une donnee ALPHANUMERIQUE DONC BIENPENSE A FERME LA COTE
		'SQL = "UPDATE t_login SET acces_cv='oui'WHERE  N° ='" & m  & "'"
		
	
	
			
	
		
		
	'SQL = "UPDATE MEMBRE SET AdminMembre= '" & jj0 & "' WHERE  NomMembre = '" & a & " '"
	
	SQL = "UPDATE MEMBRE SET AdminMembre= '" & jj0 & "' WHERE  MailMembre = '" & c & " '"
	
	
	'zzz=104
		
		
		' IMPORTANT DANS CET EXEMPLE  MM EST NUMERIQUE DONC  ON NE FERME PAS AVEC DES COTE
		'SQL ="UPDATE t_depotcv SET ok_parution='oui'WHERE num =" & mm 
		'SQL ="UPDATE MEMBRE SET AdminMembre= '" & jj0 & "' WHERE  NumMembre =" & zzz 	
		
		
			                       
		Response.Write("<br><br>" & a & " " & b & "  " & c & "  " & f & "  <font color=red> jj = "&  jj &"</font>  "& sql)
		conn.Execute(SQL)
				
		'**** fin de la mise a jour*****************		
				
				
				
			'	end if
				
				
				
	
	 
next
 
	'l=Request.Form("yourFieldNameHere2")
'Response.Write("<br> corp du message :" & l  )
 Response.Redirect("p_admin_gestion_login.asp")

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
                     

        <DIV class=txt align=justify>&nbsp;
        
       
        
        </DIV>
                        <DIV class=txt align=justify>&nbsp;
                        
                        
                        
                    
                         
            
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
<!-- #include file="deconnexion.asp"-->
</html>