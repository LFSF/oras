<?xml version="1.0" encoding="iso-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">
<head>
<!-- #include file="grand_meta.txt"-->
<!-- #include file="connexion.asp"-->
<title>Rhône-solidarité</title>

<script type="text/javascript" src="scripts/wysiwyg.js"></script>
<script type="text/javascript">
WYSIWYG.attach('all')
</script>

<script language="JavaScript" type="text/javascript">
//<![CDATA[
<!--
function verifform()
{
if(document.contact.nom.value == "")
 {
  alert("Merci d'indiquer votre nom.");
  document.contact.nom.focus();
  return false;
 }
  if(document.contact.prenom.value == "")
 {
  alert("Merci d'indiquer votre prenom.");
  document.contact.prenom.focus();
  return false;
 }
 
  if(document.contact.email.value == "")
 {
  alert("Merci d'indiquer votre adresse email.");
  document.contact.email.focus();
  return false;
 }
  
 //vérifie qu'il s'agie bien d'un mail (présence de @ et . obligatoire) 
adresse_email = document.contact.email.value;
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
    document.contact.email.focus();
	return false;
	}

	
 
 
 
  if(document.contact.telephone.value == "")
 {
  alert("Merci d'indiquer votre téléphone.");
  document.contact.telephone.focus();
  return false;
 }

 
 /*if (document.contact.message.value == "" || document.contact.message.value == "<br>")
 {
   alert("Veuillez saisir un message.");
   document.contact.message.focus();
   return false;
 }*/
 
}
//-->
//]]>
</script>


<%
	Civ = "madame"
if session("numMembre") <> "" then
set rsM = Conn.Execute("SELECT * FROM Membre WHERE NumMembre = " & session("numMembre") & "")
Nom =rsM("NomMembre")
Prenom =rsM("PrenomMembre")
Mail =rsM("MailMembre")
Tel =rsM("TelMembre")
end if

if (Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/verif_p_idees.asp") or (Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_idees.asp") then
	
	Civ = session("idee_civ")
	Nom = session("idee_nom")
	Prenom = session("idee_prenom")
	Mail = session("idee_mail")
	Tel = session("idee_telephone")
	Fonc = session("idee_fonction") 
	Org = session("idee_organisme")
end if
%>


<link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- #include file="FCKeditor/fckeditor.asp" -->
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">Idées Suggestions</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Idées Suggestions____________________________________________________________</font></td>
</tr>
</table>
<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />
<form action="verif_p_idees.asp" method="post" id="contact" name="contact" onsubmit="return verifform()">
<p><strong>Une idée? Une suggestions , Une critique ou un encouragement; n'hésitez pas à nous en faire part en remplissant le formulaire suivant!.  Attention l'email doit &ecirc;tre valide .</strong><br /></p>
<table border="0" width="100%" cellpadding="0" cellspacing="0" class="txt">
<tr>
<td>Civilité</td>
<td>
<table border="0" cellspacing="0" cellpadding="0" class="txt">
<tr>
	
<td><%
		if Civ ="madame" then 
			response.write ("<input name='civilite' type='radio' value='madame' checked='checked' />")
		else
			response.write ("<input name='civilite' type='radio' value='madame'/>")
		end if
	%>
</td>
<td>Mme&nbsp;</td>
<td><%
		if Civ ="mademoiselle" then 
			response.write ("<input name='civilite' type='radio' value='mademoiselle' checked='checked' />")
		else
			response.write ("<input name='civilite' type='radio' value='mademoiselle'/>")
		end if
	%>
</td>
<td>Mlle&nbsp;</td>
<td><%
		if Civ ="monsieur" then 
			response.write ("<input name='civilite' type='radio' value='monsieur' checked='checked' />")
		else
			response.write ("<input name='civilite' type='radio' value='monsieur'/>")
		end if
	%></td>
<td>Mr&nbsp;</td>
</tr>
</table>
</td>
</tr>
<tr>
<td width="30%" class="textes">Nom *</td>
<td><input name="nom" class="txt" size="30" maxlength="50" value="<%=Nom%>"/></td>
</tr>
<tr>
<td width="30%" class="textes">Prénom *</td>
<td><input name="prenom" class="txt" size="30" maxlength="50" value="<%=Prenom%>"/></td>
</tr>

<tr>
<td class="textes">Email *</td>
<td><input name="email" class="txt" id="email" size="30" maxlength="50" value="<%=Mail%>"/></td>
</tr>

<tr>
<td width="30%" class="textes">Fonction</td>
<td><input name="fonction" class="txt" size="30" maxlength="50" value="<%=Fonc%>" /></td>
</tr>
<tr>
<td class="textes">Association / Organisme*</td>
<td><input name="organisme" class="txt" size="30" maxlength="50" value="<%=Org%>" /></td>
</tr>




<tr>
<td class="textes">Téléphone* </td>
<td><input  name="telephone" class="txt" id="telephone" size="30" maxlength="50" value="<%=Tel%>" onKeypress="if((event.keyCode < 45 || event.keyCode > 57) && event.keyCode > 31 && event.keyCode != 43) event.returnValue = false; if((event.which < 45 || event.which > 57) && event.which > 31 && event.which != 43) return false;"/></td>
</tr>

<tr>
<td width="25%">&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td colspan="2">


<table width="100%" border="0" cellpadding="0" cellspacing="0" class="txt">

<tr>
<td>


</td>
</tr>

<tr>
<td width="5%" align="middle">&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td width="25%">&nbsp;</td>
<td>&nbsp;</td>
</tr>
<tr>
<td colspan="2"><br />
</td>
</tr>
<tr>
<td colspan="2">Message :</td>
</tr>
<%

	if (Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/verif_p_idees.asp") or (Request.ServerVariables("HTTP_REFERER")="http://www.rhone-solidarite.com/p_idees.asp") then
		response.write("<b><font color = red>Veuillez saisir votre id&eacute;e</font></br>")
	end if
%>
<tr>
<td colspan="2">
<textarea class="txt" id="message" name="message" rows="10" cols="60"></textarea></td>
</tr>
<tr>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
<td colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="50%" align="middle">	<input type="reset" value="Effacer" id="reset1" name="reset1" width="109" height="16" border="0">
		</td>
<td width="50%" align="middle">
			<input type="submit" value="Valider" id="submit1" name="submit1" width="109" height="16" border="0">
		</td>
</tr>
</table>
<p>&nbsp;</p>
<p>* (Obligatoire)</p>
</td>
</tr>
</table>

</td>
</tr>
</table>
</form>
</div>
</td>
</tr>
</table>
<!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>
</body>
</html>