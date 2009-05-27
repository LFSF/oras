
<?xml version="1.0" encoding="iso-8859-1"?>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>RhÃ´ne-solidaritÃ©</title>

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

<script language="JavaScript" type="text/javascript">

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

<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if 
(win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} 
else 
{ document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

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
<script language="JavaScript">
function verifform()
{
 if(document.annonce.nom.value == "")
  {
   alert("Merci d'indiquer votre nom.");
   document.annonce.nom.focus();
   return false;
  }
 if(document.annonce.prenom.value == "")
  {
   alert("Merci d'indiquer votre prenom.");
   document.annonce.prenom.focus();
   return false;
  }
 if(document.annonce.adresse.value == "")
  {
   alert("Merci d'indiquer votre adresse.");
   document.annonce.adresse.focus();
   return false;
  }
   if(document.annonce.cp.value == "")
  {
   alert("Merci d'indiquer votre code postal (99 si hors de france).");
   document.annonce.cp.focus();
   return false;
  }
   if(document.annonce.ville.value == "")
  {
   alert("Merci d'indiquer votre ville.");
   document.annonce.ville.focus();
   return false;
  }
   if(document.annonce.email.value == "")
  {
   alert("Merci d'indiquer votre adresse email.");
   document.annonce.email.focus();
   return false;
  }
 adresse_email = document.annonce.email.value;
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
    document.annonce.email.focus();
	return false;
	}
    if(document.annonce.verif_email.value != document.annonce.email.value)
  {
   alert("la vérification de l'adress email est incorrect");
   document.annonce.verif_email.focus();
   return false;
  }
   if(document.annonce.tel.value == "")
  {
   alert("Merci d'indiquer votre téléphone.");
   document.annonce.tel.focus();
   return false;
  }
   if(document.annonce.sujet.value == "")
  {
   alert("Merci d'indiquer le sujet de l'annonce.");
   document.annonce.sujet.focus();
   return false;
  }
   if(document.annonce.creer_pass.value == "")
  {
   alert("Merci d'indiquer un mot de passe.");
   document.annonce.creer_pass.focus();
   return false;
  }
   if(document.annonce.verif_pass.value != document.annonce.creer_pass.value)
  {
   alert("la vérification du mot de passe est incorrect.");
   document.annonce.creer_pass.focus();
   return false;
  }
   if(document.annonce.votre_annonce.value == "")
  {
   alert("Merci d'indiquer votre annonce.");
   document.annonce.votre_annonce.focus();
   return false;
  }
  if(document.annonce.checkbox.checked == false && document.annonce.checkbox1.checked == false)
	{
	  		alert("Vous devez indiquer comment vous contacter.")
			/*document.annonce.votre_annonce.focus();*/
			return false;
	}
 }
 </script>
<script type="text/javascript" language="javascript" src="infobulle.js"></script>
</head>
<body>
<!-- #include file="grand_header.txt"-->
<div id="contenu"><!-- #include file="fichier_menu.txt"-->
<div id="bandeau_orange">DEPOSER UNE PETITE ANNONCE!</div>
<table border="0px" width="100%" cellpadding="10px">
<tr>
<td colspan="2"><font color="#6FAA06">Formulaire Annonce____________________________________________________________________</font></td>
</tr>
</table>

<!-- //
INSERTION  TABLE FORMULAIRE A MODIFIER
 // -->
<table width="583" border="0" cellspacing="0" cellpadding="0" align="center" 
valign="center" class="txt2">
<tr>
<td width="439" valign="top" class="txt">
<div align="justify"><br />

<form action="verif_petite_annonce.asp" method="post" name="petite_annonce" id="annonce" OnSubmit="return verifform()">
                <table width="500" border="0" cellpadding="0" cellspacing="0" class="txt">
                  <tr> 
                    <td><img src="../imgs/1x1.gif" width="165" height="1"></td>
                    <td>&nbsp;</td>
                  </tr>
                  <tr> 
                    <td>Civilité</td>
                    <td><table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr> 
                          <td> <input name="civilite" type="radio" value="madame" checked></td>
                          <td>Mme&nbsp; </td>
                          <td><input type="radio" name="civilite" value="mademoiselle"></td>
                          <td>Mlle&nbsp; </td>
                          <td><input type="radio" name="civilite" value="monsieur"></td>
                          <td>Mr&nbsp; </td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Nom *:</td>
                    <td><input style="width:90%" name="nom" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Prenom *:</td>
                    <td><input style="width:90%" name="prenom" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Adresse *:</td>
                    <td><input style="width:90%" name="adresse" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Code Postal *:</td>
					<td><input style="width:90%" onkeypress="return fonc2()" name="cp" type="text"></td>
				  <tr> 
                    <td class="txt1">Ville *:</td>
                    <td><input style="width:90%" name="ville" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Email *:</td>
                    <td><input style="width:90%" name="email" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Vérification d'Email *:</td>
                    <td><input style="width:90%" name="verif_email" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Téléphone *:</td>
                    <td><input style="width:90%" onkeypress="return fonc2()" name="tel" type="num"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Sujet *:</td>
                    <td><input style="width:90%" name="sujet" type="text"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Créer un mot de passe*:</td>
                    <td><input style="width:90%" name="creer_pass" type="num"></td>
                  </tr>
                  <tr> 
                    <td class="txt1">Vérification du mot de passe *:</td>
                    <td><input style="width:90%" name="verif_pass" type="text"></td>
                  </tr>				  
                  <tr> 
                    <td>Validité de l'annonce </td>
                    <td><table border="0" cellspacing="0" cellpadding="0" class="txt">
                        <tr>
                          <td>
								<select name="validite_annonce">
					
					<option value="7">1 semaine</option>
					<option value="15" selected>2 semaines</option>
					<option value="30">1 mois</option>
					<option value="60">2 mois</option>
					<option value="120">4 mois</option>
					<option value="180">6 mois</option>
					</select>
						  </td>
                        </tr>
                      </table></td>
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
                    <td valign="top">Votre Rubrique : <br>
					</td>
					<td>
					<select name="rubrique">
					
					<option value="Immobilier" selected>Immobilier</option>
					<option value="Auto/Moto">Auto/Moto</option>
					<option value="Scolaire">Scolaire</option>
					<option value="Animaux">Animaux</option>
					<option value="Services">Services</option>
					<option value="Braderie">Braderie</option>
					</select>
						</td>
                  </tr>
                    <td class="txt1">Intitulé *:</td>
                    <td><input style="width:90%" name="intitule" type="text"></td>
                  </tr>				  
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>				  
                  <tr> 
                    <td valign="top">Votre annonce *:<br>
					</td>
				  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>				  
				  <tr>
                    <td colspan="2" align="center"><textarea type="text" style="width:100%" name="votre_annonce" rows="10" maxlength="800"></textarea>
					<script language="javascript1.2">
var config = new Object();    // create new config object

config.width = "100%";
config.height = "150px";
config.bodyStyle = 'background-color: white; font-family: "Verdana"; font-size: x-small;';
config.debug = 0;

// NOTE:  You can remove any of these blocks and use the default config!

config.toolbar = [
    ['fontname'],
    ['fontsize'],
    //['fontstyle'],
    ['linebreak'],
    ['bold','italic','underline','separator'],
//  ['strikethrough','subscript','superscript','separator'],
    ['justifyleft','justifycenter','justifyright','separator'],
    ['OrderedList','UnOrderedList','Outdent','Indent','separator'],
    ['forecolor','backcolor','separator'],
    ['HorizontalRule','Createlink','InsertImage','htmlmode','separator'],
    ['about','help','popupeditor'],
];

config.fontnames = {
    "Arial":           "arial, helvetica, sans-serif",
    "Courier New":     "courier new, courier, mono",
    "Georgia":         "Georgia, Times New Roman, Times, Serif",
    "Tahoma":          "Tahoma, Arial, Helvetica, sans-serif",
    "Times New Roman": "times new roman, times, serif",
    "Verdana":         "Verdana, Arial, Helvetica, sans-serif",
    "impact":          "impact",
    "WingDings":       "WingDings"
};
config.fontsizes = {
    "1 (8 pt)":  "1",
    "2 (10 pt)": "2",
    "3 (12 pt)": "3",
    "4 (14 pt)": "4",
    "5 (18 pt)": "5",
    "6 (24 pt)": "6",
    "7 (36 pt)": "7"
  };

//config.stylesheet = "http://www.domain.com/sample.css";
  
//config.fontstyles = [   // make sure classNames are defined in the page the content is being display as well in or they won't work!
  //{ name: "headline",     className: "headline",  classStyle: "font-family: arial black, arial; font-size: 28px; letter-spacing: -2px;" },
  //{ name: "arial red",    className: "headline2", classStyle: "font-family: arial black, arial; font-size: 12px; letter-spacing: -2px; color:red" },
  //{ name: "verdana blue", className: "headline4", classStyle: "font-family: verdana; font-size: 18px; letter-spacing: -2px; color:blue" }

// leave classStyle blank if it's defined in config.stylesheet (above), like this:
//  { name: "verdana blue", className: "headline4", classStyle: "" }  
//];

editor_generate('votre_annonce',config);
</script>
					</td>
                  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>
                   <tr>
					<td class="textes">Joindre un fichier <font color=red>( < 2Mo)</font></td>
					<td><input type="file" name="joindre_fichier"></td>
				  </tr>
				  <tr>
					<td colspan="2" width="670" align="center" valign="center">__________________________________________________</td>
				  </tr>
				  <tr> 
                    <td colspan="2">&nbsp;</td>
                  </tr>	
                  <!--<tr> 
                    <td class="txt1">Comment vous joindre *:</td>
                    <tr> 
						<td width="150" class="txt1">Par téléphone :</td>
						<td width="150" class="txt1"><input type="checkbox" name="checkbox" value="telephone"></td>
					</tr>
					<tr> 
						<td width="150" class="txt1">Par email :</td>
						<td width="150" class="txt1"><input type="checkbox" name="checkbox1" value="mail" checked></td>
					</tr>
                  </tr>-->
                  <tr> 
                    <td align="center">
					  <INPUT TYPE="BUTTON" VALUE=" Retour "
               onClick="history.back()">					  
					</td>
                    <td align="center">
					<input name="valider" type="submit" value="     Valider     ">
					</td>					
                  </tr>
                </table>
			 </form></center>
	</td></tr><tr><td colspan="2">* (mention obligatoire)</td></tr></table>



 <!-- <table width="670" border="0" align="center" valign="center" class="txt">
	<tr>
		<td width="670" valign="bottom">_______________________________________________________________________________________________________________</td>
	</tr>
	<tr>
		<td valign="center">
		<MARQUEE behavior="scroll" valign="center" align="center" scrollamount="5" scrolldelay="10" onmouseover='this.stop()' onmouseout='this.start()'>
			<a href="#"
onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'img/1_120-200.jpg\' width=\'500\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="img/1_120-200.jpg" width="167" height="100" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"
onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'img/2_120-200.jpg\' width=\'500\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="img/2_120-200.jpg" width="167" height="100" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="#"
onmouseover="showTooltip('<div class=\'info\'><img id=\'big\' src=\'img/3_120-200.jpg\' width=\'500\'></div>');" 
onmouseout="hideTooltip()"><img id="big" src="img/3_120-200.jpg" width="167" height="100" onmouseout="hideTooltip()" /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</MARQUEE>
		</td>
	</tr>
</table> -->

 <!-- 
Ne pas toucher Ã  ce qui suit : placement du footer 
-->
<!-- #include file="grand_footer.txt"-->

</div>
</body>
</html>