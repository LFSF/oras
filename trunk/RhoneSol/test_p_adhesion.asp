<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	http = Request.ServerVariables("HTTP_REFERER")
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<!-- #include file="grand_meta.txt"-->
<title>Rh&ocirc;ne-solidarit&eacute;</title>
<link href="styles.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
  <!--
  function multiClass(eltId) {
    arrLinkId = new Array('_0','_1');
    intNbLinkElt = new Number(arrLinkId.length);
    arrClassLink = new Array('current','ghost');
    strContent = new String()
    for (i=0; i<intNbLinkElt; i++) {
      strContent = "menuonglet"+arrLinkId[i];
      if ( arrLinkId[i] == eltId ) {
        document.getElementById(arrLinkId[i]).className = arrClassLink[0];
        document.getElementById(strContent).className = 'on content';
		<%
		Session.Abandon
		Session("Type") = "P"
		%>
      } else {
        document.getElementById(arrLinkId[i]).className = arrClassLink[1];
        document.getElementById(strContent).className = 'off content';
		<%
		Session.Abandon
		Session("Type") = "O"
		%>
      }
    }
  }
  -->
</script>
<script language="JavaScript" type="text/javascript">

function test_forward()
{
	<%	
	if Session("Type") = "O" then
	%>
		multiClass('_1');
	<%
	else
	%>
		alert("Blabla pas de Type : <%=Session("Type")%>")
	<%
	end if
	%>
}
</script>
<script language="JavaScript" type="text/javascript">

function test_id()
{
	if (document.getElementById("menuonglet_0").className = 'on content')
	{
		<% Session("Type") = "P"%>
	}
	else
	{
		<% Session("Type") = "O"%>
	}
}
</script>

<script language="JavaScript" type="text/javascript">

function verifformP()
{

// Vérifie si le nom est bien indiqué
 if(document.contact.NomMembre.value == "")
 {
  alert("\nMerci d'indiquer votre nom." + document.contact.NomMembre.value);
  document.contact.NomMembre.focus();
  return false;
 }

 
// Vérifie si le prénom est bien indiqué
  if(document.contact.PreNomMembre.value == "")
 {
  alert("\nMerci d'indiquer votre prenom.");
  document.contact.PreNomMembre.focus();
  return false;
 }
 
 
//vérifie si l'âge est bien indiqué 
 if(document.contact.AgeMembre.value == "")
 {
  alert("\nMerci d'indiquer votre age.");
  document.contact.AgeMembre.focus();
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
 
 return true;
}
</script>

<script language="JavaScript" type="text/javascript">

function verifformO()
{

// Vérifie si le nom est bien indiqué
 if(document.contactO.NomMembre.value == "")
 {
  alert("\nMerci d'indiquer votre raison social.");
  document.contactO.NomMembre.focus();
  return false;
 }
 
  //vérifie si le numéro de téléphone est bien indiqué
  if(document.contactO.TelMembre.value == "")
 {
  alert("\nMerci d'indiquer votre téléphone.");
  document.contactO.TelMembre.focus();
  return false;
 }
 
//vérifie si le mail est bien indiqué 
 if(document.contactO.MailMembre.value == "")
 {
  alert("\nMerci d'indiquer votre mail.");
  document.contactO.MailMembre.focus();
  return false;
 }

 
//vérifie qu'il s'agie bien d'un mail (présence de @ et . obligatoire) 
adresse_email = document.contactO.MailMembre.value;
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
    document.contactO.MailMembre.focus();
    return false;
    }

    
//vérifie que la vérification du mail est bien indiqué
 else if (document.contactO.MailMembre2.value == "")
 {
 alert("\nMerci de confirmer votre mail.");
 document.contactO.MailMembre2.focus();
 return false;
 }

 
//rentre le mail dans une variable 
 if(document.contactO.MailMembre.value != "")
 {
 Mm1=document.contactO.MailMembre.value;
 }

 
//rentre la confirmation du mail dans une variable 
 if(document.contactO.MailMembre2.value !="")
 {
 Mm2=document.contactO.MailMembre2.value;
 }
 
 
// compare les donnée du mail et de la confirmation
 if(Mm1 != Mm2)
 {
 alert ("\nVotre Mail de confirmation ne correspond pas au Mail inséré précédemment")
 document.contactO.MailMembre2.focus();
 return false;
 }
 
 
//vérifie si le mdp est bien indiqué 
 if(document.contactO.MdpMembre.value == "")
 {
  alert("\nMerci d'indiquer votre mot de passe.");
  document.contactO.MdpMembre.focus();
  return false;
 }
 
 
 //vérifie la longueur du mot de passe 
 if(document.contactO.MdpMembre.value.length<5)
 {
  alert("\nAttention le mot de passe doit avoir 5 caracteres minimum!");
  document.contactO.MdpMembre.focus();
  return false;
 }
 
 
//vérifie si la confirmation est bien indiqué 
 else if (document.contactO.MdpMembre2.value == "")
 {
 alert("\nMerci de confirmer votre mot de passe.");
 document.contactO.MdpMembre2.focus();
 return false;
 }
 
 
//Met le mdp dans une variable   
 if(document.contactO.MdpMembre.value != "")
 {
 pw1=document.contactO.MdpMembre.value;
 }

//met la confirmation dans une variable
 if(document.contactO.MdpMembre2.value !="")
 {
 pw2=document.contactO.MdpMembre2.value;
 }

 
//compare les mdp 
 if(pw1 != pw2)
 {
 alert ("\nLe Mot de passe de confirmation ne correspond pas au \n mot de passe indiqué précédemment")
 document.contactO.MdpMembre2.focus();
 return false;
 }
  

 
 //vérifie si l'adresse est bien indiquée
 if(document.contactO.AdrMembre.value == "")
 {
  alert("\nMerci d'indiquer votre adresse.");
  document.contactO.AdrMembre.focus();
  return false;
 }


 
 //vérifie si le code postal est bien indiqué
   if(document.contactO.CPMembre.value == "")
 {
  alert("\nMerci d'indiquer votre code postal (99 si hors de france).");
  document.contactO.CPMembre.focus();
  return false;
 }
 
//vérifie si la ville est bien indiquée
 if(document.contactO.VilleMembre.value == "")
 {
  alert("\nMerci d'indiquer votre ville.");
  document.contactO.VilleMembre.focus();
  return false;
 }

 
//vérifie si le Pays est bien indiqué  
 if(document.contactO.PaysMembre.value == "")
 {
  alert("\nMerci d'indiquer votre pays .");
  document.contactO.PaysMembre.focus();
  return false;
 }
 
 //vérifie si l'organisme est bien indiqué
 if(document.contactO.OrganismeMembre.value =="")
 {
  alert("\nMerci d'indiquer ce que vous représentez \n entreprise, mairie, association,....");
  document.contactO.OrganismeMembre.focus();
  return false;
 }
  
  
  //si le partenaire n'est pas check mais qu'une sous catégorie est check alors alerte
  if((document.contactO.PartenaireMembre.checked == false) && ((document.contactO.CooperationMembre.checked == true)
  || (document.contactO.SolidaireMembre.checked == true) || (document.contactO.FormationMembre.checked == true) || (document.contactO.AutreMembre.checked == true)))
 {
  alert("\nMerci de cocher partenaire.");
  return false;
 }
 
 
 //si le partenaire est chek mais que rien d'autre n'est chek alors alerte pour demander de faire une séléction
   if((document.contactO.PartenaireMembre.checked == true) && ((document.contactO.CooperationMembre.checked == false)
  && (document.contactO.SolidaireMembre.checked == false) && (document.contactO.FormationMembre.checked == false) && (document.contactO.AutreMembre.checked == false)))
 {
  alert("Vous avez cocher la case partenaire, \n merci de choisir le type de partenariat que vous souhaitez.");
  return false;
 }
 
 return true;
}
</script>

</head>

<body onLoad="test_forward();">

<!-- #include file="grand_header.txt"-->
<div id="contenu">

    <!-- #include file="fichier_menu.txt"-->
    <div id="bandeau_orange">REJOIGNEZ NOUS!</div>
    <div id="container">
      <ul id="menuonglet">
        <li class="menu0">
          <a href="#" id="_0" class="current" onclick="multiClass(this.id)" alt="menu1">Particulier</a>
        </li>
        <li class="menu1">
          <a href="#" id="_1" class="ghost" onclick="multiClass(this.id)" alt="menu1"><% =Server.HtmlEncode("Collectivité locale , Entreprise")%></a>
        </li>
      </ul>
      <hr />
      <div id="menuonglet_0" class="on content">
        <h2>Formulaire d'inscription pour particulier</h2>
		<% response.write "blablablablablabla http:" & http %>
       <!-- #include file="test_p_adhesionP.asp"-->
      </div>
      <div id="menuonglet_1" class="off content">
        <h2><% =Server.HtmlEncode("Formulaire d'inscription pour les entreprises ou collectivités locales.")%></h2>
        <!-- #include file="test_p_adhesionO.asp"-->
      </div>
    </div>

<!-- Ne pas toucher Ã  ce qui suit : placement du footer -->
<!-- #include file="grand_footer.txt"-->
</div>
</body>
</html>