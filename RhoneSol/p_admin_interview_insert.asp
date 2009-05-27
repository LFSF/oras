<%@LANGUAGE="VBSCRIPT"%>
<!-- #include file="admin_securite.asp"-->
<% if not (session("admin_acces_admin")=1 or session("acces_itw")= 1) then
	response.redirect("p_admin.asp")
	else
%>
<!-- #include file="connexion.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<!-- #include file="grand_meta.txt"-->
<title>Rhône-solidarité</title>
<link href="styles.css" rel="stylesheet" type="text/css" />





<script language="JavaScript" type="text/javascript">>
function verifform()
{
 if(document.intw.rs.value == "")
  {
   alert("Merci d'indiquer le nom de l'entreprise ou organisme.");
   document.intw.rs.focus();
   return false;
  }
 if(document.intw.adresse.value == "")
  {
   alert("Merci d'indiquer une adresse.");
   document.intw.adresse.focus();
   return false;
  }
   if(document.intw.cp.value == "")
  {
   alert("Merci d'indiquer le code postal (99 si hors de france).");
   document.intw.cp.focus();
   return false;
  }
   if(document.intw.ville.value == "")
  {
   alert("Merci d'indiquer la ville.");
   document.intw.ville.focus();
   return false;
  }

 //vérifie si le Pays est bien indiqué  
 if(document.contact.pays.value == "")
 {
  alert("Merci d'indiquer votre pays .");
  document.intw.pays.focus();
  return false;
 }
   if(document.intw.responsable.value == "")
  {
   alert("Merci d'indiquer le nom de responsable .");
   document.intw.responsable.focus();
   return false;
  }
  if(document.intw.prenom_responsable.value == "")
  {
   alert("Merci d'indiquer le prénom du responsable .");
   document.intw.prenom_responsable.focus();
   return false;
  }
   if(document.intw.email.value == "")
  {
   alert("Merci d'indiquer une adresse email.");
   document.intw.email.focus();
   return false;
  }
 adresse_email = document.intw.email.value;
arobase = adresse_email.indexOf("@");
point = adresse_email.indexOf(".",arobase);
mauvais_endroit_point = arobase+1;
double_point = adresse_email.indexOf("..",arobase);
nbre_carac = adresse_email.length - point;
double_arobase = adresse_email.indexOf("@",arobase+1);
    
// dans l'ordre:            
// si l'arobase est absente ou en 1ere position
// ou si le . suivant l'arobase est juste derriere ou absent
// si la longueur de l'adresse est inferieure a 5 (grand minimum -> x@x.x)
// si il ya pas 2 . qui se suive deriere l'arobase
// si il y a bien 2 caractere minimum apres le . situe derriere l'arobase
// si il y a pas une arobase deriere la premiere arobase
if ( (arobase < 1) ||  
     (point <= mauvais_endroit_point) || 
     (adresse_email.length < 5) || 
     (double_point >= 0) ||
     (nbre_carac < 3) ||
     (double_arobase >= 0) )
    {
    alert ("l'adresse email est invalide.");
    document.intw.email.focus();
    return false;
    }
   if(document.intw.tel.value == "")
  {
   alert("Merci d'indiquer un téléphone.");
   document.intw.tel.focus();
   return false;
  }
   if(document.proposer.intitule.value == "")
  {
   alert("Merci d'indiquer l'intitulé de l'offre.");
   document.proposer.intitule.focus();
   return false;
  }
   if(document.proposer.description.value == "")
  {
   alert("Merci d'indiquer la description de l'offre.");
   document.proposer.description.focus();
   return false;
  }
   if(document.proposer.duree_contrat.value == "")
  {
   alert("Merci d'indiquer la durée du contrat de l'offre.");
   document.proposer.duree_contrat.focus();
   return false;
  }
 }
 </script>
<script language="JavaScript" type="text/javascript">>
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

<script language="JavaScript" type="text/javascript">>

function fonc2()
{
if((event.keyCode<48)||(event.keyCode>57))

    {
    // alert(window.event.keyCode);
    alert("Attention uniquement des chiffres !");
    event.returnValue=false;
    }
}
</script>


<script type="text/javascript" language="javascript" src="infobulle.js"></script>
<style type="text/css">
div.alien{cursor:hand}

</style>
</head>





<body>




<!-- #include file="grand_header.txt"-->

<div id="contenu">


<!-- #include file="fichier_menu.txt"-->


<div id="bandeau_vert">Espace Membres</div>

<div id="bandeau_menu"><!-- #include file="menu_deroulant.txt"--></div>

 <div align="justify">
<table border="0px" width="100%" cellpadding="10px">
 	<tr>
        <td colspan="2"><font color="#6faa06">Nouvelle interview_______________________________________________________________</font></td>
    </tr>
    <tr>
	<td width=82%>
           
        
        <!--AJOUT CORPS DE TEXTE IMPORTE DE ORAS-->
        
        <A class=lien href="p_admin_interview.asp"><font size=1><b>
                         << Retour Menu Interview &nbsp;</b></font>
                          </a></td></tr></table> </div>  

<form action="p_admin_interview_insertbis.asp" method="post"id="intw" name="intw" OnSubmit="return verifform()">
<input type="hidden" name="test" value="oui" />
 <table  border="0" align="center">
      <tr valign="top">
            <td width="100"><STRONG>L'interviewé :</STRONG></td>      
 	  </tr >
           
</table>

    <br/>
 <br/> 

<table border="0" cellspacing="0" cellpadding="0" class="txt">    
     <tr> 
        <td align="left">Vous êtes un(e)</td>
		<td>
			<table border="0" cellspacing="0" cellpadding="0" class="txt">
		   			<tr> 
					<td><input name="statut" type="radio" value="Entreprise"  checked /></td>
					<td>Entreprise&nbsp; </td>
					<td><input type="radio" name="statut" value="ONG" /></td>
					<td>ONG&nbsp; </td>
					<td><input type="radio" name="statut" value="Collectivité local" /></td>
					<td>Collectivité locale&nbsp; </td>
					<td><input type="radio" name="statut" value="Autre" /></td>
					<td>Autre&nbsp; </td>
					</tr>
			</table>
		 </td>
	  </tr>
      <tr> 
         <td align="left" class="txt1">Raison sociale *&nbsp;&nbsp;</td>
         <td><input style="width:90%" name="rs" id="rs" type="text" checked  Maxlength="30"/> </td>
    </tr>
    <tr> 
         <td align="left" class="txt1">Adresse *&nbsp;&nbsp;</td>
         <td><input style="width:90%" name="adresse" type="text" Maxlength="50"/></td>
    </tr>
    <tr> 
          <td align="left" class="txt1">Code Postal / BP *&nbsp;&nbsp;</td>
          <td><input style="width:90%" name="cp" type="text" Maxlength="5" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
    </tr>
     <tr>
	      <td align="left" class="txt1">Ville *&nbsp;&nbsp;</td>
          <td><input style="width:90%" name="ville" type="text" id="ville" Maxlength="30"/></td>
     </tr>
     <tr>
          <td align="left" class="txt1">Pays *</td>
          <td><input style="width:90%" name="pays" value="France" type="text" id="pays" Maxlength="30"/></td>
      </tr>
      <tr> 
      	   <td colspan="2">&nbsp;</td>
      </tr>
       <tr>
           <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
       </tr>
       <tr> 
            <td colspan="2">&nbsp;</td>
       </tr> 

       <tr> 
	      <td>Civilité</td>
		  <td>
					<table border="0" cellspacing="0" cellpadding="0" class="txt">
		   			<tr> 
						  <td> <input name="civilite" type="radio" value="Madame" checked></td>
			 			  <td>Mme&nbsp; </td>
						  <td><input type="radio" name="civilite" value="Mademoiselle"></td>
						  <td>Mlle&nbsp; </td>
						  <td><input type="radio" name="civilite" value="Monsieur"></td>
						  <td>Mr&nbsp; </td>
				 	</tr>
				   </table>
			</td>
		</tr>
        <tr> 
           <td align="left" class="txt1">Nom du responsable *&nbsp;&nbsp;</td>
           <td><input style="width:90%" name="responsable" type="text" Maxlength="30"/></td>
        </tr>
                  
         <tr> 
            <td align="left" class="txt1">Prénom du responsable *&nbsp;&nbsp;</td>
            <td><input style="width:90%" name="prenom_responsable" type="text" Maxlength="30"/></td>
          </tr>
          <tr> 
              <td align="left" class="txt1">Email *&nbsp;&nbsp;</td>
              <td><input style="width:90%" name="email" type="text" Maxlength="30"/></td>
          </tr>
          <tr> 
               <td align="left" class="txt1">Téléphone *&nbsp;&nbsp;</td>
               <td><input style="width:90%" name="tel" type="text" Maxlength="30" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
           </tr>
           <tr> 
               <td colspan="2">&nbsp;</td>
           </tr>
           <tr> 
               <td align="left" class="txt1">Titre de l'interview *&nbsp;&nbsp;</td>
               <td><input style="width:90%" name="titre_interview" type="text" Maxlength="100"/></td>
            </tr>
            <tr> 
               <td align="left" class="txt1">Date de l'interview *&nbsp;&nbsp;</td>
                <td><input style="width:90%" type="text" name="date_interview" value="<% Response.Write "" & FormatDateTime(Now, vbShortDate)%>"/></td>
            </tr>
            <tr> 
               <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
               <td colspan="2" width="670" align="center" valign="top">__________________________________________________</td>
            </tr>
</table>
           
<br/><br/> 
<center>
         <INPUT style="WIDTH: 153px; HEIGHT: 24px;color:blue;" type="submit" size="51" value="Suivant" id="submit1" name="submit1" />
</center>
                   
    
<br/><br/>
    
    
</form>
 

  <!--fin corps de texte-->
        
        
        
        <!--fin insertion  -->
        


 
<br />
<br />
<br />
<br />
<br />
<br />


<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>
<%end if%>