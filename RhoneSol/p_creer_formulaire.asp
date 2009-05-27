<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
 "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />

<title>Rhône-solidarité</title>

<script language="JavaScript" type="text/javascript">

function verifform()
{

// Vérifie si le nom est bien indiqué
    if(document.contact.NomCrea.value == "")
 {
  alert("\nMerci d'indiquer votre nom.");
  document.contact.NomCrea.focus();
  return false;
 }
 
// Vérifie si le prénom est bien indiqué
    if(document.contact.PrenomCrea.value == "")
 {
  alert("\nMerci d'indiquer votre prenom.");
  document.contact.PrenomCrea.focus();
  return false;
 }
 
//vérifie si la société est bien indiqué 
    if(document.contact.SocieteCrea.value == "")
 {
  alert("\nMerci d'indiquer votre société.");
  document.contact.SocieteCrea.focus();
  return false;
 }
  
 //vérifie si l'adresse est bien indiqué 
     if(document.contact.AdrCrea.value == "")
 {
  alert("\nMerci d'indiquer votre Adresse.");
  document.contact.AdrCrea.focus();
  return false;
 }
 
 //vérifie si le code postal est bien indiqué 
    if(document.contact.CpCrea.value == "")
 {
  alert("\nMerci d'indiquer votre code postal (99 si hors de france).");
  document.contact.CpCrea.focus();
  return false;
 }
 
   //vérifie si la ville est bien indiqué 
    if(document.contact.VilleCrea.value == "")
 {
  alert("\nMerci d'indiquer votre ville.");
  document.contact.VilleCrea.focus();
  return false;
 }
 
   //vérifie si le mail est bien indiqué 
    if(document.contact.MailCrea.value == "")
 {
  alert("\nMerci d'indiquer votre mail.");
  document.contact.MailCrea.focus();
  return false;
 }

   //vérifie qu'il s'agie bien d'un mail (présence de @ et . obligatoire) 
adresse_email = document.contact.MailCrea.value;
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
     document.contact.MailCrea.focus();
     return false;
    }
    
   //vérifie que la vérification du mail est bien indiqué
    else if (document.contact.MailCrea2.value == "")
 {
  alert("\nMerci de confirmer votre mail.");
  document.contact.MailCrea2.focus();
  return false;
 }

   //rentre le mail dans une variable 
    if(document.contact.MailCrea.value != "")
 {
  Mm1=document.contact.MailCrea.value;
 }
 
//rentre la confirmation du mail dans une variable 
    if(document.contact.MailCrea2.value !="")
 {
  Mm2=document.contact.MailCrea2.value;
 }
  
// compare les donnée du mail et de la confirmation
    if(Mm1 != Mm2)
 {
  alert ("\nVotre Mail de confirmation ne correspond pas au Mail inséré précédemment")
  document.contact.MailCrea2.focus();
  return false;
 }

//vérifie si le numéro de téléphone est bien indiqué
    if(document.contact.FixeCrea.value == "")
 {
  alert("\nMerci d'indiquer votre téléphone.");
  document.contact.FixeCrea.focus();
  return false;
 }
 
//vérifie si le portable est bien indiqué
        if(document.contact.PortableCrea.value == "")
 {
  alert("\nMerci d'indiquer votre téléphone portable.");
  document.contact.PortableCrea.focus();
  return false;
 }
 
//vérifie si le projet est bien indiqué
    if(document.contact.ProjetCrea.value == "1")
 {
  alert("\nMerci de choisir le type de projet que vous souhaitez")
  document.contact.ProjetCrea.focus();
  return false; 
 }

//vérifie si la demande est bien complétée
    if(document.contact.DemandeCrea.value == "")
 {  
  alert("\nMerci de préciser votre demande.")
  document.contact.DemandeCrea.focus();
  return false;
 }

//vérifie si le budget est bien indiqué
    if(document.contact.BudgetCrea.value == "")
 {  
  alert("\nMerci d'indiquer votre budget.")
  document.contact.BudgetCrea.focus();
  return false;
 }
  
 
 
}
</script>

<link href="styles.css" rel="stylesheet" type="text/css" />

</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">CREEZ VOTRE SITE INTERNET</div>

<table border="0px" width="100%" cellpadding="10px">
    <tr>
        <td colspan="2"><a class=lien href="p_creer.asp">
                           <font size=1><b><< Retour </b></font>
                        </a>
        </td>
    </tr>
    <tr>
        <td colspan="2"><font color="#6FAA06"><%=Server.HtmlEncode("Créez votre site____________________________________________________________________")%></font>
        </td>
    </tr>
</table>


<table width="583" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td width="439" valign="top" class="txt">
            <div align="justify"><br />

<!-- Formulaire d'adhésion -->


<form action="verif_p_creer.asp" method="post" id="contact" name="contact" onsubmit="return verifform()">
    <p>
        <strong>
            &nbsp;Merci de renseigner le formulaire&nbsp; suivant :
        </strong>           <br />
    </p>
    
<table border="0" width="100%" cellpadding="0" cellspacing="0" class="txt">

    <tr>
        <td>Civilité</td>
        <td>

<table border="0" cellspacing="0" cellpadding="0" class="txt">
    <tr>
        <td><input name="CivCrea" type="radio" value="madame" checked="checked" /></td>
        <td>Mme&nbsp;</td>
        <td><input type="radio" name="CivCrea" value="mademoiselle" /></td>
        <td>Mlle&nbsp;</td>
        <td><input type="radio" name="CivCrea" value="monsieur" /></td>
        <td>M&nbsp;</td>
    </tr>
</table>
    
        </td>
    </tr>


    <tr>
        <td width="30%" class="textes">Nom *</td>
        <td><input name="NomCrea" class="txt" size="30" maxlength="40" /></td>
    </tr>

    <tr>
        <td width="30%" class="textes">Prénom *</td>
        <td><input name="PrenomCrea" class="txt" size="30" maxlength="40" /></td>
    </tr>

    <tr>
        <td width="30%" class="textes">Fonction </td>
        <td><input name="FonctionCrea" class="txt" size="30" maxlength="40" /></td>
    </tr>

    <tr>
        <td width="30%" class="textes">Société </td>
        <td><input name="SocieteCrea" class="txt" size="30" maxlength="40" /></td>
    </tr>

    <tr>
        <td class="textes">Adresse *</td>
        <td><input name="AdrCrea" class="txt" size="30" maxlength="50" /></td>
    </tr>

    <tr>    
        <td class="textes">
            Code Postal / BP*
        </td>
        
        <td>
            <input name="CpCrea" class="txt" size="30" maxlength="10" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;">
        </td>
    
    </tr>


    <tr>
        <td class="textes">
            Ville *
        </td>
        
        <td>
            <input name="VilleCrea" class="txt" size="30" maxlength="50" />
        </td>
    </tr>


    <tr>
        <td class="textes">
            Mail *
        </td>
        
        <td>
            <input name="MailCrea" class="txt" id="MailCrea" size="30" maxlength="50" />
        </td>
    </tr>   


    <tr>
        <td class="textes">
            Confirmation Mail *
        </td>
        
        <td>
            <input name="MailCrea2" class="txt" id="MailCrea2" size="30" maxlength="50" />
        </td>
    </tr>


    <tr>
        <td class="textes">
            Téléphone *
        </td>
        
        <td>
            <input name="FixeCrea" class="txt" id="FixeCrea" size="30" maxlength="14" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/>
        </td>
    
    </tr>


    <tr>
        <td class="textes">
            Tel. portable *
        </td>
        
        <td>
            <input name="PortableCrea" class="txt" id="TelPPMembre" size="30" maxlength="14" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/>
        </td>
    </tr>


    <tr>
        <td width="30%" class="txt1">
            <strong>
                Votre projet*
            </strong> 
        </td>
        <td>
            <select name="ProjetCrea" size="1">
                <option value="1"></option>
                <option value="site html" name="ProjetCrea" id="ProjetCrea">&nbsp;Un site HTML&nbsp;</option>
                <option value="site avec SGBD" name="ProjetCrea" id="ProjetCrea">&nbsp;Un site avec base de données&nbsp;</option>
                <option value="boutique en ligne" name="ProjetCrea" id="ProjetCrea">&nbsp;Une boutique avec module paiement&nbsp;</option>
                <option value="refonte de site" name="ProjetCrea" id="ProjetCrea">&nbsp;Refonte d'un site&nbsp;</option>
                <option value="autre projet" name="ProjetCrea" id="ProjetCrea">&nbsp;Autre projet&nbsp;</option>
            </select>
        </td>
    
    </tr>
    
    
    <tr>
        <td>&nbsp;
            
        </td>
    </tr>
    
    
    <tr>
        <td colspan="2">
            Précisez votre demande * :
        </td>
    </tr>
    
    
<!--attention de ne jamais mettre d'espace entre <textarea></textarea>, sinon le javascript de vérification ne fonctionnera pas-->
    <tr>
        <td colspan="2">
            <textarea class="txt" id="DemandeCrea" name="DemandeCrea" rows="10" cols="60"></textarea>
        </td>
    </tr>


    <tr>
        <td>&nbsp;
            
        </td>
    </tr>
    
    
    
    <tr>
        <td class="textes">
            Estimation de votre budget :
        </td>
        
        <td>
            <input name="BudgetCrea" class="txt" id="TelPPMembre" size="30" maxlength="14" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/> <strong>€</strong>
        </td>
    </tr>
    
 
    
    <tr>
        <td class="textes">
            Délai souhaité :
        </td>
        
        <td>
            <input name="DelaiCrea" class="txt" size="30" maxlength="50" />
        </td>
    </tr>

    
    <tr>
        <td>&nbsp;
            
        </td>
    </tr>
    
    
    <tr>
        <td colspan="2">
            Commentaires :
        </td>
    </tr>
    
    
<!--attention de ne jamais mettre d'espace entre <textarea></textarea>, sinon le javascript de vérification ne fonctionnera pas-->
    <tr>
        <td colspan="2">
            <textarea class="txt" id="CommentCrea" name="CommentCrea" rows="10" cols="60"></textarea>
        </td>
    </tr>


    <tr>
        <td>&nbsp;
            
        </td>
    </tr>
    
        <tr>
        <td>&nbsp;
            
        </td>
    </tr>
    
    <tr>
        <td>






        <p>&nbsp;</p>
        <p>* (Obligatoire)</p>


        </td>
    </tr>
</table>
            
<center><input name="reset1" type="reset" value="Effacer" id="reset1" width="109" height="16" border="0">
            
<input name="submit1" type="submit" value="Valider" id="submit" width="109" height="16" border="0"></center>
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