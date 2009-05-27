


<table width="583" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />

<!-- Formulaire d'adhésion -->

<form action="test_verif_p_adhesionO.asp" method="post" id="contactO" name="contactO" onsubmit="return verifformO()">

<p><strong>Pour&nbsp; devenir PARTENAIRE ,&nbsp; Merci de renseigner le formulaire&nbsp; suivant :</strong><br /></p>

<table border="0" width="100%" cellpadding="0" cellspacing="0" class="txt">

<tr>
    <td width="30%" class="textes">Raison social *</td>
    <td><input name="NomMembre" class="txt" size="30" maxlength="40" /></td>
</tr>


<!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
<tr>
    <td class="textes"><% =Server.HtmlEncode("Téléphone *")%></td>
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
    <td class="textes"><% =Server.HtmlEncode("Siège social *")%></td>
    <td><input name="AdrMembre" class="txt" size="30" maxlength="50" /></td>
</tr>


<!--vérifie si les donnée inscrite sont bien des chiffres, keycode pour IE et which pour firefox-->
<tr>
    <td class="textes">Code Postal / BP*</td>
    <td><input name="CPMembre" class="txt" size="30" maxlength="10" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;" ></td>
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

    
<table width="80%" border="0" cellpadding="0" cellspacing="0" class="txt">




<tr>
    <td colspan="2">Je souhaite devenir : Partenaire  &nbsp; <input  name="PartenaireMembre" type="checkbox" id="PartenaireMembre" /></td>
</tr>

<tr>
    <td colspan="2" width="670" align="center" valign="center">&nbsp;&nbsp;</td>
</tr>               


<tr>
    <td colspan="2">Dans les domaines suivants:</td>
</tr>

<tr>
    <td colspan="2"><% =Server.HtmlEncode("La Cooperation décentralisée.")%></td>
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
    <td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>        </tr>                            

<tr>
    <td colspan="2">

    
<br />
    
    
<table width="80%" border="0" cellpadding="0" cellspacing="0" class="txt">


<tr>
    <td colspan="2">Je souhaite m'inscrire a la Newsletter</td>

    <td><input name="News" type="checkbox" id="checkbox" /></td>

</tr>


<tr>

    <td colspan="2"><% =Server.HtmlEncode("Je souhaite écrire des articles dans votre pages actualités.")%></td>

    <td><input name="RedacteurMembre" type="checkbox" id="RedacteurMembre" /></td>

</tr>


<tr>
    <td colspan="2"><% =Server.HtmlEncode("Je souhaite faire connaître mon organisme via une Interview.")%></td>
    <td><input name="InterviewMembre" type="checkbox" id="InterviewMembre" /></td>
</tr>


<tr>
    <td colspan="2"><% =Server.HtmlEncode("Je souhaite créer un site Internet.")%></td>
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
        <textarea class="txt" id="MessageMembre" name="MessageMembre" rows="8" cols="60"></textarea>
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
        <input name="reset1" type="reset" value="Effacer" id="reset2" width="109" height="16" border="0">
    </td>

    <td width="50%" align="middle">
            <input name="submit2" type="submit" value="Valider" id="submit2" width="109" height="16" border="0">
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