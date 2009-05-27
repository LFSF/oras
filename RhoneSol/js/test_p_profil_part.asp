<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
<title>Rhône-solidarité</title>
<!-- #include file="connexion.asp"-->
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
  if(document.contact.TelProfil.value == "")
 {
  alert("\nMerci d'indiquer votre téléphone.");
  document.contact.TelProfil.focus();
  return false;
 }
 
//vérifie si le mail est bien indiqué 
 //if(document.contact.MailProfil.value == "")
// {
//  alert("\nMerci d'indiquer votre mail.");
/*  document.contact.MailProfil.focus();
  return false;
 }*/

 
//vérifie qu'il s'agie bien d'un mail (présence de @ et . obligatoire) 
/*adresse_email = document.contact.MailProfil.value;
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
    document.contact.MailProfil.focus();
    return false;
    }*/

    
//vérifie que la vérification du mail est bien indiqué
 /*else if (document.contact.MailProfil2.value == "")
 {
 alert("\nMerci de confirmer votre mail.");
 document.contact.MailProfil2.focus();
 return false;
 }*/

 
//rentre le mail dans une variable 
/* if(document.contact.MailProfil.value != "")
 {
 Mm1=document.contact.MailProfil.value;
 }

 
//rentre la confirmation du mail dans une variable 
 if(document.contact.MailProfil2.value !="")
 {
 Mm2=document.contact.MailProfil2.value;
 }
 
 
// compare les donnée du mail et de la confirmation
 if(Mm1 != Mm2)
 {
 alert ("\nVotre Mail de confirmation ne correspond pas au Mail inséré précédemment")
 document.contact.MailProfil2.focus();
 return false;
 }*/
 
 
//vérifie si le mdp est bien indiqué 
 if(document.contact.MdpProfil.value == "")
 {
  alert("\nMerci d'indiquer votre mot de passe.");
  document.contact.MdpProfil.focus();
  return false;
 }
 
 
 //vérifie la longueur du mot de passe 
 if(document.contact.MdpProfil.value.length<5)
 {
  alert("\nAttention le mot de passe doit avoir 5 caracteres minimum!");
  document.contact.MdpProfil.focus();
  return false;
 }
 
 
//vérifie si une nouveau de passe a été saisi
 if (document.contact.MdpProfil2.value != "" )
 {
      pw1=document.contact.MdpProfil2.value;
      //verifie sa longueur minimale
      if(document.contact.MdpProfil2.value.length<5)
	  {
	   alert("\nAttention le nouveau mot de passe doit avoir 5 caracteres minimum!");
	   return false;
	  }

     //Verifie si la confirmation du mot de passe a été saisi
     if(document.contact.MdpProfil2bis.value != "" )
	 {
           alert("\nMerci de confirmer votre nouveau mot de passe.");
		   document.contact.MdpProfil2bis.focus();
		   return false;
	 }
	 else
	 {
	       pw2=document.contact.MdpProfil2bis.value;
	 }
	 
	 
	 //Verifie que le nouveau mdp et sa confirmation sont identiques
	 else if (document.contact.MdpProfil2.value != document.contact.MdpProfil2bis.value)
	 {
	       alert("\nConfirmation du nouveau mot de passe incorrect.");
		   document.contact.MdpProfil2bis.focus();
		   return false;
	 }
	 
 }
 
//compare les mdp 
 if(pw1 != pw2)
 {
 alert ("\nLe Mot de passe de confirmation ne correspond pas au \n mot de passe indiqué précédemment")
 document.contact.MdpProfil2bis.focus();
 return false;
 }
  
 
 //vérifie si l'adresse est bien indiquée
 if(document.contact.AdrProfil.value == "")
 {
  alert("\nMerci d'indiquer votre adresse.");
  document.contact.AdrProfil.focus();
  return false;
 }


 
 //vérifie si le code postal est bien indiqué
   if(document.contact.CPProfil.value == "")
 {
  alert("\nMerci d'indiquer votre code postal (99 si hors de france).");
  document.contact.CPProfil.focus();
  return false;
 }
 
//vérifie si la ville est bien indiquée
 if(document.contact.VilleProfil.value == "")
 {
  alert("\nMerci d'indiquer votre ville.");
  document.contact.VilleProfil.focus();
  return false;
 }

 
//vérifie si le Pays est bien indiqué  
 if(document.contact.PaysProfil.value == "")
 {
  alert("\nMerci d'indiquer votre pays .");
  document.contact.PaysProfil.focus();
  return false;
 }
 
 //vérifie si l'organisme est bien indiqué
 if(document.contact.OrganismeProfil.value =="")
 {
  alert("\nMerci d'indiquer ce que vous représentez \n entreprise, mairie, association,....");
  document.contact.OrganismeProfil.focus();
  return false;
 }
  
  
  //si le partenaire n'est pas check mais qu'une sous catégorie est check alors alerte
  if((document.contact.PartenaireProfil.checked == false) && ((document.contact.CooperationProfil.checked == true)
  || (document.contact.SolidaireProfil.checked == true) || (document.contact.FormationProfil.checked == true) || (document.contact.AutreProfil.checked == true)))
 {
  alert("\nMerci de cocher partenaire.");
  return false;
 }
 
 
 //si le partenaire est chek mais que rien d'autre n'est chek alors alerte pour demander de faire une séléction
   if((document.contact.PartenaireProfil.checked == true) && ((document.contact.CooperationProfil.checked == false)
  && (document.contact.SolidaireProfil.checked == false) && (document.contact.FormationProfil.checked == false) && (document.contact.AutreProfil.checked == false)))
 {
  alert("Vous avez cocher la case partenaire, \n merci de choisir le type de partenariat que vous souhaitez.");
  return false;
 }
}
</script>


<link href="styles.css" rel="stylesheet" type="text/css" />

</head>
<body>

<%
Set rsProfil = conn.Execute("SELECT * FROM MEMBRE WHERE NumMembre = " & session("admin_id"))
%>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->
<div id="bandeau_menu"><!--#include file ="menu_deroulant.txt" --></div>

    <!--<div id="bandeau_orange">Votre profil</div>-->
    <table border="0px" width="100%" cellpadding="10px">
        <tr><td><b><a href="p_admin.asp" title="Retour"> << Retour </a></b></td></tr>
        <tr>
            <td colspan="2"><font color="#6FAA06">Modification de votre profil___________________________________________________________</font></td>
        </tr>
    </table>

    <table width="583" border="0" cellspacing="0" cellpadding="0">
        <tr>
            <td width="439" valign="top" class="txt">
                <div align="justify"><br/>

<!-- Formulaire d'adhésion -->

                    <form action="test_valider_profil_modif.asp" method="post" id="profil" name="profil" onsubmit="return verifform()">

                        <table border="0" width="100%" cellpadding="2" cellspacing="0" class="txt">
                            <tr>
                                <td class="textes">Civilité</td>
                                <td><%=rsProfil("CivMembre")%></td>
                            </tr>
                            <tr>
                                <td class="textes">Nom</td>
                                <td><%=rsProfil("NomMembre")%></td>
                            </tr>
                            <tr>
                                <td class="textes">Prénom</td>
                                <td><%=rsProfil("PrenomMembre")%></td>
                            </tr>
                            <tr>
                                <td class="textes">Age</td>
                                <td><input value="<%=rsProfil("AgeMembre")%>" name="AgeProfil" class="txt" id="AgeProfil" size="30" maxlength="2" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;" /></td>
                            </tr>

<!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->

                            <tr>
                                <td class="textes">Téléphone *</td>
                                <td><input value="<%=rsProfil("TelMembre")%>" name="TelProfil" class="txt" id="TelProfil" size="30" maxlength="14" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
                            </tr>
                            <tr>
                                <td class="textes">Mail *</td>
                                <td><%=rsProfil("MailMembre")%></td>
                            </tr>
                            <!--<tr>
                                <td class="textes">Confirmation Mail *</td>
                                <td><input name="MailProfil2" class="txt" id="MailProfil2" size="30" maxlength="50" /></td>
                            </tr>
                            <tr>-->
                                <td class="textes"> Mot de passe *</td>
                                <td><input value="<%=rsProfil("MdpMembre")%>" type="password" name="MdpProfil" id="MdpProfil" class="txt" size="30" maxlength="50"/></td>
                            </tr>
                            <tr>
                                <td class="textes">Nouveau Mot de passe </td>
                                <td><input type="password" name="MdpProfil2" id="MdpProfil2" class="txt" size="30" maxlength="50"/></td>
                            </tr>
                            <tr>
                                <td class="textes">Confirmation nouveau Mot de passe </td>
                                <td><input type="password" name="MdpProfil2bis" class="txt" size="30" maxlength="50" /></td>
                            </tr>
                            <tr>
                                <td class="textes">Adresse </td>
                                <td><input value="<%=rsProfil("AdrMembre")%>" name="AdrProfil" id="AdrProfil" class="txt" size="30" maxlength="50" /></td>
                            </tr>

<!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->

                            <tr>
                                <td class="textes">Code Postal / BP</td>
                                <td><input value="<%=rsProfil("CPMembre")%>" name="CPProfil" id="CPProfil" class="txt" size="30" maxlength="10"></td>
                            </tr>
                            <tr>
                                <td class="textes">Ville </td>
                                <td><input value="<%=rsProfil("VilleMembre")%>" name="VilleProfil" id="VilleProfil" class="txt" size="30" maxlength="50" /></td>
                            </tr>
                            <tr>
                                <td class="textes">Pays </td>
                                <td><input value="<%=rsProfil("PaysMembre")%>" name="PaysProfil" id="PaysProfil" class="txt" size="30" maxlength="40" /></td>
                            </tr>
                            <tr>
                                <td class="textes">Fonction </td>
                                <td><input value="<%=rsProfil("FonctionMembre")%>" name="FonctionProfil" id="FonctionProfil" class="txt" size="30" maxlength="40" /></td>
                            </tr>
                            <tr>
                                <td class="textes">Association / Organisme</td>
                                <td><input value="<%=rsProfil("OrganismeMembre")%>" name="OrganismeProfil" id="OrganismeProfil" class="txt" size="30" maxlength="40" /></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table style="BACKGROUND-COLOR: #cacaff"  width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">
                                        <tr>
                                            <td colspan="2">Je souhaite devenir : Partenaire  &nbsp; 
                                                <%if rsProfil("PartenaireMembre")="oui" Then%>
                                                    <input  name="PartenaireProfil" value="oui" type="checkbox" id="PartenaireProfil" checked />
                                                <%Else%>
                                                    <input  name="PartenaireProfil" value="oui" type="checkbox" id="PartenaireProfil" />
                                                <%End if%>
                                            </td>
                                        </tr>
                                        <br/><br/>
                                        <tr>
                                            <td colspan="2" width="670" align="center" valign="center">&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;&nbsp;Dans les domaines suivants:</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">La Cooperation décentralisée.</td>
                                            <td>
                                                <%if rsProfil("CooperationMembre")="oui" Then%>
                                                    <input name="CooperationProfil" value="oui" type="checkbox" id="CooperationProfil" checked />
                                                <%Else%>
                                                    <input name="CooperationProfil" value="oui" type="checkbox" id="CooperationProfil" />
                                                <%End if%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">Le Commerce solidaire.</td>
                                            <td>
                                                <%if rsProfil("SolidaireMembre")="oui" Then%>
                                                    <input name="SolidaireProfil" value="oui" type="checkbox" id="SolidaireProfil" checked />
                                                <%Else%>
                                                    <input name="SolidaireProfil" value="oui" type="checkbox" id="SolidaireProfil" />
                                                <%End if%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">La Formation.</td>
                                            <td>
                                                <%if rsProfil("FormationMembre")="oui" Then%>
                                                    <input name="FormationProfil" value="oui" type="checkbox" id="FormationProfil" checked />
                                                <%Else%>
                                                    <input name="FormationProfil" value="oui" type="checkbox" id="FormationProfil" />
                                                <%End if%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">Dans un Autre Domaine.</td>
                                            <td>
                                                <%if rsProfil("AutreMembre")="oui" Then%>
                                                    <input name="AutreProfil" value="oui" type="checkbox" id="AutreProfil" checked />
                                                <%Else%>
                                                    <input name="AutreProfil" value="oui" type="checkbox" id="AutreProfil" />
                                                <%End if%>
                                            </td>
                                        </tr>
                                    </table>
                                        <tr>
                                            <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>        </tr>                            
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

                                                <br/>

                                                <table width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">
                                                    <tr>
                                                        <td colspan="2">Je souhaite m'inscrire a la Newsletter</td>
                                                        <td>
                                                            <%if rsProfil("News")="oui" Then%>
                                                                <input name="NewsProfil" value="oui" type="checkbox" id="NewsProfil" checked />
                                                            <%Else%>
                                                                <input name="NewsProfil" value="oui" type="checkbox" id="NewsProfil" />
                                                            <%End if%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">Je souhaite écrire des articles dans votre pages actualités.&nbsp;</td>
                                                        <td>
                                                            <%if rsProfil("RedacteurMembre")="oui" Then%>
                                                                <input name="RedacteurProfil" value="oui" type="checkbox" id="RedacteurProfil" checked />
                                                            <%Else%>
                                                                <input name="RedacteurProfil" value="oui" type="checkbox" id="RedacteurProfil" />
                                                            <%End if%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">Je souhaite faire connaître mon organisme via une Interview.&nbsp;</td>
                                                        <td>
                                                            <%if rsProfil("InterviewMembre")="oui" Then%>
                                                                <input name="InterviewProfil" value="oui" type="checkbox" id="InterviewProfil" checked />
                                                            <%Else%>
                                                                <input name="InterviewProfil" value="oui" type="checkbox" id="InterviewProfil" />
                                                            <%End if%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">Je souhaite créer un site Internet.&nbsp;</td>
                                                        <td>
                                                            <%if rsProfil("CreationsiteMembre")="oui" Then%>
                                                                <input name="CreationsiteProfil" value="oui" type="checkbox" id="CreationsiteProfil" checked />
                                                            <%Else%>
                                                                <input name="CreationsiteProfil" value="oui" type="checkbox" id="CreationsiteProfil" />
                                                            <%End if%>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">Autre&nbsp;</td>
                                                        <td>
                                                            <%if rsProfil("AutresMembre")="oui" Then%>
                                                                <input name="AutresProfil" value="oui" type="checkbox" id="AutresProfil" checked />
                                                            <%Else%>
                                                                <input name="AutresProfil" value="oui" type="checkbox" id="AutresProfil" />
                                                            <%End if%>
                                                        </td>
                                                    </tr>
                                                </table>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">

                                                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                    <tr>
                                                        <td width="50%" align="middle">
                                                                <input name="submit1" type="submit" value="Valider" id="submit1" width="109" height="16" border="0">
                                                        </td>
                                                    </tr>
                                                </table>

                                                <p>&nbsp;</p>
                                                <p>* (Obligatoire)</p>
                                            </td>
                                        </tr>
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
<!-- #include file="deconnexion.asp"-->
</body>
</html>