<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<!-- #include file="connexion.asp"-->

<meta http-equiv="content-type" content="text/html; charset=iso-8859-1" />

<title>Rhône-solidarité</title>

<link href="styles.css" rel="stylesheet" type="text/css" />
</head>

<body>

<!-- #include file="grand_header.txt"-->

<div id="contenu">

<!-- #include file="fichier_menu.txt"-->

<div id="bandeau_orange">Espace Membres</div>

<table border="0px" width="100%" cellpadding="10px">
	
	<tr>
    	<td colspan="2"><font color="#6faa06">Validation création________________________________________________________</font></td>
    </tr>
   <tr>
				<td width=82%>
	  <div align="justify">
        
        <!---------------------------------------------AJOUT CORPS DE TEXTE IMPORTE DE ORAS----------------------------->
		
		<A href="p_accueil.asp"><font size=1><b>
                         << Retour à l'Accueil &nbsp;</b></font>
                          </a></td></tr>
	</table>
	<table width="400" border="0" valign="center" align="center">
	<tr><td>
	Votre demande a bien été enregistré.
<br>Un mail vous à été envoyé à cette adresse : <%=session("MailCrea")%>
<br>Merci pour la confiance que vous nous accordez.




	</td></tr>
	

</table>

 

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />


<%

Session.Contents.Remove("CivCrea")
Session.Contents.Remove("NomCrea")
Session.Contents.Remove("PrenomCrea")
Session.Contents.Remove("FonctionCrea")
Session.Contents.Remove("SocieteCrea")
Session.Contents.Remove("AdrCrea")
Session.Contents.Remove("CpCrea")
Session.Contents.Remove("VilleCrea")
Session.Contents.Remove("MailCrea")
Session.Contents.Remove("FixeCrea")
Session.Contents.Remove("PortableCrea")
Session.Contents.Remove("ProjetCrea")
Session.Contents.Remove("DemandeCrea")
Session.Contents.Remove("BudgetCrea")
Session.Contents.Remove("DelaiCrea")
Session.Contents.Remove("CommentCrea")
%>


<!-- #include file="grand_footer.txt"-->  
</div>

</body>

  
<!-- #include file="deconnexion.asp"-->

</html>