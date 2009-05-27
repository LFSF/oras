<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<title>Rhône-solidarité</title>

<script language="JavaScript" type="text/javascript">

function verifform()
{

// Vérifie si le nom est bien indiqué
 if(document.contact.NomMembre.value == "")
 {
  alert("\nMerci d'indiquer votre raison social.");
  document.contact.NomMembre.focus();
  return false;
 }
 
  //vérifie si le numéro de téléphone est bien indiqué
  if(document.contact.TelMembre.value == "")
 {
  alert("\nMerci d'indiquer votre téléphone.");
  document.contact.TelMembre.focus();
  return false;
 }
 
//vérifie si le mail est bien indiqué 
 if(document.contact.MailMembre.value == "")
 {
  alert("\nMerci d'indiquer votre mail.");
  document.contact.MailMembre.focus();
  return false;
 }

 
//vérifie qu'il s'agie bien d'un mail (présence de @ et . obligatoire) 
adresse_email = document.contact.MailMembre.value;
arobase = adresse_email.indexOf("@");
point = adresse_email.indexOf(".",arobase);
mauvais_endroit_point = arobase+1;
double_point = adresse_email.indexOf("..",arobase);
nbre_carac = adresse_email.length - point;
double_arobase = adresse_email.indexOf("@",arobase+1);
	
if ( (arobase < 1) ||  
	 (point <= mauvais_endroit_point) || 
	 (adresse_email.length < 5) || 
	 (double_point >= 0) ||
	 (nbre_carac < 3) ||
	 (double_arobase >= 0) )
	{
	alert ("\nL'adresse email est invalide.");
    document.contact.MailMembre.focus();
	return false;
	}

	
//vérifie que la vérification du mail est bien indiqué
 else if (document.contact.MailMembre2.value == "")
 {
 alert("\nMerci de confirmer votre mail.");
 document.contact.MailMembre2.focus();
 return false;
 }

 
//rentre le mail dans une variable 
 if(document.contact.MailMembre.value != "")
 {
 Mm1=document.contact.MailMembre.value;
 }

 
//rentre la confirmation du mail dans une variable 
 if(document.contact.MailMembre2.value !="")
 {
 Mm2=document.contact.MailMembre2.value;
 }
 
 
// compare les donnée du mail et de la confirmation
 if(Mm1 != Mm2)
 {
 alert ("\nVotre Mail de confirmation ne correspond pas au Mail inséré précédemment")
 document.contact.MailMembre2.focus();
 return false;
 }
 
 
//vérifie si le mdp est bien indiqué 
 if(document.contact.MdpMembre.value == "")
 {
  alert("\nMerci d'indiquer votre mot de passe.");
  document.contact.MdpMembre.focus();
  return false;
 }
 
 
 //vérifie la longueur du mot de passe 
 if(document.contact.MdpMembre.value.length<5)
 {
  alert("\nAttention le mot de passe doit avoir 5 caracteres minimum!");
  document.contact.MdpMembre.focus();
  return false;
 }
 
 
//vérifie si la confirmation est bien indiqué 
 else if (document.contact.MdpMembre2.value == "")
 {
 alert("\nMerci de confirmer votre mot de passe.");
 document.contact.MdpMembre2.focus();
 return false;
 }
 
 
//Met le mdp dans une variable   
 if(document.contact.MdpMembre.value != "")
 {
 pw1=document.contact.MdpMembre.value;
 }

//met la confirmation dans une variable
 if(document.contact.MdpMembre2.value !="")
 {
 pw2=document.contact.MdpMembre2.value;
 }

 
//compare les mdp 
 if(pw1 != pw2)
 {
 alert ("\nLe Mot de passe de confirmation ne correspond pas au \n mot de passe indiqué précédemment")
 document.contact.MdpMembre2.focus();
 return false;
 }
  

 
 //vérifie si l'adresse est bien indiquée
 if(document.contact.AdrMembre.value == "")
 {
  alert("\nMerci d'indiquer votre adresse.");
  document.contact.AdrMembre.focus();
  return false;
 }


 
 //vérifie si le code postal est bien indiqué
   if(document.contact.CPMembre.value == "")
 {
  alert("\nMerci d'indiquer votre code postal (99 si hors de france).");
  document.contact.CPMembre.focus();
  return false;
 }
 
//vérifie si la ville est bien indiquée
 if(document.contact.VilleMembre.value == "")
 {
  alert("\nMerci d'indiquer votre ville.");
  document.contact.VilleMembre.focus();
  return false;
 }

 
//vérifie si le Pays est bien indiqué  
 if(document.contact.PaysMembre.value == "")
 {
  alert("\nMerci d'indiquer votre pays .");
  document.contact.PaysMembre.focus();
  return false;
 }
 
 //vérifie si l'organisme est bien indiqué
 if(document.contact.OrganismeMembre.value =="")
 {
  alert("\nMerci d'indiquer ce que vous représentez \n entreprise, mairie, association,....");
  document.contact.OrganismeMembre.focus();
  return false;
 }
  
  
  //si le partenaire n'est pas check mais qu'une sous catégorie est check alors alerte
  if((document.contact.PartenaireMembre.checked == false) && ((document.contact.CooperationMembre.checked == true)
  || (document.contact.SolidaireMembre.checked == true) || (document.contact.FormationMembre.checked == true) || (document.contact.AutreMembre.checked == true)))
 {
  alert("\nMerci de cocher partenaire.");
  return false;
 }
 
 
 //si le partenaire est chek mais que rien d'autre n'est chek alors alerte pour demander de faire une séléction
   if((document.contact.PartenaireMembre.checked == true) && ((document.contact.CooperationMembre.checked == false)
  && (document.contact.SolidaireMembre.checked == false) && (document.contact.FormationMembre.checked == false) && (document.contact.AutreMembre.checked == false)))
 {
  alert("Vous avez cocher la case partenaire, \n merci de choisir le type de partenariat que vous souhaitez.");
  return false;
 }
}
</script>


<link href="styles.css" rel="stylesheet" type="text/css" />

<%  
            ' returns string the can be written where you would like the reCAPTCHA
            'challenged placed on your page
            function recaptcha_challenge_writer(publickey)
            recaptcha_challenge_writer = "<script type=""text/javascript"">" & _
            "var RecaptchaOptions = {" & _
            "   theme : 'white'," & _
            "   tabindex : 0" & _
            "};" & _
            "</script>" & _
            "<script type=""text/javascript"" src=""http://api.recaptcha.net/challenge?k=" & publickey & """></script>" & _
            "<noscript>" & _
              "<iframe src=""http://api.recaptcha.net/noscript?k=" & publickey &""" frameborder=""1""></iframe><br>" & _
                "<textarea name=""recaptcha_challenge_field"" rows=""3""cols=""40""></textarea>" & _
                "<input type=""hidden"" name=""recaptcha_response_field""value=""manual_challenge"">" & _
            "</noscript>" 

            end function

            function recaptcha_confirm(privkey,rechallenge,reresponse)
            ' Test the captcha field

            Dim VarString
            VarString = _
                    "privatekey=" & privkey & _
                    "&remoteip=" & Request.ServerVariables("REMOTE_ADDR") & _
                    "&challenge=" & rechallenge & _
                    "&response=" & reresponse

            Dim objXmlHttp
            Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
            objXmlHttp.open "POST", "http://api-verify.recaptcha.net/verify",False
            objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
            objXmlHttp.send VarString

            Dim ResponseString
            ResponseString = split(objXmlHttp.responseText, vblf)
            Set objXmlHttp = Nothing

            if ResponseString(0) = "true" then
              'They answered correctly
               recaptcha_confirm = ""
            else
              'They answered incorrectly
               recaptcha_confirm = ResponseString(1)
            end if

            end function

            %> 

</head>
<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">REJOIGNEZ NOUS!</div>

<table border="0px" width="100%" cellpadding="10px">

<tr>
<td colspan="2"><font color="#6FAA06">Adhésion organisme___________________________________________________________</font></td>
</tr>
</table>

<table width="583" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />

<!-- Formulaire d'adhésion -->

<form action="verif_p_adhesionO.asp" method="post" id="contact" name="contact" onsubmit="return verifform()">

<p><strong>Pour&nbsp; devenir PARTENAIRE ,&nbsp; Merci de renseigner le formulaire&nbsp; suivant :</strong><br /></p>

<table border="0" width="100%" cellpadding="0" cellspacing="0" class="txt">

<tr>
	<td width="30%" class="textes">Raison social *</td>
	<td><input name="NomMembre" class="txt" size="30" maxlength="40" /></td>
</tr>


<!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
<tr>
	<td class="textes">Téléphone *</td>
	<td><input name="TelMembre" class="txt" id="TelMembre" size="30" maxlength="14" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
</tr>



<tr>
	<td class="textes">Mail *</td>
	<td><input name="MailMembre" class="txt" id="MailMembre" size="30" maxlength="50" /></td>
</tr>	

<tr>
	<td class="textes">Confirmation Mail *</td>
	<td><input name="MailMembre2" class="txt" id="MailMembre2" size="30" maxlength="50" /></td>
</tr>

<!--
<tr>
	<td class="textes">Mot de passe *</td>
	<td><input type="password" name="MdpMembre" id="MdpMembre" class="txt" size="30" maxlength="50"/></td>
</tr>


<tr>
	<td class="textes">Confirmation Mdp *</td>
	<td><input type="password" name="MdpMembre2" class="txt" size="30" maxlength="50" /></td>
</tr>
-->
<tr>
	<td class="textes">Mot de passe *</td>
	<td><input type="password" name="MdpMembre" id="MdpMembre" class="txt" size="30" maxlength="50"/></td>
</tr>


<tr>
	<td class="textes">Confirmation Mdp *</td>
	<td><input type="password" name="MdpMembre2" class="txt" size="30" maxlength="50" /></td>
</tr>



<tr>
	<td class="textes">Siège social *</td>
	<td><input name="AdrMembre" class="txt" size="30" maxlength="50" /></td>
</tr>


<!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
<tr>
	<td class="textes">Code Postal / BP*</td>
	<td><input name="CPMembre" class="txt" size="30" maxlength="10" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"></td>
</tr>

<tr>
	<td class="textes">Ville *</td>
	<td><input name="VilleMembre" class="txt" size="30" maxlength="50" /></td>
</tr>


<tr>
	<td class="textes">Pays *</td>
	<td><input name="PaysMembre" class="txt" value="France" size="30" maxlength="40" /></td>
</tr>


<tr>
	<td class="textes">Type d'organisme *</td>
	<td><input name="OrganismeMembre" class="txt" size="30" maxlength="40" /></td>
</tr>


<tr>
	<td width="25%">&nbsp;</td>
	<td>&nbsp;</td>
</tr>


<tr>
	<td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
</tr>		


<tr>
	<td colspan="2">
	
	<!--
<table style="BACKGROUND-COLOR: #cacaff"  width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">
-->

	
<table style="border:1px solid #9AC0CD; "  width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">




<tr>
	<td colspan="2">Je souhaite devenir : Partenaire  &nbsp; <input  name="PartenaireMembre" type="checkbox" id="PartenaireMembre" /></td>
</tr>


<br /><br />


<tr>
	<td colspan="2" width="670" align="center" valign="center">&nbsp;&nbsp;</td>
</tr>				


<tr>
	<td colspan="2">Dans les domaines suivants:</td>
</tr>


<tr>
	<td colspan="2">La Cooperation décentralisée.</td>
	<td><input name="CooperationMembre" type="checkbox" id="CooperationMembre" /></td>
</tr>


<tr>
	<td colspan="2">Le Commerce solidaire.</td>
	<td><input name="SolidaireMembre" type="checkbox" id="SolidaireMembre" /></td>
</tr>


<tr>
	<td colspan="2">La Formation.</td>
	<td><input name="FormationMembre" type="checkbox" id="FormationMembre" /></td>
</tr>


<tr>
	<td colspan="2">Dans un Autre Domaine.</td>
	<td><input name="AutreMembre" type="checkbox" id="AutreMembre" /></td>
</tr>

</table>
  	

	
<tr>
	<td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>		  </tr>							   

	
<tr>
	<td width="5%" align="middle">&nbsp;</td>
	<td>&nbsp;</td>
</tr>


<tr>
	<td width="25%">&nbsp;</td>
	<td>&nbsp;</td>
</tr>


<tr>
	<td colspan="2">

	
<br />
	
	
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">


<tr>
	<td colspan="2">Je souhait m'inscrire a la Newsletter</td>

	<td><input name="News" type="checkbox" id="checkbox" /></td>

</tr>


<tr>

	<td colspan="2">Je souhaite écrire des articles dans votre pages actualités.&nbsp;</td>

	<td><input name="RedacteurMembre" type="checkbox" id="RedacteurMembre" /></td>

</tr>


<tr>
	<td colspan="2">Je souhaite faire connaître mon organisme via une Interview.&nbsp;</td>
	<td><input name="InterviewMembre" type="checkbox" id="InterviewMembre" /></td>
</tr>


<tr>
	<td colspan="2">Je souhaite créer un site Internet.&nbsp;</td>
	<td><input name="CreationsiteMembre" type="checkbox" id="CreationsiteMembre" /></td>
</tr>


<tr>	
	<td colspan="2">Autre&nbsp;</td>
	<td><input name="AutresMembre" type="checkbox" id="AutresMembre" /></td>
</tr>


	</td>
</tr>
</table>

<tr>
	<td colspan="2">&nbsp;</td>
</tr>

<tr>
	<td colspan="2">Message :</td>
</tr>

<tr>
	<td colspan="2">
		<textarea class="txt" id="MessageMembre" name="MessageMembre" rows="10" cols="60"></textarea>
	</td>
</tr>

<tr>
	<td colspan="2">&nbsp;</td>
</tr>

<tr>
	<td colspan="2">
	
	<%=recaptcha_challenge_writer("6LcESgUAAAAAAKdBFJM7JQQpKKpp6OnyJVHt9vyb")%>
	
<table width="100%" border="0" cellspacing="0" cellpadding="0">

<tr>

	<td width="50%" align="middle">
		<input name="reset1" type="reset" value="Effacer" id="reset1" width="109" height="16" border="0">
	</td>

	<td width="50%" align="middle">
			<input name="submit1" type="submit" value="Valider" id="submit1" width="109" height="16" border="0">
	</td>

</tr>
</table>

<p>&nbsp;</p>
<p>* (Obligatoire)</p>

</td>
</tr>
</table>
</form>
</div>
</td>
</tr>

</table>

<!-- Ne pas toucher à ce qui suit : placement du footer -->


  <!-- #include file="grand_footer.txt"-->  
</div>

</body>
</html>