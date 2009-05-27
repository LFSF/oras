<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />
	<!-- #include file="grand_meta.txt"-->
	<title>Rhône-solidarité</title>
	<link href="styles.css" rel="stylesheet" type="text/css" />
	<script language="JavaScript">

function verifform()
{
   if(document.formdetest.mail.value == "")
  {
   alert("Merci d'indiquer votre mail.");
   document.formdetest.mail.focus();
   return false;
  }

 
 adresse_email = document.formdetest.mail.value;
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
    document.formdetest.mail.focus();
	return false;
	}
 }
 </script>
</head>

<body>
	<form name="formdetest" action="desabonnement_newsletter_validation.asp" method="post" OnSubmit="return verifform()">
	  Entrez l'email sur laquelle vous souhaitez vous désabonner :
	  <INPUT id="mail" name="mail" >
	  <br>&nbsp;
	      <INPUT type="submit"   style="BACKGROUND-IMAGE: url(bouton\boutonvide.gif); WIDTH: 120px; CURSOR: hand; COLOR: green; HEIGHT:24px" value="Valider" id=submit2 name=submit2 >
	</form>
</body>

</html>
